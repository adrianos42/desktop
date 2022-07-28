import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../theme/theme.dart';
import 'nav.dart' show NavItem;
import 'bottom_nav_button.dart';
import 'tab_scope.dart';

export 'nav.dart' show NavItem;
export 'tab_scope.dart' show TabScope, RouteBuilder;

const int _kIntialIndexValue = 0;

const Duration _kMenuTransitionDuration = Duration(milliseconds: 400);
const Curve _kDefaultAnimationCurve = Curves.linearToEaseOut;

/// Navigation widget [BottomNav]...
///
///```dart
/// BottomNav(
///   trailingMenu: [
///     NavItem(
///       title: 'home',
///       builder: (context) => NavDialog(
///         child: Container(
///           alignment: Alignment.center,
///           padding: EdgeInsets.all(32.0),
///           width: 600.0,
///           child: Text('Home page'),
///         ),
///       ),
///       icon: Icons.home,
///     ),
///     NavItem(
///       title: 'settings',
///       builder: (context) => NavDialog(
///         child: Container(
///           alignment: Alignment.center,
///           padding: EdgeInsets.all(32.0),
///           width: 600.0,
///           child: Text('Settings page'),
///         ),
///       ),
///       icon: Icons.settings,
///     ),
///   ],
///   items: [
///     NavItem(
///       builder: (context) => Center(child: Text('page1')),
///       title: 'page1',
///       icon: Icons.today,
///     ),
///     NavItem(
///       builder: (context) => Center(child: Text('page2')),
///       title: 'page2',
///       icon: Icons.stars,
///     ),
///     NavItem(
///       builder: (context) => Center(child: Text('page3')),
///       title: 'page3',
///       icon: Icons.share,
///     ),
///   ],
/// )
///```
class BottomNav extends StatefulWidget {
  /// Creates a navigation bar.
  const BottomNav({
    Key? key,
    required this.items,
    required this.trailingMenu,
    this.isBackButtonEnabled,
  })  : assert(items.length > 0),
        super(key: key);

  /// The items with builder and route names for transition among pages.
  final List<NavItem> items;

  /// Menu before the navigation items.
  final NavItem trailingMenu;

  /// If the back button should respond to user input.
  final bool? isBackButtonEnabled;

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  int _index = _kIntialIndexValue;

  int get _length => widget.items.length;

  bool _menuActive = false;
  OverlayEntry? _menuOverlayEntry;

  final List<bool> _shouldBuildView = List<bool>.empty(growable: true);

  final List<OverlayEntry> _overlays = List<OverlayEntry>.empty(growable: true);

  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

  final List<OverlayEntry> _menuOverlays =
      List<OverlayEntry>.empty(growable: true);

  final GlobalKey<OverlayState> _menuOverlayKey = GlobalKey<OverlayState>();

  OverlayState get _menuOverlay => _menuOverlayKey.currentState!;

  late Animation<double> _menuAnimation;
  late AnimationController _menuController;
  late Tween<Offset> _menuOffsetTween;
  final ColorTween _menuColorTween = ColorTween();

  static const Curve _animationCurve = _kDefaultAnimationCurve;

  void _createAnimation() {
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: _animationCurve,
      reverseCurve: _animationCurve.flipped,
    );

    const Offset begin = Offset(0.0, 1.0);
    const Offset end = Offset(0.0, 0.0);

