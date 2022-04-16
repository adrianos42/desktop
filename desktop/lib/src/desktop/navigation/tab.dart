import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../input/input.dart';
import '../theme/theme.dart';
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
    required this.itemBuilder,
  });

  /// The 'page' used for the tab.
  final IndexedWidgetBuilder builder;

  /// A custom item to be built for the tab bar.
  final IndexedWidgetBuilder itemBuilder;
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
///       builder: (context, _) => Center(child: Text('page1')),
///       title: Text('page1'),
///     ),
///     TabItem(
///       builder: (context, _) => Center(child: Text('page2')),
///       title: Text('page2'),
///     ),
///     TabItem(
///       builder: (context, _) => Center(child: Text('page3')),
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
    this.backgroundColor,
    this.padding,
    this.itemPadding,
    this.height,
  })  : assert(items.length > 0),
        super(key: key);

  /// Tab items.
  final List<TabItem> items;

  /// The trailing widget that will placed at the end of the tab bar.
  final WidgetBuilder? trailing;

  /// The background color for the tab bar.
  final Color? backgroundColor;

  /// The tab bar padding.
  final EdgeInsets? padding;

  /// The tab item padding.
  final EdgeInsets? itemPadding;

  /// The tab height.
  final double? height;

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
  final List<bool> _shouldBuildView = <bool>[];

  int _index = _kIntialIndexValue;

  // late Map<Type, Action<Intent>> _actionMap;

  int get _length => widget.items.length;

  // void _nextView() => _indexChanged((_index + 1) % _length);

  // void _previousView() => _indexChanged((_index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _index) {
      if (index < 0 ||
          index >= _length ||
          Navigator.of(context, rootNavigator: true).canPop()) {
        return false;
      }

      setState(() => _index = index);

      return true;
    }

    return false;
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

    _index = math.min(_index, widget.items.length - 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TabThemeData tabThemeData = TabTheme.of(context);

    final list = List<Widget>.generate(_length, (index) {
      final bool active = index == _index;
      _shouldBuildView[index] = active || _shouldBuildView[index];

      return Offstage(
        offstage: !active,
        child: TickerMode(
          enabled: active,
          child: Builder(
            builder: (context) {
              return _shouldBuildView[index]
                  ? widget.items[index].builder(context, index)
                  : Container();
            },
          ),
        ),
      );
    });

    Widget result = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _TabGroup(
          index: _index,
          trailing: widget.trailing,
          height: widget.height,
          background: widget.backgroundColor,
          changeIndex: (value) => _indexChanged(value),
          padding: widget.padding,
          items: List<IndexedWidgetBuilder>.generate(
            _length,
            (index) => (context, index) => Container(
                  alignment: Alignment.center,
                  padding: widget.itemPadding ??
                      EdgeInsets.symmetric(
                        horizontal: tabThemeData.itemSpacing!,
                      ),
                  child: widget.items[index].itemBuilder(context, index),
                ),
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

    return result;
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
    this.height,
  }) : super(key: key);

  final int index;

  final List<IndexedWidgetBuilder> items;

  final WidgetBuilder? trailing;

  final ValueChanged<int> changeIndex;

  final Color? background;

  final EdgeInsets? padding;

  final double? height;

  @override
  _TabGroupState createState() => _TabGroupState();
}

class _TabGroupState extends State<_TabGroup> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final TabThemeData tabThemeData = TabTheme.of(context);

    final List<Widget> list =
        List<Widget>.generate(widget.items.length, (index) {
      final active = widget.index == index;

      return ButtonTheme.merge(
        data: ButtonThemeData(
          color: tabThemeData.color!,
          highlightColor: tabThemeData.highlightColor!,
          hoverColor: tabThemeData.hoverColor!,
        ),
        child: Button(
          onPressed: () => widget.changeIndex(index),
          active: active,
          body: Builder(
            builder: (context) => widget.items[index](context, index),
          ),
          bodyPadding: EdgeInsets.zero,
          leadingPadding: EdgeInsets.zero,
          trailingPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
      );
    });

    final Widget result = Container(
      padding: widget.padding ?? EdgeInsets.zero,
      height: widget.height ?? tabThemeData.height!,
      color: widget.background ?? tabThemeData.backgroundColor!,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: list,
                ),
              ),
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
            ),
          ),
          if (widget.trailing != null) widget.trailing!(context),
        ],
      ),
    );

    return result;
  }
}
