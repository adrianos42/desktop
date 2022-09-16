import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

const double _kTooltipHeight = 32.0;
const double _kTooltipMaxWidth = 320.0;
const double _kVerticalOffset = 24.0;
const bool _kPreferBelow = true;
const EdgeInsetsGeometry _kPadding =
    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
const EdgeInsetsGeometry _kMargin = EdgeInsets.zero;
const Duration _kFadeInDuration = Duration(milliseconds: 80);
const Duration _kFadeOutDuration = Duration(milliseconds: 40);
const Duration _kShowDuration = Duration(milliseconds: 2400);
const Duration _kWaitDuration = Duration(milliseconds: 1200);
const bool _kExcludeFromSemantics = false;

class Tooltip extends StatefulWidget {
  const Tooltip({
    Key? key,
    required this.message,
    this.height,
    this.maxWidth,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.background,
    this.textStyle,
    this.waitDuration,
    this.showDuration,
    this.visible,
    this.child,
  }) : super(key: key);

  /// The text to display in the tooltip.
  final String message;

  /// The height of the tooltip's [child].
  final double? height;

  final double? maxWidth;

  /// The amount of space by which to inset the tooltip's [child].
  final EdgeInsetsGeometry? padding;

  /// The empty space that surrounds the tooltip.
  ///
  /// Defines the tooltip's outer [Container.margin]. By default, a
  /// long tooltip will span the width of its window. If long enough,
  /// a tooltip might also span the window's height. This property allows
  /// one to define how much space the tooltip must be inset from the edges
  /// of their display window.
  ///
  /// If this property is null, then [TooltipThemeData.margin] is used.
  /// If [TooltipThemeData.margin] is also null, the default margin is
  /// 0.0 logical pixels on all sides.
  final EdgeInsetsGeometry? margin;

  /// The vertical gap between the widget and the displayed tooltip.
  ///
  /// When [preferBelow] is set to true and tooltips have sufficient space to
  /// display themselves, this property defines how much vertical space
  /// tooltips will position themselves under their corresponding widgets.
  /// Otherwise, tooltips will position themselves above their corresponding
  /// widgets with the given offset.
  final double? verticalOffset;

  /// Whether the tooltip defaults to being displayed below the widget.
  ///
  /// Defaults to true. If there is insufficient space to display the tooltip in
  /// the preferred direction, the tooltip will be displayed in the opposite
  /// direction.
  final bool? preferBelow;

  /// Whether the tooltip's [message] should be excluded from the semantics
  /// tree.
  ///
  /// Defaults to false. A tooltip will add a [Semantics.label] that is set to
  /// [Tooltip.message]. Set this property to true if the app is going to
  /// provide its own custom semantics label.
  final bool? excludeFromSemantics;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget? child;

  final Color? background;

  /// The style to use for the message of the tooltip.
  final TextStyle? textStyle;

  /// The length of time that a pointer must hover over a tooltip's widget
  /// before the tooltip will be shown.
  ///
  /// Once the pointer leaves the widget, the tooltip will immediately
  /// disappear.
  ///
  /// Defaults to 800 milliseconds.
  final Duration? waitDuration;

  /// The length of time that the tooltip will be shown after a long press
  /// is released.
  ///
  /// Defaults to 1.2 seconds.
  final Duration? showDuration;

  final bool? visible;

  @override
  _TooltipState createState() => _TooltipState();
}

class _TooltipState extends State<Tooltip> with SingleTickerProviderStateMixin {
  late double height;
  late double maxWidth;
  late EdgeInsetsGeometry padding;
  late EdgeInsetsGeometry margin;
  late Color background;
  late TextStyle textStyle;
  late double verticalOffset;
  late bool preferBelow;
  late bool excludeFromSemantics;
  late AnimationController _controller;
  late Duration showDuration;
  late Duration waitDuration;
  late bool _mouseIsConnected;
  late bool _visible;

  OverlayEntry? _entry;
  Timer? _hideTimer;
  Timer? _showTimer;
  bool _longPressActivated = false;

  @override
  void initState() {
    super.initState();
    _mouseIsConnected = RendererBinding.instance.mouseTracker.mouseIsConnected;
    _controller = AnimationController(
      duration: _kFadeInDuration,
      reverseDuration: _kFadeOutDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);
    // Listen to see when a mouse is added.
    RendererBinding.instance.mouseTracker
        .addListener(_handleMouseTrackerChange);
    // Listen to global pointer events so that we can hide a tooltip immediately
    // if some other control is clicked on.
    GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
  }