    _menuOffsetTween = Tween<Offset>(
      begin: begin,
      end: end,
    );
  }

  void nextView() => _indexChanged((_index + 1) % _length);

  void previousView() => _indexChanged((_index - 1) % _length);

  bool _indexChanged(int index) {
    if (index != _index) {
      if (index < 0 || index >= _length || _menuActive) {
        return false;
      }

      setState(() => _index = index);

      return true;
    }

    return false;
  }

  void _handleMenuAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && !_menuActive) {
      _menuOverlayEntry?.remove();
      _menuOverlayEntry = null;
    }
  }

  void _hideMenu() {
    setState(() {
      _menuActive = false;
      _menuController.reverse();
    });
  }

  void _showMenu() {
    if (!_menuActive) {
      setState(() {
        _menuActive = true;

        final Color barrierColor = DialogTheme.of(context).barrierColor!;
        _menuColorTween.begin = barrierColor.withOpacity(0.0);
        _menuColorTween.end = barrierColor.withOpacity(0.8);

        _menuOverlayEntry = OverlayEntry(
          maintainState: false,
          builder: (context) => AnimatedBuilder(
            animation: _menuAnimation,
            builder: (context, _) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _hideMenu,
              child: Container(
                alignment: Alignment.bottomCenter,
                color: _menuColorTween.evaluate(_menuAnimation),
                child: GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {}, // TODO(as): Better way to do this?
                  child: ClipRect(
                    child: FractionalTranslation(
                      translation: _menuOffsetTween.evaluate(_menuAnimation),
                      child: widget.trailingMenu.builder(context, 0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        _menuOverlay.insert(_menuOverlayEntry!);
        _menuController.forward(from: 0.0);
      });
    } else {
      _hideMenu();
    }
  }

  Widget _createMenuItem() {
    final NavThemeData navThemeData = NavTheme.of(context);

    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BottomNavMenuButton(
        _menuActive ? Icons.close : Icons.menu,
        active: _menuActive,
        onPressed: _showMenu,
        height: navThemeData.width + 4.0,
      ),
    );
  }

  Widget _createNavItems(EdgeInsets itemsSpacing, NavThemeData navThemeData) {
    return Padding(
      padding: itemsSpacing,
      child: NavBottomGroup(
        navWidgets: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Icon(widget.items[index].icon),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(widget.items[index].title),
              ),
            ],
          );
        },
        enabled: !_menuActive,
        navItems: widget.items,
        index: _index,
        onChanged: (value) => _indexChanged(value),
      ),
    );
  }

  Widget _createNavBar() {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    final NavThemeData navThemeData = NavTheme.of(context);

    final Color backgroundColor = colorScheme.background[0];

    BoxConstraints constraints;
    EdgeInsets itemsSpacing;

    constraints = const BoxConstraints.tightFor(height: 48.0);
    itemsSpacing = const EdgeInsets.symmetric(horizontal: 16.0);

    final navList = <Widget>[];

    navList.add(
      _createNavItems(itemsSpacing, navThemeData),
    );

    Widget result = Container(
      constraints: constraints,
      color: backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: navList,
      ),
    );

    result = ButtonTheme.merge(
      data: ButtonThemeData(
        height: navThemeData.height,
        iconThemeData: navThemeData.iconThemeData,
        color: colorScheme.shade[60],
      ),
      child: result,
    );

    return result;
  }

  @override
  void initState() {
    super.initState();

    _shouldBuildView.addAll(List<bool>.filled(_length, false));

    _overlays.addAll(List<OverlayEntry>.generate(
        _length, (index) => _createPageOverlayEntry(index)));

    _menuController = AnimationController(
      vsync: this,
      duration: _kMenuTransitionDuration,
    )..addStatusListener(_handleMenuAnimationStatusChanged);

    _createAnimation();
  }

  OverlayEntry _createPageOverlayEntry(int index) {
    return OverlayEntry(
        maintainState: true,
        builder: (context) {
          final bool active = index == _index;
          _shouldBuildView[index] = active || _shouldBuildView[index];
          return Offstage(
            offstage: !active,
            child: TickerMode(
              enabled: active,
              child: Builder(
                builder: _shouldBuildView[index]
                    ? (context) => widget.items[index].builder(context, index)
                    : (context) => Container(),
              ),
            ),
          );
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(BottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length - _shouldBuildView.length > 0) {
      _shouldBuildView.addAll(List<bool>.filled(
          widget.items.length - _shouldBuildView.length, false));

      for (int index = _overlays.length;
          index < widget.items.length - _shouldBuildView.length;
          index += 1) {
        _overlays.add(_createPageOverlayEntry(index));
      }
    } else {
      _shouldBuildView.removeRange(
          widget.items.length, _shouldBuildView.length);

      for (final overlayEntry
          in _overlays.getRange(widget.items.length, _overlays.length)) {
        overlayEntry.remove();
      }

      _overlays.removeRange(widget.items.length, _overlays.length);
    }
  }

  @override
  void dispose() {
    _menuController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Stack(
      children: <Widget>[
        Column(
          children: [
            Expanded(
              child: Overlay(
                key: _overlayKey,
                initialEntries: _overlays,
              ),
            ),
            _createNavBar(),
          ],
        ),
        Overlay(
          key: _menuOverlayKey,
          initialEntries: _menuOverlays,
        ),
        _createMenuItem(),
      ],
    );

    result = TabScope(
      axis: Axis.horizontal,
      currentIndex: _index,
      child: result,
    );

    return result;
  }
}
