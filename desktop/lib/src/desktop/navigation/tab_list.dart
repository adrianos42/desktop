import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../theme/theme.dart';
import 'tab_view.dart';

//import 'nav_view.dart';
//import 'nav_scope.dart';

//export 'nav_view.dart' show NavMenuRoute;
//export 'nav_scope.dart' show NavScope;

// TODO(as): ???
// const Duration _kMenuDuration = Duration(microseconds: 200);
// const double _kDividerThickness = 1.0;
const double _kMenuWidthStep = 120.0;
// const double _kDividerHeight = 1.0;

const double _kMenuHorizontalPadding = 16.0;
const double _kMinMenuWidth = 2.0 * _kMenuWidthStep;
const double _kMaxMenuWidth = 6.0 * _kMenuWidthStep;
const double _kDefaultItemHeight = 34.0;
// const double _kMinMenuHeight = _kDefaultItemHeight;
// const double _kMaxMenuHeight = _kDefaultItemHeight;

const int _kIntialIndexValue = 0;

class TabListItem {
  const TabListItem({
    required this.builder,
    required this.title,
    required this.route,
  });

  final WidgetBuilder builder;
  final WidgetBuilder title;
  final String route;
}

class TabList extends StatefulWidget {
  const TabList({
    Key? key,
    required this.tabItems,
  })  : assert(tabItems.length > 0),
        super(key: key);

  final List<TabListItem> tabItems;

  @override
  _TabListState createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  int _index = _kIntialIndexValue;

  int get _length => widget.tabItems.length;

  final List<FocusScopeNode> _focusNodes = <FocusScopeNode>[];
  final List<FocusScopeNode> _disposedFocusNodes = <FocusScopeNode>[];
  final List<bool> _shouldBuildView = <bool>[];
  final List<GlobalKey<NavigatorState>> _navigators =
      <GlobalKey<NavigatorState>>[];

  void _indexChanged(int index) {
    if (index != _index) {
      setState(() {
        _index = index;
        _focusView();
      });
    }
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

    _navigators.addAll(List<GlobalKey<NavigatorState>>.generate(
        _length, (_) => GlobalKey<NavigatorState>()));
    _shouldBuildView.addAll(List<bool>.filled(_length, false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusView();
  }

  @override
  void didUpdateWidget(TabList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.tabItems.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(List<bool>.filled(
          widget.tabItems.length - _shouldBuildView.length, false));
    } else {
      _shouldBuildView.removeRange(
          widget.tabItems.length, _shouldBuildView.length);
    }

    if (widget.tabItems.length - _navigators.length > 0) {
      _navigators.addAll(List<GlobalKey<NavigatorState>>.generate(
          widget.tabItems.length - _navigators.length,
          (index) => GlobalKey<NavigatorState>()));
    } else {
      _navigators.removeRange(widget.tabItems.length, _navigators.length);
    }

    _focusView();
  }

  @override
  void dispose() {
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (final focusNode in _disposedFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
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
                    ? TabView(
                        builder: widget.tabItems[index].builder,
                        //name: widget.navItems[index].route,
                        navigatorKey: _navigators[index],
                      )
                    : Container();
              },
            ),
          ),
        ),
      );
    });

    final Widget result = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _MenuItem(
          items: widget.tabItems.map((value) => value.title).toList(),
          index: _index,
          changeIndex: (value) => _indexChanged(value),
        ),
        Expanded(
          child: Stack(children: list),
        ),
      ],
    );

    return SingleChildScrollView(
      child: SizedBox(
        height: 600.0,
        child: result,
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
  const _MenuItem({
    Key? key,
    required this.index,
    required this.items,
    required this.changeIndex,
  }) : super(key: key);

  final int index;

  final List<WidgetBuilder> items;

  final ValueChanged<int> changeIndex;

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> with ComponentStateMixin {
  int _hoveredIndex = -1;
  int _pressedIndex = -1;

  List<Widget> createList() {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final TextStyle textStyle = textTheme.body1.copyWith(fontSize: 14.0);
    final ColorScheme colorScheme = themeData.colorScheme;
    final HSLColor selectedColor = colorScheme.primary1;

    return List<Widget>.generate(widget.items.length, (index) {
      final bool selected = index == widget.index;
      final pressed = _pressedIndex == index;
      final hovered = _hoveredIndex == index;

      final HSLColor? background = selected
          ? selectedColor
          : pressed
              ? colorScheme.background2
              : hovered
                  ? colorScheme.background1
                  : null;

      final HSLColor foreground = pressed || selected
          ? textTheme.textHigh
          : hovered
              ? textTheme.textMedium
              : textTheme.textLow;

      Widget item = DefaultTextStyle(
        style: textStyle.copyWith(color: foreground.toColor()),
        child: Container(
          color: background?.toColor(),
          padding:
              const EdgeInsets.symmetric(horizontal: _kMenuHorizontalPadding),
          alignment: AlignmentDirectional.centerStart,
          constraints: const BoxConstraints(minHeight: _kDefaultItemHeight),
          child: widget.items[index](context),
        ),
      );

      item = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hoveredIndex = index),
        onExit: (_) => setState(() => _hoveredIndex = -1),
        opaque: false,
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: () => widget.changeIndex(index),
          onTapDown: (_) => setState(() => _pressedIndex = index),
          onTapUp: (_) => setState(() => _pressedIndex = -1),
          onTapCancel: () => setState(() => _pressedIndex = -1),
          child: item,
        ),
      );

      return item;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Widget child = ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: _kMinMenuWidth,
        maxWidth: _kMaxMenuWidth,
      ),
      child: IntrinsicWidth(
        //stepWidth: kMenuWidthStep,
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: 'w',
          child: SingleChildScrollView(
            child: ListBody(
              children: createList(),
            ),
          ),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        //color: colorScheme.overlay2,
        border: Border(
          right: BorderSide(
            color: colorScheme.overlay2.toColor(),
            width: 1.0,
          ),
        ),
      ),
      //margin: EdgeInsets.only(right: 1.0),
      child: child,
    );
  }
}
