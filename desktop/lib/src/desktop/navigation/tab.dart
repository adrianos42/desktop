import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

import 'route.dart';
import 'tab_view.dart';
import 'tab_scope.dart';
import '../component.dart';

const int _kIntialIndexValue = 0;
const double _kTabHeight = 38.0;
const EdgeInsets _khorizontalPadding = EdgeInsets.symmetric(horizontal: 8.0);

typedef TabItemBuilder = Widget Function(
    BuildContext context, int index, bool isActive);

class TabItem {
  const TabItem({
    required this.builder,
    required this.tabItemBuilder,
  });

  /// The 'page' used for the tab.
  final IndexedWidgetBuilder builder;

  /// A custom item to be built for the tab bar.
  final TabItemBuilder tabItemBuilder;

  factory TabItem.text(String text, {required IndexedWidgetBuilder builder}) {
    return TabItem(
      builder: builder,
      tabItemBuilder: (context, _, isActive) => _TabItemButton(
        Text(text),
        active: isActive,
      ),
    );
  }

  factory TabItem.icon(IconData icon, {required IndexedWidgetBuilder builder}) {
    return TabItem(
      builder: builder,
      tabItemBuilder: (context, _, isActive) => _TabItemButton(
        Icon(icon),
        active: isActive,
      ),
    );
  }
}

/// Navigation tab.
///
/// The difference with [Nav], is that [Tab] is simpler and only supports horizontal axis for the item
/// and widgets may also be used as tabs, meanwhile only text can be used in [Nav] bar.
///
/// ```dart
/// Tab(
///   items: [
///     TabItem(
///       builder: (context) => Center(child: Text('page1')),
///       title: Text('page1'),
///     ),
///     TabItem(
///       builder: (context) => Center(child: Text('page2')),
///       title: Text('page2'),
///     ),
///     TabItem(
///       builder: (context) => Center(child: Text('page3')),
///       title: Text('page3'),
///     ),
///   ],
/// )```
class Tab extends StatefulWidget {
  const Tab({
    Key? key,
    required this.items,
    this.trailing,
    this.focusNode,
    this.color,
    this.autofocus = true,
  })  : assert(items.length > 0),
        super(key: key);

  /// Tab items.
  final List<TabItem> items;

  /// The trailing widget that will placed at the end of the tab bar.
  final WidgetBuilder? trailing;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final bool autofocus;

  /// The background color for the tab bar.
  final HSLColor? color;

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  final List<FocusScopeNode> _focusNodes = <FocusScopeNode>[];
  final List<FocusScopeNode> _disposedFocusNodes = <FocusScopeNode>[];
  final List<bool> _shouldBuildView = <bool>[];

  int _index = _kIntialIndexValue;

  late Map<Type, Action<Intent>> _actionMap;

  int get _length => widget.items.length;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  void _nextView() => _indexChanged((_index + 1) % _length);

  void _previousView() => _indexChanged((_index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _index) {
      if (index < 0 ||
          index >= _length ||
          Navigator.of(context, rootNavigator: true).canPop()) return false;

      setState(() {
        _index = index;
        _focusView();
      });

      return true;
    }

    return false;
  }

  void _focusView() {
    if (_focusNodes.length != _length) {
      if (_length < _focusNodes.length) {
        _disposedFocusNodes.addAll(_focusNodes.sublist(_length));
        _focusNodes.removeRange(_length, _focusNodes.length);
      } else {
        _focusNodes.addAll(
          List<FocusScopeNode>.generate(
            _length - _focusNodes.length,
            (index) => FocusScopeNode(
              skipTraversal: true,
              debugLabel: 'Tab ${index + _focusNodes.length}',
            ),
          ),
        );
      }
    }

    FocusScope.of(context).setFirstFocus(_focusNodes[_index]);
  }

  @override
  void initState() {
    super.initState();

    _actionMap = <Type, Action<Intent>>{
      NextTabIntent:
          CallbackAction<NextTabIntent>(onInvoke: (_) => _nextView()),
      PreviousTabIntent:
          CallbackAction<PreviousTabIntent>(onInvoke: (_) => _previousView()),
    };

    _shouldBuildView.addAll(List<bool>.filled(_length, false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusView();
  }

  @override
  void didUpdateWidget(Tab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(List<bool>.filled(
          widget.items.length - _shouldBuildView.length, false));
    } else {
      _shouldBuildView.removeRange(
          widget.items.length, _shouldBuildView.length);
    }

    _focusView();
  }

  @override
  void dispose() {
    super.dispose();

    for (final focusNode in _focusNodes) focusNode.dispose();
    for (final focusNode in _disposedFocusNodes) focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = List<Widget>.generate(_length, (index) {
      final bool active = index == _index;
      _shouldBuildView[index] = active || _shouldBuildView[index];

      return Offstage(
        offstage: !active,
        child: TickerMode(
          enabled: active,
          child: FocusScope(
            node: _focusNodes[index],
            canRequestFocus: active,
            child: Builder(
              builder: (context) {
                return _shouldBuildView[index]
                    ? widget.items[index].builder(context, index)
                    : Container();
              },
            ),
          ),
        ),
      );
    });

    Widget result = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _TabGroup(
          index: _index,
          trailing: widget.trailing,
          color: widget.color,
          changeIndex: (value) => _indexChanged(value),
          items: List<TabItemBuilder>.generate(
            _length,
            (index) => widget.items[index].tabItemBuilder,
          ),
        ),
        Expanded(
          child: Stack(
            children: list,
            fit: StackFit.expand,
          ),
        ),
      ],
    );

