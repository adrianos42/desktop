import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../input/input.dart';
import '../theme/theme.dart';
import 'route.dart';
import 'tab_scope.dart';
import 'tab_view.dart';

const int _kIntialIndexValue = 0;

/// Represents a item in a tab bar.
/// See:
///   [Tab]
class TabItem {
  /// If it's necessary to use the index of each tab, then use this builder.
  const TabItem({
    required this.builder,
    required this.tabItemBuilder,
  });

  /// Creates a tab item with text.
  factory TabItem.text(
    String text, {
    WidgetBuilder? builder,
    GlobalKey<NavigatorState>? navigatorKey,
    String? defaultTitle,
    Map<String, WidgetBuilder>? routes,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
  }) {
    return TabItem(
      builder: (BuildContext context, _) => TabView(
        builder: builder,
        navigatorKey: navigatorKey,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        defaultTitle: defaultTitle,
        navigatorObservers: navigatorObservers,
      ),
      tabItemBuilder: (context, _) => TabItemText(text),
    );
  }

  /// Creates a tab item with a icon.
  factory TabItem.icon(
    IconData icon, {
    WidgetBuilder? builder,
    GlobalKey<NavigatorState>? navigatorKey,
    String? defaultTitle,
    Map<String, WidgetBuilder>? routes,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
  }) {
    return TabItem(
      builder: (BuildContext context, _) => TabView(
        builder: builder,
        navigatorKey: navigatorKey,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        defaultTitle: defaultTitle,
        navigatorObservers: navigatorObservers,
      ),
      tabItemBuilder: (context, _) => TabItemIcon(icon),
    );
  }

  /// Creates a tab item with a custom widget.
  factory TabItem.custom(
    IndexedWidgetBuilder tabBuilder, {
    WidgetBuilder? builder,
    GlobalKey<NavigatorState>? navigatorKey,
    String? defaultTitle,
    Map<String, WidgetBuilder>? routes,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
  }) {
    return TabItem(
      builder: (BuildContext context, _) => TabView(
        builder: builder,
        navigatorKey: navigatorKey,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        defaultTitle: defaultTitle,
        navigatorObservers: navigatorObservers,
      ),
      tabItemBuilder: tabBuilder,
    );
  }

  /// The 'page' used for the tab.
  final IndexedWidgetBuilder builder;

  /// A custom item to be built for the tab bar.
  final IndexedWidgetBuilder tabItemBuilder;
}

/// The default text style used for tab item. Use [TabItem.text] instead.
class TabItemText extends StatelessWidget {
  ///
  const TabItemText(this.text, {Key? key}) : super(key: key);

  /// The displayed in the tab.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: TabTheme.of(context).itemSpacing!,
      ),
      child: Text(text),
    );
  }
}

/// The default icon style used for tab item. Use [TabItem.icon] instead.
class TabItemIcon extends StatelessWidget {
  ///
  const TabItemIcon(this.icon, {Key? key}) : super(key: key);

  /// The displayed in the tab.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: TabTheme.of(context).itemSpacing!,
      ),
      child: Icon(icon),
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
  ///
  const Tab({
    Key? key,
    required this.items,
    this.trailing,
    this.focusNode,
    this.backgroundColor,
    this.padding,
    this.autofocus = false,
  })  : assert(items.length > 0),
        super(key: key);

  /// Tab items.
  final List<TabItem> items;

  /// The trailing widget that will placed at the end of the tab bar.
  final WidgetBuilder? trailing;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// If the widget receives focus automatically.
  final bool autofocus;

  /// The background color for the tab bar.
  final HSLColor? backgroundColor;

  /// The tab bar padding.
  final EdgeInsets? padding;

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  final List<FocusScopeNode> _focusNodes = <FocusScopeNode>[];
  final List<FocusScopeNode> _disposedFocusNodes = <FocusScopeNode>[];
  final List<bool> _shouldBuildView = <bool>[];

  int _index = _kIntialIndexValue;

  // late Map<Type, Action<Intent>> _actionMap;

  int get _length => widget.items.length;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode(skipTraversal: true));

  void _nextView() => _indexChanged((_index + 1) % _length);

  void _previousView() => _indexChanged((_index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _index) {
      if (index < 0 ||
          index >= _length ||
          Navigator.of(context, rootNavigator: true).canPop()) {
        return false;
      }

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

    // _actionMap = <Type, Action<Intent>>{
    //   NextTabIntent:
    //       CallbackAction<NextTabIntent>(onInvoke: (_) => _nextView()),
    //   PreviousTabIntent:
    //       CallbackAction<PreviousTabIntent>(onInvoke: (_) => _previousView()),
    // };

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
    } else if (widget.items.length - _shouldBuildView.length < 0) {
      _shouldBuildView.removeRange(
          widget.items.length, _shouldBuildView.length);
    }

    // TODO(as): See if this is correct when changing the tree.
    _index = math.min(_index, widget.items.length - 1);

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
          background: widget.backgroundColor,
          changeIndex: (value) => _indexChanged(value),
          padding: widget.padding,
          items: List<IndexedWidgetBuilder>.generate(
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
      // onShowHoverHighlight: (value) {
      //   if (value) {
      //     FocusScope.of(context).requestFocus(_effectiveFocusNode);
      //   }
      // },
      // actions: _actionMap,
    );
  }
}

class _TabGroup extends StatefulWidget {
  const _TabGroup({
    Key? key,
    required this.index,
    required this.items,
    required this.changeIndex,
    this.background,
    this.trailing,
    this.padding,
  }) : super(key: key);

  final int index;

  final List<IndexedWidgetBuilder> items;

  final WidgetBuilder? trailing;

  final ValueChanged<int> changeIndex;

  final HSLColor? background;

  final EdgeInsets? padding;

  @override
  _TabGroupState createState() => _TabGroupState();
}

class _TabGroupState extends State<_TabGroup> {
  @override
  Widget build(BuildContext context) {
    final TabThemeData tabThemeData = TabTheme.of(context);

    final List<Widget> list =
        List<Widget>.generate(widget.items.length, (index) {
      final active = widget.index == index;

      final highlightColor = tabThemeData.highlightColor!;
      final hoverColor = active ? highlightColor : tabThemeData.hoverColor!;
      final activeColor = active ? highlightColor : tabThemeData.color!;

      return ButtonTheme.merge(
        data: ButtonThemeData(
          color: activeColor,
          highlightColor: highlightColor,
          hoverColor: hoverColor,
        ),
        child: Button(
          onPressed: () => widget.changeIndex(index),
          body: widget.items[index](context, index),
          bodyPadding: EdgeInsets.zero,
          leadingPadding: EdgeInsets.zero,
          trailingPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
      );
    });

    final Widget result = Container(
      padding: widget.padding ??
          EdgeInsets.symmetric(horizontal: tabThemeData.itemSpacing!),
      height: tabThemeData.height!,
      color: widget.background?.toColor() ??
          tabThemeData.backgroundColor!.toColor(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...list,
          const Spacer(),
          if (widget.trailing != null) widget.trailing!(context),
        ],
      ),
    );

    return result;
  }
}
