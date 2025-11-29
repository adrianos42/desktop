import 'dart:math' as math;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../input/input.dart';
import '../theme/theme.dart';

const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

/// Represents a item in a tab bar.
/// See:
///   [NavBar]
class NavBarItem {
  /// Creates a [NavBarItem].
  const NavBarItem({required this.title, required this.builder});

  final String title;

  final WidgetBuilder builder;
}

class NavBar extends StatefulWidget {
  ///
  const NavBar({super.key, required this.items, this.controller})
    : assert(items.length > 0);

  /// Nav bar items.
  final List<NavBarItem> items;

  /// Controls selected index.
  final PageController? controller;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  final List<bool> _shouldBuildView = <bool>[];

  PageController? _internalController;
  PageController get _controller => widget.controller ?? _internalController!;

  int get _length => widget.items.length;

  int get _page => _currentPage ?? _controller.initialPage;
  int? _currentPage;

  // late Map<Type, Action<Intent>> _actionMap;

  // void _nextView() => _indexChanged((_index + 1) % _length);

  // void _previousView() => _indexChanged((_index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _controller.page) {
      if (index < 0 ||
          index >= _length ||
          Navigator.of(context, rootNavigator: true).canPop()) {
        return false;
      }

      setState(() => _currentPage = index);

      _controller
          .animateToPage(
            index,
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: 400),
          );

      return true;
    }

    return false;
  }

  Widget _createPageEntry(int index) {
    return Builder(
      builder: (context) {
        final int page = _controller.page?.toInt() ?? 0;
        _shouldBuildView[index] =
            (index >= page - 1 && index <= page + 1) || _shouldBuildView[index];
        final bool active = _shouldBuildView[index];

        return Offstage(
          offstage: !active,
          child: TickerMode(
            enabled: active,
            child: Builder(
              builder: active
                  ? (context) => widget.items[index].builder(context)
                  : (context) => const SizedBox(),
            ),
          ),
        );
      },
    );
  }

  Widget _createTabBar() {
    final List<Widget> tabItems = List<Widget>.generate(widget.items.length, (
      index,
    ) {
      final bool active = _page == index;
      final ThemeData themeData = Theme.of(context);
      final TextTheme textTheme = themeData.textTheme;

      return ButtonTheme(
        data: ButtonThemeData(
          textStyle: textTheme.header.copyWith(fontWeight: FontWeight.w200),
          color: themeData.textTheme.textHigh,
          highlightColor: themeData.textTheme.textLow,
          hoverColor: themeData.textTheme.textHigh,
          animationDuration: Duration.zero,
        ),
        child: Button(
          filled: false,
          onPressed: () => _indexChanged(index),
          active: active,
          body: Builder(
            builder: (context) => Container(
              alignment: Alignment.center,
              child: Text(widget.items[index].title),
            ),
          ),
          //bodyPadding: EdgeInsets.zero,
          leadingPadding: EdgeInsets.zero,
          trailingPadding: EdgeInsets.zero,
          //padding: EdgeInsets.zero,
        ),
      );
    });

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0, left: 4.0, right: 4.0, top: 4.0),
      child: ClipRect(
        child: OverflowBox(
          fit: OverflowBoxFit.deferToChild,
          maxWidth: double.infinity,
          alignment: AlignmentGeometry.topLeft,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tabItems,
          ),
        ),
      ),
    );
  }

  void _updateTabController([PageController? oldWidgetController]) {
    if (widget.controller == null && _internalController == null) {
      _internalController = PageController(initialPage: 0);
    }
    if (widget.controller != null && _internalController != null) {
      _internalController!.dispose();
      _internalController = null;
    }
  }

  @override
  void initState() {
    super.initState();

    _shouldBuildView.addAll(List<bool>.filled(_length, false));
    _updateTabController();
  }

  @override
  void didUpdateWidget(NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(
        List<bool>.filled(widget.items.length - _shouldBuildView.length, false),
      );
    } else if (widget.items.length - _shouldBuildView.length < 0) {
      _shouldBuildView.removeRange(
        widget.items.length,
        _shouldBuildView.length,
      );
    }

    if (widget.controller != oldWidget.controller) {
      _updateTabController(oldWidget.controller);
    } else {
      final int index = math.min(
        _controller.page!.toInt(),
        widget.items.length - 1,
      );
      if (index != _controller.page) {
        _controller.jumpToPage(index);
      }
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    final AxisDirection axisDirection = textDirectionToAxisDirection(
      textDirection,
    );

    final ScrollPhysics physics = const _ForceImplicitScrollPhysics(
      allowImplicitScrolling: true,
    ).applyTo(_kPagePhysics.applyTo(null));

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _createTabBar(),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification.depth == 0 &&
                  notification is ScrollEndNotification) {
                final PageMetrics metrics = notification.metrics as PageMetrics;
                final int currentPage = metrics.page!.round();

                assert(currentPage >= 0 && currentPage < _length);

                if (currentPage != _currentPage) {
                  setState(() => _currentPage = currentPage);
                }
              }
              return false;
            },
            child: Scrollable(
              dragStartBehavior: DragStartBehavior.start,
              axisDirection: axisDirection,
              controller: _controller,
              physics: physics,
              // restorationId: widget.restorationId,
              hitTestBehavior: HitTestBehavior.opaque,
              scrollBehavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              viewportBuilder: (BuildContext context, ViewportOffset position) {
                return Viewport(
                  cacheExtent: 1.0,
                  cacheExtentStyle: CacheExtentStyle.viewport,
                  axisDirection: axisDirection,
                  offset: position,
                  clipBehavior: Clip.hardEdge,
                  slivers: <Widget>[
                    SliverFillViewport(
                      viewportFraction: _controller.viewportFraction,
                      delegate: SliverChildListDelegate(
                        List<Widget>.generate(
                          _length,
                          (index) => _createPageEntry(index),
                        ),
                      ),
                      padEnds: false,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ForceImplicitScrollPhysics extends ScrollPhysics {
  const _ForceImplicitScrollPhysics({
    required this.allowImplicitScrolling,
    super.parent,
  });

  @override
  _ForceImplicitScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _ForceImplicitScrollPhysics(
      allowImplicitScrolling: allowImplicitScrolling,
      parent: buildParent(ancestor),
    );
  }

  @override
  final bool allowImplicitScrolling;
}
