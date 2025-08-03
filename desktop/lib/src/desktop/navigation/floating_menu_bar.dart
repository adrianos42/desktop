import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

const Duration _kHoverDuration = Duration(milliseconds: 200);
const Duration _kOpacityDuration = Duration(milliseconds: 400);

class FloatingMenuItem {
  const FloatingMenuItem({
    this.onPressed,
    required this.icon,
  });

  /// An icon to be built for the menu.
  final WidgetBuilder icon;

  /// Called when menu button is pressed.
  final VoidCallback? onPressed;
}

class FloatingMenuBar extends StatefulWidget {
  /// Creates a navigation bar.
  const FloatingMenuBar({
    super.key,
    required this.items,
    this.trailingMenu,
    this.visible = true,
    this.child,
    this.expanded = false,
  }) : assert(items.length > 0);

  /// The items with builder and route names for transition among pages.
  final List<FloatingMenuItem> items;

  /// Menu before the navigation items.
  final Widget? trailingMenu;

  /// If the nav bar should be visible.
  final bool visible;

  final bool expanded;

  final Widget? child;

  @override
  State<FloatingMenuBar> createState() => _FloatingMenuBarState();
}

class _FloatingMenuBarState extends State<FloatingMenuBar>
    with TickerProviderStateMixin {
  late CurvedAnimation _hoverPosition;
  late AnimationController _hoverPositionController;
  late CurvedAnimation _opacityPosition;
  late AnimationController _opacityPositionController;

  bool _hovering = false;
  void _handleHoverChanged(bool hovering) {
    if (hovering != _hovering) {
      if (hovering) {
        _hoverPositionController.forward();
      } else {
        _hoverPositionController.reverse();
      }
      setState(() => _hovering = hovering);
    }
  }

  @override
  void initState() {
    super.initState();

    _hoverPositionController = AnimationController(
      duration: _kHoverDuration,
      value: 0.0,
      vsync: this,
    );

    _hoverPosition = CurvedAnimation(
      parent: _hoverPositionController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOut.flipped,
    );

    _opacityPositionController = AnimationController(
      duration: _kOpacityDuration,
      value: 1.0,
      vsync: this,
    )..addListener(() {
        switch (_opacityPositionController.status) {
          case AnimationStatus.dismissed:
          case AnimationStatus.completed:
            setState(() {});
          default:
        }
      });

    const opacityCurve = Curves.fastEaseInToSlowEaseOut;

    _opacityPosition = CurvedAnimation(
      parent: _opacityPositionController,
      curve: opacityCurve,
      reverseCurve: opacityCurve.flipped,
    );
  }

  @override
  void didUpdateWidget(covariant FloatingMenuBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _opacityPositionController.forward();
      } else {
        _opacityPositionController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _hoverPositionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget result = Offstage(
      offstage: !widget.visible && !_opacityPositionController.isAnimating,
      child: TickerMode(
        enabled: widget.visible || _opacityPositionController.isAnimating,
        child: Builder(
          builder: (context) {
            final FloatingMenuBarThemeData menuThemeData =
                FloatingMenuBarTheme.of(context);
            final Color foreground = menuThemeData.foreground!;
            final Brightness brightness = Theme.of(context).brightness;

            return Theme.withBrightness(
              context,
              brightness: brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
              child: DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: foreground),
                child: IconTheme(
                  data: IconThemeData(color: foreground),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: MouseRegion(
                      onEnter: (_) => _handleHoverChanged(true),
                      onHover: (_) => _handleHoverChanged(true),
                      onExit: (_) => _handleHoverChanged(false),
                      opaque: false,
                      child: AnimatedBuilder(
                        animation: _opacityPositionController,
                        builder: (context, child) => AnimatedBuilder(
                          animation: _hoverPositionController,
                          builder: (context, _) => Opacity(
                            opacity: _opacityPosition.value,
                            child: AbsorbPointer(
                              absorbing: _hoverPositionController.isAnimating ||
                                  _hoverPositionController.isDismissed,
                              child: Container(
                                margin: const EdgeInsets.all(12.0),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                color: Color.lerp(
                                  menuThemeData.backgroundColor!.withValues(
                                    alpha: menuThemeData.inactiveOpacity!,
                                  ),
                                  menuThemeData.backgroundColor!,
                                  _hoverPosition.value,
                                ),
                                height: menuThemeData.height!,
                                child: AnimatedSize(
                                  duration: _kHoverDuration,
                                  curve: Curves.fastEaseInToSlowEaseOut,
                                  child: Row(
                                    mainAxisSize: widget.expanded
                                        ? MainAxisSize.max
                                        : MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ...widget.items
                                          .map((e) => e.icon(context)),
                                      if (widget.expanded) const Spacer(),
                                      if (widget.trailingMenu != null) ...[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Center(
                                              child: widget.trailingMenu),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    if (widget.child != null) {
      return Stack(
        children: [
          widget.child!,
          result,
        ],
      );
    } else {
      return result;
    }
  }
}
