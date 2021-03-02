import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';

import 'route.dart';
import 'tab_i.dart';
import 'nav_scope.dart';

const int _kIntialIndexValue = 0;
const double _kTabHeight = 38.0;
const EdgeInsets _khorizontalPadding = EdgeInsets.symmetric(horizontal: 8.0);

// class SetTabAction extends Action {
//   const SetTabAction() : super(key);

//   static const LocalKey key = ValueKey<Type>(SetTabAction);

//   @override
//   void invoke(FocusNode node, SetTabIntent intent) =>
//       Tab._of(node.context)._indexChanged(intent.index);
// }

// class SetTabIntent extends Intent {
//   const SetTabIntent(this.index)
//       : assert(index != null),
//         super(SetTabAction.key);

//   final int index;
// }

class TabItem {
  const TabItem({
    required this.builder,
    required this.title,
    this.tabTrailing,
  });

  final WidgetBuilder builder;

  final WidgetBuilder? tabTrailing;

  final Widget title;
}

class Tab extends StatefulWidget {
  const Tab({
    Key? key,
    required this.items,
    this.trailing,
  })  : assert(items.length > 0),
        super(key: key);

  final List<TabItem> items;

  final WidgetBuilder? trailing;

  @override
  _TabState createState() => _TabState();

  static _TabState? _of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TabScope>()?.tabState;
}

class _TabScope extends InheritedWidget {
  const _TabScope({
    Key? key,
    required this.tabState,
    required Widget child,
  }) : super(key: key, child: child);

  final _TabState tabState;

  @override
  bool updateShouldNotify(_TabScope old) => old.tabState != tabState;
}

class _TabState extends State<Tab> {
  final List<FocusScopeNode> _focusNodes = <FocusScopeNode>[];
  final List<FocusScopeNode> _disposedFocusNodes = <FocusScopeNode>[];
  final List<bool> _shouldBuildView = <bool>[];
  final List<GlobalKey<NavigatorState>> _navigators =
      <GlobalKey<NavigatorState>>[];

  int _index = _kIntialIndexValue;

  int get _length => widget.items.length;

  NavigatorState? get _currentNavigator => _navigators[_index].currentState;

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
  void didUpdateWidget(Tab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(List<bool>.filled(
          widget.items.length - _shouldBuildView.length, false));
    } else {
      _shouldBuildView.removeRange(
          widget.items.length, _shouldBuildView.length);
    }

    if (widget.items.length - _navigators.length > 0) {
      _navigators.addAll(List<GlobalKey<NavigatorState>>.generate(
          widget.items.length - _navigators.length,
          (index) => GlobalKey<NavigatorState>()));
    } else {
      _navigators.removeRange(widget.items.length, _navigators.length);
    }

    _focusView();
  }

  @override
  void dispose() {
    super.dispose();

    for (var focusNode in _focusNodes) focusNode.dispose();
    for (var focusNode in _disposedFocusNodes) focusNode.dispose();
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
                        builder: widget.items[index].builder,
                        //name: widget.items[index].route,
                        navigatorKey: _navigators[index],
                        navigatorObserver: TabObserver(),
                      )
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
          trailing: widget.items[_index].tabTrailing ?? widget.trailing,
          changeIndex: (value) => _indexChanged(value),
          items: List<Widget>.generate(
            _length,
            (index) => widget.items[index].title,
          ),
        ),
        Expanded(
          child: Stack(
            children: list,
          ),
        ),
      ],
    );

    result = _TabScope(
      child: result,
      tabState: this,
    );

    result = NavigationScope(
      child: result,
      navigatorKey: _navigators[_index],
      navAxis: Axis.horizontal,
    );

    return result;
  }
}

class _TabGroup extends StatefulWidget {
  const _TabGroup({
    Key? key,
    required this.index,
    required this.items,
    required this.changeIndex,
    this.trailing,
  }) : super(key: key);

  final int index;

  final List<Widget> items;

  final WidgetBuilder? trailing;

  final ValueChanged<int> changeIndex;

  @override
  _TabGroupState createState() => _TabGroupState();
}

class _TabGroupState extends State<_TabGroup> {
  int _hoveredIndex = -1;
  int _pressedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(_TabGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    List<Widget> list = List<Widget>.generate(widget.items.length, (index) {
      final HSLColor foreground = widget.index == index || _pressedIndex == index
          ? colorScheme.primary
          : _hoveredIndex == index
              ? textTheme.textHigh
              : textTheme.textLow;

      final TextStyle textStyle = textTheme.body2.copyWith(color: foreground.toColor());
      final IconThemeData iconThemeData = IconThemeData(
        color: foreground.toColor(),
        size: 18.0,
      );

      return Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hoveredIndex = index),
          onExit: (_) => setState(() => _hoveredIndex = -1),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) => setState(() => _pressedIndex = index),
            onTapUp: (_) => setState(() => _pressedIndex = -1),
            onTapCancel: () => setState(() => _pressedIndex = -1),
            onTap: () => widget.changeIndex(index),
            child: DefaultTextStyle(
              style: textStyle,
              child: IconTheme(
                data: iconThemeData,
                child: widget.items[index],
              ),
            ),
          ),
        ),
      );
    });

    Widget result = Container(
      height: _kTabHeight,
      color: colorScheme.background.toColor(),
      child: Padding(
        padding: _khorizontalPadding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ...list,
            Spacer(),
            if (widget.trailing != null) widget.trailing!(context), // TODO
          ],
        ),
      ),
    );

    return result;
  }
}
