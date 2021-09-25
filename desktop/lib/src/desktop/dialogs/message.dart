import 'dart:async';
import 'dart:ui';

import 'package:flutter/animation.dart' show Curves;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../theme/theme.dart';

const Duration _kFadeInDuration = Duration(milliseconds: 100);
const Duration _kFadeOutDuration = Duration(milliseconds: 100);

/// The kind of message to be displayed.
enum MessageKind {
  /// Info message.
  info,

  /// Error message.
  error,

  /// Warning message.
  warning,

  /// Success message.
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
    required this.entryObject,
  }) : super(key: key);

  final String message;

  final String? title;

  final List<Widget>? menus;

  final BoxConstraints? constraints;

  final EdgeInsets? padding;

  final EdgeInsets? dialogPadding;

  final MessageKind kind;

  final _OverlayMes entryObject;

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<_MessageDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool _mouseIsConnected;
  AnimationStatus? _previousAnimationStatus;

  OverlayEntry get _entry => widget.entryObject.entry!;

  Timer? _hideTimer;

  void _startTimer() {
    _hideTimer = Timer(const Duration(seconds: 4), () {
      print(_controller.value);
      print('contloller reverse');
      _controller.reverse();
    });
  }

  void _stopTimer() {
    _hideTimer?.cancel();
  }

  @override
  void initState() {
    super.initState();

    _mouseIsConnected = RendererBinding.instance!.mouseTracker.mouseIsConnected;
    RendererBinding.instance!.mouseTracker
        .addListener(_handleMouseTrackerChange);
    GestureBinding.instance!.pointerRouter.addGlobalRoute(_handlePointerEvent);

    _controller = AnimationController(
      duration: _kFadeInDuration,
      reverseDuration: _kFadeOutDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInSine,
      reverseCurve: Curves.easeOutSine,
    );

    _controller.forward();

    _startTimer();
  }

  void _handleMouseTrackerChange() {
    if (!mounted) {
      return;
    }
    final bool mouseIsConnected =
        RendererBinding.instance!.mouseTracker.mouseIsConnected;
    if (mouseIsConnected != _mouseIsConnected) {
      setState(() {
        _mouseIsConnected = mouseIsConnected;
      });
    }
  }

  void _handlePointerEvent(PointerEvent event) {
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      // _startTimer();
    } else if (event is PointerDownEvent) {
      // _stopTimer();
    }
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (_controller.value == 0.0 &&
        _previousAnimationStatus == AnimationStatus.reverse) {
      _entry.remove();
    } else {
      _previousAnimationStatus = status;
    }
  }

  @override
  void dispose() {
    GestureBinding.instance!.pointerRouter
        .removeGlobalRoute(_handlePointerEvent);
    RendererBinding.instance!.mouseTracker
        .removeListener(_handleMouseTrackerChange);

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    //final DialogThemeData dialogThemeData = DialogTheme.of(context);

    final Color backgroundColor = colorScheme.background[0];
    final Color iconForeground;
    final IconData iconData;

    switch (widget.kind) {
      case MessageKind.info:
        iconData = Icons.info;
        iconForeground = const HSLColor.fromAHSL(1.0, 0, 0.0, 0.6).toColor();
        break;
      case MessageKind.error:
        iconData = Icons.error;
        iconForeground = const HSLColor.fromAHSL(1.0, 0, 0.7, 0.55).toColor();
        break;
      case MessageKind.warning:
        iconData = Icons.warning;
        iconForeground = const HSLColor.fromAHSL(1.0, 60, 0.7, 0.55).toColor();
        break;
      case MessageKind.success:
        iconData = Icons.done;
        iconForeground = const HSLColor.fromAHSL(1.0, 120, 0.7, 0.55).toColor();
        break;
    }

    Widget result = Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(
            color: iconForeground,
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
                  color: iconForeground,
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

    result = FadeTransition(opacity: _animation, child: result);

    if (_mouseIsConnected) {
      result = MouseRegion(
        onEnter: (_) => _stopTimer(),
        onExit: (_) => _startTimer(),
        onHover: (_) => _stopTimer(),
        child: result,
      );
    }

    return Focus(
      child: Container(alignment: Alignment.bottomCenter, child: result),
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
  final entryObject = _OverlayMes();

  final Widget overlay = Directionality(
    textDirection: Directionality.of(context),
    child: _MessageDialog(
      message: message,
      title: title,
      kind: kind,
      entryObject: entryObject,
    ),
  );

  entryObject.entry = OverlayEntry(
    builder: (BuildContext context) => overlay,
    maintainState: true,
  );

  Overlay.of(context, rootOverlay: true)?.insert(entryObject.entry!);
}

class _OverlayMes {
  OverlayEntry? entry;
}