    result = TabScope(
      child: result,
      currentIndex: _index,
      axis: Axis.horizontal,
    );

    return FocusableActionDetector(
      child: result,
      focusNode: _effectiveFocusNode,
      autofocus: widget.autofocus,
      onShowFocusHighlight: (_) {},
      onFocusChange: (_) {},
      onShowHoverHighlight: (value) {
        if (value) {
          FocusScope.of(context).requestFocus(_effectiveFocusNode);
        }
      },
      actions: _actionMap,
    );
  }
}

class _TabGroup extends StatefulWidget {
  const _TabGroup({
    Key? key,
    required this.index,
    required this.items,
    required this.changeIndex,
    this.color,
    this.trailing,
  }) : super(key: key);

  final int index;

  final List<TabItemBuilder> items;

  final WidgetBuilder? trailing;

  final ValueChanged<int> changeIndex;

  final HSLColor? color;

  @override
  _TabGroupState createState() => _TabGroupState();
}

class _TabGroupState extends State<_TabGroup> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    List<Widget> list = List<Widget>.generate(widget.items.length, (index) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => widget.changeIndex(index),
          child: widget.items[index](context, index, index == widget.index),
        ),
      );
    });

    Widget result = Container(
      height: _kTabHeight,
      color: widget.color?.toColor() ?? colorScheme.background.toColor(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...list,
          Spacer(),
          if (widget.trailing != null) widget.trailing!(context),
        ],
      ),
    );

    return result;
  }
}

class _TabItemButton extends StatefulWidget {
  const _TabItemButton(
    this.child, {
    Key? key,
    required this.active,
  }) : super(key: key);

  final Widget child;

  final bool active;

  @override
  _TabItemButtonState createState() => _TabItemButtonState();
}

class _TabItemButtonState extends State<_TabItemButton>
    with ComponentStateMixin, SingleTickerProviderStateMixin {
  void _handleHoverEntered() {
    if (!hovered && (pressed || !_globalPointerDown)) {
      _controller.reset();
      _controller.forward();
      setState(() => hovered = true);
    }
  }

  void _handleHoverExited() {
    if (hovered) {
      _controller.reset();
      _controller.forward();
      setState(() => hovered = false);
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (pressed) {
      _controller.reset();
      _controller.forward();
      setState(() => pressed = false);
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      _controller.reset();
      _controller.forward();
      setState(() => pressed = true);
    }
  }

  void _handleTapCancel() {
    if (pressed) {
      _controller.reset();
      _controller.forward();
      setState(() => pressed = false);
    }
  }

  bool _globalPointerDown = false;

  void _mouseRoute(event) => _globalPointerDown = event.down;

  late AnimationController _controller;

  ColorTween? _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
    );

    _controller.forward();

    WidgetsBinding.instance!.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance!.pointerRouter.removeGlobalRoute(_mouseRoute);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _color = null;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    final highlightColor = colorScheme.primary1;
    final color = textTheme.textLow;
    final hoverColor = textTheme.textHigh;

    final HSLColor foregroundColor =
        pressed || hovered && widget.active || widget.active
            ? highlightColor
            : hovered
                ? hoverColor
                : color;

    _color = ColorTween(
        begin: _color?.end ?? foregroundColor.toColor(),
        end: foregroundColor.toColor());

    Widget result = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final foreground =
            _color!.evaluate(AlwaysStoppedAnimation(_controller.value));

        final TextStyle textStyle = textTheme.body2.copyWith(color: foreground);
        final IconThemeData iconThemeData =
            IconThemeData(size: 18.0, color: foreground);

        return DefaultTextStyle(
          style: textStyle,
          child: IconTheme(
            data: iconThemeData,
            child: Container(
              alignment: Alignment.center,
              padding: _khorizontalPadding,
              child: widget.child,
            ),
          ),
        );
      },
    );

    result = MouseRegion(
      onEnter: (_) => _handleHoverEntered(),
      onExit: (_) => _handleHoverExited(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        //onTapDown: _handleTapDown,
        //onTapUp: _handleTapUp,
        //onTapCancel: _handleTapCancel,
        child: result,
      ),
    );

    return Semantics(
      button: true,
      child: result,
    );
  }
}
