import 'dart:async';
import 'dart:collection';

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

/// The reason the message was closed.
enum MessageClosedReason {
  action,
  dismiss,
  hide,
  remove,

  /// Timeout.
  timeout,
}

class _FeatureController {
  const _FeatureController._(
      this._widget, this._completer, this.close, this.setState);
  final Message _widget;
  final Completer<MessageClosedReason> _completer;

  /// Completes when the feature controlled by this object is no longer visible.
  Future<MessageClosedReason> get closed => _completer.future;

  /// Remove the feature (e.g., bottom sheet, snack bar, or material banner) from the scaffold.
  final VoidCallback close;

  /// Mark the feature (e.g., bottom sheet or snack bar) as needing to rebuild.
  final StateSetter? setState;
}

/// A stack for showing [Message].
class Messenger extends StatefulWidget {
  /// Creates a widget that manages a [Message] stack.
  const Messenger({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  static _MessengerState _of(BuildContext context) {
    final _MessengerScope scope =
        context.dependOnInheritedWidgetOfExactType<_MessengerScope>()!;
    return scope._messengerState;
  }

  /// Adds a [Message] te be shown.
  static void showMessage(
    BuildContext context, {
    required String message,
    required MessageKind kind,
    String? title,
  }) {
    _of(context).showMessage(
      message: message,
      kind: kind,
    );
  }

  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> with TickerProviderStateMixin {
  final Queue<OverlayEntry> _messages = Queue<OverlayEntry>();
  AnimationController? _messageController;
  Timer? _hideTimer;

  void startTimer() {
    _hideTimer = Timer(const Duration(seconds: 4), () {
      hideCurrentMessage();
    });
  }

  void stopTimer() {
    _hideTimer?.cancel();
  }

  void showMessage({
    required String message,
    required MessageKind kind,
    String? title,
  }) {
    final OverlayEntry entry = OverlayEntry(
      builder: (context) => Message(
        message: message,
        kind: kind,
        title: title,
      ),
      maintainState: false,
    );

    _messages.addLast(entry);

    if (_messages.length == 1) {
      Overlay.of(context, rootOverlay: true)?.insert(_messages.first);
      startTimer();
    }
  }

  void _update() {
    // scaffold._updateMessage();
  }

  // void showMessage(BuildContext context, Message message) {
  //   _messageController ??= Message._createAnimationController(vsync: this)
  //     ..addStatusListener(_handleMessageStatusChanged);

  //   if (_messages.isEmpty) {
  //     assert(_messageController!.isDismissed);
  //     _messageController!.forward();
  //   }

  //   // final _FeatureController<Message, MessageClosedReason> controller =
  //   //     _FeatureController<Message, MessageClosedReason>._(
  //   //   message
  //   //   // .withAnimation(_messageController!,
  //   //   //     fallbackKey: UniqueKey())
  //   //   ,
  //   //   Completer<MessageClosedReason>(),
  //   //   () {
  //   //     hideCurrentMessage(reason: MessageClosedReason.hide);
  //   //   },
  //   //   null, // Message doesn't use a builder function so setState() wouldn't rebuild it
  //   // );

  //   //print(_messages);

  //   //return controller;
  // }

  void _handleMessageStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        assert(_messages.isNotEmpty);
        _messages.removeFirst();

        _update();
        if (_messages.isNotEmpty) {
          _messageController!.forward();
        }
        break;
      case AnimationStatus.completed:
        assert(_hideTimer == null);
        _update();
        break;
      case AnimationStatus.forward:
        break;
      case AnimationStatus.reverse:
        break;
    }
  }

  /// Removes the current [Message] (if any) immediately from registered
  /// [Scaffold]s.
  ///
  /// The removed snack bar does not run its normal exit animation. If there are
  /// any queued snack bars, they begin their entrance animation immediately.
  void removeCurrentMessage(
      {MessageClosedReason reason = MessageClosedReason.remove}) {
    if (_messages.isEmpty) {
      return;
    }

    // final Completer<MessageClosedReason> completer = _messages.first._completer;

    // if (!completer.isCompleted) completer.complete(reason);

    _hideTimer?.cancel();
    _hideTimer = null;

    // This will trigger the animation's status callback.
    _messageController!.value = 0.0;
  }

  /// Removes the current [Message] by running its normal exit animation.
  ///
  /// The closed completer is called after the animation is complete.
  void hideCurrentMessage({
    MessageClosedReason reason = MessageClosedReason.hide,
  }) {
    // if (_messages.isEmpty ||
    //     _messageController!.status == AnimationStatus.dismissed) {
    //   return;
    // }

    final entry = _messages.removeFirst();

    entry.remove();

    if (_messages.isNotEmpty) {
      Overlay.of(context, rootOverlay: true)?.insert(_messages.first);
      startTimer();
    }

    // final Completer<MessageClosedReason> completer = _messages.first._completer;
    _messageController?.reverse().then<void>((void value) {
      //if (!completer.isCompleted) completer.complete(reason);
    });

    //_hideTimer?.cancel();
    //_hideTimer = null;
  }

  /// Removes all the messages currently in queue by clearing the queue
  /// and running normal exit animation on the current message.
  void clearMessages() {
    if (_messages.isEmpty ||
        _messageController!.status == AnimationStatus.dismissed) {
      return;
    }

    // final _FeatureController<Message, MessageClosedReason> currentMessage =
    //     _messages.first;
    // _messages.clear();
    // _messages.add(currentMessage);
    hideCurrentMessage();
  }

  @override
  Widget build(BuildContext context) {
    return _MessengerScope(
      messengerState: this,
      child: widget.child,
    );
  }
}

class _MessengerScope extends InheritedWidget {
  const _MessengerScope({
    Key? key,
    required Widget child,
    required _MessengerState messengerState,
  })  : _messengerState = messengerState,
        super(key: key, child: child);

  final _MessengerState _messengerState;

  @override
  bool updateShouldNotify(_MessengerScope old) =>
      _messengerState != old._messengerState;
}

class Message extends StatefulWidget {
  /// Creates a [Message].
  const Message({
    Key? key,
    this.title,
    this.menus,
    this.constraints,
    this.padding,
    this.duration = const Duration(seconds: 4),
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

  final Duration duration;

  static AnimationController _createAnimationController({
    required TickerProvider vsync,
  }) {
    return AnimationController(
      duration: const Duration(milliseconds: 400),
      debugLabel: 'Message',
      vsync: vsync,
    );
  }

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool _mouseIsConnected;
  AnimationStatus? _previousAnimationStatus;

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
      //_entry.remove();
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
        // onEnter: (_) => _stopTimer(),
        // onExit: (_) => _startTimer(),
        // onHover: (_) => _stopTimer(),
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
