import 'dart:ui';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart' show Curves;

import '../localizations.dart';
import '../theme/theme.dart';
import '../input/button.dart';
import '../icons.dart';

const Duration _kDialogDuration = Duration(milliseconds: 300);

const double _kMessageHeight = 32.0;
const double _kMessageMaxWidth = 320.0;
const double _kVerticalOffset = 24.0;
const bool _kPreferBelow = true;
const EdgeInsetsGeometry _kPadding =
    EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
const EdgeInsetsGeometry _kMargin = EdgeInsets.zero;
const Duration _kFadeInDuration = Duration(milliseconds: 80);
const Duration _kFadeOutDuration = Duration(milliseconds: 40);
const Duration _kShowDuration = Duration(milliseconds: 1200);
const Duration _kWaitDuration = Duration(milliseconds: 800);
const bool _kExcludeFromSemantics = false;

enum MessageKind {
  info,
  error,
  warning,
  success,
}

class _MessageDialog extends StatefulWidget {
  /// Creates a [MessageDialog].
  const _MessageDialog({
    Key? key,
    this.title,
    this.menus,
    this.constraints,
    this.padding,
    this.dialogPadding,
    required this.kind,
    required this.message,
  }) : super(key: key);

  final String message;

  final String? title;

  final List<Widget>? menus;

  final BoxConstraints? constraints;

  final EdgeInsets? padding;

  final EdgeInsets? dialogPadding;

  final MessageKind kind;

  // @override
  // Widget build(BuildContext context) {
  //   final ThemeData themeData = Theme.of(context);
  //   final TextTheme textTheme = themeData.textTheme;
  //   final ColorScheme colorScheme = themeData.colorScheme;

  //   //final DialogThemeData dialogThemeData = DialogTheme.of(context);

  //   final HSLColor backgroundColor = colorScheme.background[10];
  //   final HSLColor iconForeground;
  //   final IconData iconData;

  //   switch (MessageKind.success) {
  //     case MessageKind.info:
  //       iconData = Icons.info;
  //       iconForeground = const HSLColor.fromAHSL(1.0, 0, 0.0, 0.6);
  //       break;
  //     case MessageKind.error:
  //       iconData = Icons.error;
  //       iconForeground = const HSLColor.fromAHSL(1.0, 0, 0.7, 0.55);
  //       break;
  //     case MessageKind.warning:
  //       iconData = Icons.warning;
  //       iconForeground = const HSLColor.fromAHSL(1.0, 60, 0.7, 0.55);
  //       break;
  //     case MessageKind.success:
  //       iconData = Icons.done;
  //       iconForeground = const HSLColor.fromAHSL(1.0, 120, 0.7, 0.55);
  //       break;
  //   }