  @override
  void didUpdateWidget(Tooltip oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.visible != oldWidget.visible) {
      if (!widget.visible!) {
        _hideTooltip();
      }
    }
  }

  // Forces a rebuild if a mouse has been added or removed.
  void _handleMouseTrackerChange() {
    if (!mounted) {
      return;
    }
    final bool mouseIsConnected =
        RendererBinding.instance.mouseTracker.mouseIsConnected;
    if (mouseIsConnected != _mouseIsConnected) {
      setState(() {
        _mouseIsConnected = mouseIsConnected;
      });
    }
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      _hideTooltip(immediately: true);
    }
  }

  void _hideTooltip({bool immediately = false}) {
    _showTimer?.cancel();
    _showTimer = null;
    if (immediately) {
      _removeEntry();
      return;
    }
    if (_longPressActivated) {
      // Tool tips activated by long press should stay around for the showDuration.
      _hideTimer ??= Timer(showDuration, _controller.reverse);
    } else {
      // Tool tips activated by hover should disappear as soon as the mouse
      // leaves the control.
      _controller.reverse();
    }
    _longPressActivated = false;
  }

  void _showTooltip({bool immediately = false}) {
    _hideTimer?.cancel();
    _hideTimer = null;

    if (immediately) {
      ensureTooltipVisible();
      return;
    }
    _showTimer ??= Timer(waitDuration, ensureTooltipVisible);
  }

  /// Shows the tooltip if it is not already visible.
  ///
  /// Returns `false` when the tooltip was already visible.
  bool ensureTooltipVisible() {
    _showTimer?.cancel();
    _showTimer = null;
    if (_entry != null) {
      _hideTimer?.cancel();
      _hideTimer = null;
      _controller.forward();
      return false; // Already visible.
    }
    _createNewEntry();
    _controller.forward();
    return true;
  }

  void _createNewEntry() {
    final OverlayState overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    )!;

    final RenderBox box = context.findRenderObject()! as RenderBox;
    final Offset target = box.localToGlobal(
      box.size.center(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );

    // We create this widget outside of the overlay entry's builder to prevent
    // updated values from happening to leak into the overlay when the overlay
    // rebuilds.
    final Widget overlay = Directionality(
      textDirection: Directionality.of(context),
      child: _TooltipOverlay(
        message: widget.message,
        height: height,
        maxWidth: maxWidth,
        padding: padding,
        margin: margin,
        background: background,
        textStyle: textStyle,
        animation: CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
        target: target,
        verticalOffset: verticalOffset,
        preferBelow: preferBelow,
      ),
    );
    _entry = OverlayEntry(builder: (BuildContext context) => overlay);
    Overlay.of(context, debugRequiredFor: widget)?.insert(_entry!);
    SemanticsService.tooltip(widget.message);
  }

  void _removeEntry() {
    _hideTimer?.cancel();
    _hideTimer = null;
    _showTimer?.cancel();
    _showTimer = null;
    _entry?.remove();
    _entry = null;
  }

  void _handlePointerEvent(PointerEvent event) {
    if (_entry == null) {
      return;
    }
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _hideTooltip();
    } else if (event is PointerDownEvent) {
      _hideTooltip(immediately: true);
    }
  }

  @override
  void deactivate() {
    if (_entry != null) {
      _hideTooltip(immediately: true);
    }
    _showTimer?.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter
        .removeGlobalRoute(_handlePointerEvent);
    RendererBinding.instance.mouseTracker
        .removeListener(_handleMouseTrackerChange);
    if (_entry != null) {
      _removeEntry();
    }
    _controller.dispose();
    super.dispose();
  }

  void _handleLongPress() {
    _longPressActivated = true;
    ensureTooltipVisible();
  }

  @override
  Widget build(BuildContext context) {
    assert(Overlay.of(context, debugRequiredFor: widget) != null);

    final ThemeData themeData = Theme.of(context).invertedTheme;

    final TextStyle defaultTextStyle = themeData.textTheme.caption;
    final Color defaultDecoration = themeData.colorScheme.background[0];

    height = widget.height ?? _kTooltipHeight;
    maxWidth = widget.maxWidth ?? _kTooltipMaxWidth;
    padding = widget.padding ?? _kPadding;
    margin = widget.margin ?? _kMargin;
    verticalOffset = widget.verticalOffset ?? _kVerticalOffset;
    preferBelow = widget.preferBelow ?? _kPreferBelow;
    excludeFromSemantics =
        widget.excludeFromSemantics ?? _kExcludeFromSemantics;
    background = widget.background ?? defaultDecoration;
    textStyle = widget.textStyle ?? defaultTextStyle;
    waitDuration = widget.waitDuration ?? _kWaitDuration;
    showDuration = widget.showDuration ?? _kShowDuration;
    _visible = widget.visible ?? true;

    Widget result = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: _handleLongPress,
      excludeFromSemantics: true,
      child: Semantics(
        label: excludeFromSemantics ? null : widget.message,
        child: widget.child,
      ),
    );

    // Only check for hovering if there is a mouse connected.
    if (_mouseIsConnected) {
      result = MouseRegion(
        onEnter: _visible ? (_) => _showTooltip() : null,
        onExit: _visible ? (_) => _hideTooltip() : null,
        child: result,
      );
    }

    return result;
  }
}

/// A delegate for computing the layout of a tooltip to be displayed above or
/// bellow a target specified in the global coordinate system.
class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  /// Creates a delegate for computing the layout of a tooltip.
  ///
  /// The arguments must not be null.
  _TooltipPositionDelegate({
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
  });

  /// The offset of the target the tooltip is positioned near in the global
  /// coordinate system.
  final Offset target;

  /// The amount of vertical distance between the target and the displayed
  /// tooltip.
  final double verticalOffset;

  /// Whether the tooltip is displayed below its widget by default.
  ///
  /// If there is insufficient space to display the tooltip in the preferred
  /// direction, the tooltip will be displayed in the opposite direction.
  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
  }

  @override
  bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    Key? key,
    required this.message,
    required this.height,
    required this.maxWidth,
    this.padding,
    this.margin,
    this.background,
    this.textStyle,
    required this.animation,
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
  }) : super(key: key);

  final String message;
  final double height;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? background;
  final TextStyle? textStyle;
  final Animation<double> animation;
  final Offset target;
  final double verticalOffset;
  final bool preferBelow;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomSingleChildLayout(
          delegate: _TooltipPositionDelegate(
            target: target,
            verticalOffset: verticalOffset,
            preferBelow: preferBelow,
          ),
          child: FadeTransition(
            opacity: animation,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: height, maxWidth: maxWidth),
              child: Container(
                color: background,
                padding: padding,
                margin: margin,
                child: Center(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Text(
                    message,
                    style: textStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