  //   final Widget result = Container(
  //     //constraints: constraints ?? dialogThemeData.constraints,
  //     //padding: dialogPadding ?? dialogThemeData.dialogPadding,
  //     padding: const EdgeInsets.all(12),
  //     color: backgroundColor.toColor(),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(right: 12),
  //               child: Icon(
  //                 iconData,
  //                 color: iconForeground.toColor(),
  //               ),
  //             ),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   if (title != null)
  //                     Padding(
  //                       padding: const EdgeInsets.only(bottom: 4),
  //                       child: Text(
  //                         title!,
  //                         textAlign: TextAlign.justify,
  //                         style: textTheme.caption.copyWith(
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ),
  //                   Text(
  //                     message,
  //                     textAlign: TextAlign.justify,
  //                     style: textTheme.caption,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             // Padding(
  //             //   padding: const EdgeInsets.only(left: 12),
  //             //   child: Button.text(
  //             //     'Try Again',
  //             //     onPressed: () {},
  //             //     padding: EdgeInsets.zero,
  //             //     //highlightColor: HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.5),
  //             //     //color: iconForeground,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );

  //   return Focus(
  //     child: Container(
  //         alignment: Alignment.bottomCenter,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             result
  //             // Container(
  //             //   padding: const EdgeInsets.symmetric(horizontal: 6),
  //             //   color: backgroundColor,
  //             //   alignment: Alignment.centerRight,
  //             //   margin: const EdgeInsets.only(top: 2),
  //             //   child: Row(
  //             //     mainAxisSize: MainAxisSize.min,
  //             //     mainAxisAlignment: MainAxisAlignment.end,
  //             //     children: [
  //             //       Button.text(
  //             //         'Open',
  //             //         color: iconForeground,
  //             //         onPressed: () {},
  //             //       ),
  //             //     ],
  //             //   ),
  //             // ),
  //           ],
  //         )),
  //     autofocus: true,
  //     debugLabel: 'Dialog',
  //   );
  // }

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<_MessageDialog>
    with SingleTickerProviderStateMixin {
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

  // @override
  // void initState() {
  //   super.initState();
  //   _mouseIsConnected = RendererBinding.instance!.mouseTracker.mouseIsConnected;
  //   _controller = AnimationController(
  //     duration: _kFadeInDuration,
  //     reverseDuration: _kFadeOutDuration,
  //     vsync: this,
  //   )..addStatusListener(_handleStatusChanged);
  //   // Listen to see when a mouse is added.
  //   RendererBinding.instance!.mouseTracker
  //       .addListener(_handleMouseTrackerChange);
  //   // Listen to global pointer events so that we can hide a tooltip immediately
  //   // if some other control is clicked on.
  //   GestureBinding.instance!.pointerRouter.addGlobalRoute(_handlePointerEvent);
  // }

  // @override
  // void didUpdateWidget(_MessageDialog oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   // if (widget.visible != oldWidget.visible) {
  //   //   if (!widget.visible!) {
  //   //     _hideMessage();
  //   //   }
  //   // }
  // }

  // // Forces a rebuild if a mouse has been added or removed.
  // void _handleMouseTrackerChange() {
  //   if (!mounted) {
  //     return;
  //   }
  //   final bool mouseIsConnected =
  //       RendererBinding.instance!.mouseTracker.mouseIsConnected;
  //   if (mouseIsConnected != _mouseIsConnected) {
  //     setState(() {
  //       _mouseIsConnected = mouseIsConnected;
  //     });
  //   }
  // }

  // void _handleStatusChanged(AnimationStatus status) {
  //   if (status == AnimationStatus.dismissed) {
  //     _hideMessage(immediately: true);
  //   }
  // }

  // void _hideMessage({bool immediately = false}) {
  //   _showTimer?.cancel();
  //   _showTimer = null;
  //   if (immediately) {
  //     _removeEntry();
  //     return;
  //   }
  //   if (_longPressActivated) {
  //     // Tool tips activated by long press should stay around for the showDuration.
  //     _hideTimer ??= Timer(showDuration, _controller.reverse);
  //   } else {
  //     // Tool tips activated by hover should disappear as soon as the mouse
  //     // leaves the control.
  //     _controller.reverse();
  //   }
  //   _longPressActivated = false;
  // }

  // void _showMessage({bool immediately = false}) {
  //   _hideTimer?.cancel();
  //   _hideTimer = null;

  //   if (immediately) {
  //     ensureMessageVisible();
  //     return;
  //   }
  //   _showTimer ??= Timer(waitDuration, ensureMessageVisible);
  // }

  // /// Shows the tooltip if it is not already visible.
  // ///
  // /// Returns `false` when the tooltip was already visible.
  // bool ensureMessageVisible() {
  //   _showTimer?.cancel();
  //   _showTimer = null;
  //   if (_entry != null) {
  //     // Stop trying to hide, if we were.
  //     _hideTimer?.cancel();
  //     _hideTimer = null;
  //     _controller.forward();
  //     return false; // Already visible.
  //   }
  //   _createNewEntry();
  //   _controller.forward();
  //   return true;
  // }

  // void _createNewEntry() {
  //   final OverlayState overlayState = Overlay.of(
  //     context,
  //     debugRequiredFor: widget,
  //   )!;

  //   final RenderBox box = context.findRenderObject()! as RenderBox;
  //   final Offset target = box.localToGlobal(
  //     box.size.center(Offset.zero),
  //     ancestor: overlayState.context.findRenderObject(),
  //   );

  //   // We create this widget outside of the overlay entry's builder to prevent
  //   // updated values from happening to leak into the overlay when the overlay
  //   // rebuilds.
  // }

  // void _removeEntry() {
  //   _hideTimer?.cancel();
  //   _hideTimer = null;
  //   _showTimer?.cancel();
  //   _showTimer = null;
  //   _entry?.remove();
  //   _entry = null;
  // }

  // void _handlePointerEvent(PointerEvent event) {
  //   if (_entry == null) {
  //     return;
  //   }
  //   if (event is PointerUpEvent || event is PointerCancelEvent) {
  //     _hideMessage();
  //   } else if (event is PointerDownEvent) {
  //     _hideMessage(immediately: true);
  //   }
  // }

  // @override
  // void deactivate() {
  //   if (_entry != null) {
  //     _hideMessage(immediately: true);
  //   }
  //   _showTimer?.cancel();
  //   super.deactivate();
  // }

  // @override
  // void dispose() {
  //   GestureBinding.instance!.pointerRouter
  //       .removeGlobalRoute(_handlePointerEvent);
  //   RendererBinding.instance!.mouseTracker
  //       .removeListener(_handleMouseTrackerChange);
  //   if (_entry != null) {
  //     _removeEntry();
  //   }
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    //final DialogThemeData dialogThemeData = DialogTheme.of(context);

    final HSLColor backgroundColor = colorScheme.background[0];
    final HSLColor iconForeground;
    final IconData iconData;

    switch (MessageKind.success) {
      case MessageKind.info:
        iconData = Icons.info;
        iconForeground = const HSLColor.fromAHSL(1.0, 0, 0.0, 0.6);
        break;
      case MessageKind.error:
        iconData = Icons.error;
        iconForeground = const HSLColor.fromAHSL(1.0, 0, 0.7, 0.55);
        break;
      case MessageKind.warning:
        iconData = Icons.warning;
        iconForeground = const HSLColor.fromAHSL(1.0, 60, 0.7, 0.55);
        break;
      case MessageKind.success:
        iconData = Icons.done;
        iconForeground = const HSLColor.fromAHSL(1.0, 120, 0.7, 0.55);
        break;
    }

    final Widget result = Container(
      //constraints: constraints ?? dialogThemeData.constraints,
      //padding: dialogPadding ?? dialogThemeData.dialogPadding,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor.toColor(),
        border: Border(
          top: BorderSide(
            color: themeData.colorScheme.shade[30].toColor(),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  iconData,
                  color: iconForeground.toColor(),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.title != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          widget.title!,
                          textAlign: TextAlign.justify,
                          style: textTheme.caption.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    Text(
                      widget.message,
                      textAlign: TextAlign.justify,
                      style: textTheme.caption,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 12),
              //   child: Button.text(
              //     'Try Again',
              //     onPressed: () {},
              //     padding: EdgeInsets.zero,
              //     //highlightColor: HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.5),
              //     //color: iconForeground,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );

    return Focus(
      child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              result
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 6),
              //   color: backgroundColor,
              //   alignment: Alignment.centerRight,
              //   margin: const EdgeInsets.only(top: 2),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Button.text(
              //         'Open',
              //         color: iconForeground,
              //         onPressed: () {},
              //       ),
              //     ],
              //   ),
              // ),
            ],
          )),
      autofocus: true,
      debugLabel: 'Dialog',
    );
  }
}

/// Shows a dialog with default [DialogRoute].
void showMessageDialog({
  String? title,
  required BuildContext context,
  required String message,
  required MessageKind kind,
}) {
  final Widget overlay = Directionality(
    textDirection: Directionality.of(context),
    child: _MessageDialog(
      message: message,
      title: title,
      kind: kind,
    ),
  );

  final OverlayEntry entry = OverlayEntry(
    builder: (BuildContext context) => overlay,
    maintainState: true,
  );

  Overlay.of(context, rootOverlay: true)?.insert(entry);

  Timer(const Duration(seconds: 2), () {
    entry.remove();
  });
}
