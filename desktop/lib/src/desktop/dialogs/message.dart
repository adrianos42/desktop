import 'dart:async';
import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../input/button.dart';
import '../theme/theme.dart';

const Duration _kDefaultMessageDuration = Duration(seconds: 6);

typedef _MessageReasonCallback = void Function(MessageClosedReason);

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
  /// The message was removed.
  remove,

  /// Timeout.
  timeout,

  /// The message was closed.
  close,

  /// The user dismissed the message.
  dismiss,
}

class MessageAction {
  const MessageAction({
    required this.title,
    required this.onPressed,
  });

  final String title;

  final VoidCallback onPressed;
}

class MessageController {
  const MessageController._({
    required OverlayEntry overlayEntry,
    required Completer<MessageClosedReason> completer,
    required bool hasMenu,
    required Duration duration,
    required this.close,
  })  : _overlayEntry = overlayEntry,
        _completer = completer,
        _durarion = duration,
        _hasMenu = hasMenu;

  final OverlayEntry _overlayEntry;

  final bool _hasMenu;

  final Duration _durarion;

  final Completer<MessageClosedReason> _completer;

  final VoidCallback close;

  Future<MessageClosedReason> get closed => _completer.future;
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
  static MessageController showMessage(
    BuildContext context, {
    required String message,
    required MessageKind kind,
    String? title,
    Duration? duration,
    List<MessageAction>? actions,
    bool clearMessages = false,
  }) {
    return _of(context).showMessage(
      message: message,
      kind: kind,
      duration: duration,
      actions: actions,
      clearMessages: clearMessages,
    );
  }

  /// Removes the current [Message].
  static void removeCurrentMessage(BuildContext context) {
    _of(context).removeCurrentMessage();
  }

  /// Clear all [Message]s.
  static void clearMessages(BuildContext context) {
    _of(context).clearMessages();
  }

  /// The length of [Message]s in the stack.
  static int messagesLength(BuildContext context) {
    return _of(context)._messages.length;
  }

  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> with TickerProviderStateMixin {
  final Queue<MessageController> _messages = Queue<MessageController>();
  AnimationController? _messageController;
  Timer? _hideTimer;

  void _startTimer() {
    _stopTimer();

    if (!_messages.first._hasMenu) {
      _hideTimer = Timer(_messages.first._durarion, () {
        removeCurrentMessage(MessageClosedReason.timeout);
      });
    }
  }

  void _stopTimer() {
    _hideTimer?.cancel();
    _hideTimer = null;
  }

  MessageController showMessage({
    String? title,
    Duration? duration,
    List<MessageAction>? actions,
    required String message,
    required MessageKind kind,
    required bool clearMessages,
  }) {
    _messageController ??= Message._createAnimationController(vsync: this);

    late MessageController entry;

    entry = MessageController._(
      overlayEntry: OverlayEntry(
        builder: (context) => Message(
          message: message,
          kind: kind,
          title: title,
          animation: _messageController,
          stopTimer: _stopTimer,
          resumeTimer: _startTimer,
          remove: removeCurrentMessage,
          actions: actions,
        ),
        maintainState: false,
      ),
      completer: Completer<MessageClosedReason>(),
      hasMenu: actions?.isNotEmpty ?? false,
      duration: duration ?? _kDefaultMessageDuration,
      close: () {
        if (_messages.first == entry) {
          removeCurrentMessage(MessageClosedReason.close);
        } else {
          entry._completer.complete(MessageClosedReason.close);
          _messages.remove(entry);
        }
      },
    );

    if (clearMessages && _messages.isNotEmpty) {
      for (final entry in _messages) {
        entry._completer.complete(MessageClosedReason.remove);
      }

      _messages.first._overlayEntry.remove();
      _messages.clear();

      _messages.addLast(entry);

      Overlay.of(context, rootOverlay: true)?.insert(entry._overlayEntry);
      _startTimer();
    } else {
      _messages.addLast(entry);

      if (_messages.length == 1) {
        _messageController!.forward(from: 0.0);
        Overlay.of(context, rootOverlay: true)?.insert(entry._overlayEntry);
        _startTimer();
      } else {
        setState(() {});
      }
    }

    return entry;
  }

  /// Removes the current [Message].
  void removeCurrentMessage([
    MessageClosedReason reason = MessageClosedReason.remove,
  ]) {
    if (_messages.isEmpty ||
        _messageController!.status == AnimationStatus.dismissed) {
      return;
    }

    if (_messages.length > 1) {
      _stopTimer();

      final entry = _messages.removeFirst();
      entry._overlayEntry.remove();
      entry._completer.complete(reason);

      Overlay.of(context, rootOverlay: true)
          ?.insert(_messages.first._overlayEntry);
      _startTimer();
    } else {
      _messageController?.reverse().then<void>((void value) {
        final entry = _messages.removeFirst();
        entry._overlayEntry.remove();
        entry._completer.complete(reason);

        if (_messages.isNotEmpty && _hideTimer == null) {
          Overlay.of(context, rootOverlay: true)
              ?.insert(_messages.first._overlayEntry);
          _startTimer();
        }
      });
    }
  }

  /// Removes all the messages currently in queue by clearing the queue
  /// and running normal exit animation on the current message.
  void clearMessages() {
    if (_messages.isEmpty ||
        _messageController!.status == AnimationStatus.dismissed) {
      return;
    }

    _hideTimer?.cancel();
    _hideTimer = null;

    for (final entry in _messages) {
      entry._completer.complete(MessageClosedReason.remove);
    }

    final currentMessage = _messages.removeFirst();
    _messages.clear();

    final messageController = _messageController;
    _messageController = null;

    messageController?.reverse().then<void>((void value) {
      currentMessage._overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MessengerScope(
      messengerState: this,
      length: _messages.length,
      child: widget.child,
    );
  }
}

class _MessengerScope extends InheritedWidget {
  const _MessengerScope({
    Key? key,
    required Widget child,
    required _MessengerState messengerState,
    required int length,
  })  : _messengerState = messengerState,
        _length = length,
        super(key: key, child: child);

  final _MessengerState _messengerState;
  final int _length;

  @override
  bool updateShouldNotify(_MessengerScope oldWidget) {
    return _length != oldWidget._length;
  }
}

class Message extends StatefulWidget {
  /// Creates a [Message].
  const Message({
    Key? key,
    this.title,
    this.actions,
    this.constraints,
    this.padding,
    this.duration = const Duration(seconds: 4),
    this.dialogPadding,
    this.animation,
    required this.kind,
    required this.message,
    required this.resumeTimer,
    required this.stopTimer,
    required this.remove,
  }) : super(key: key);

  final String message;

  final String? title;

  final List<MessageAction>? actions;

  final BoxConstraints? constraints;

  final EdgeInsets? padding;

  final EdgeInsets? dialogPadding;

  final MessageKind kind;

  final Duration duration;

  final Animation<double>? animation;

  final VoidCallback resumeTimer;

  final VoidCallback stopTimer;

  final _MessageReasonCallback remove;

  static AnimationController _createAnimationController({
    required TickerProvider vsync,
  }) {
    return AnimationController(
      duration: const Duration(milliseconds: 100),
      debugLabel: 'Message',
      vsync: vsync,
    );
  }

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late bool _mouseIsConnected;
  Animation<double>? _animation;

  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();

    _mouseIsConnected =
        RendererBinding.instance.mouseTracker.mouseIsConnected;
    RendererBinding.instance.mouseTracker
        .addListener(_handleMouseTrackerChange);
    GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
  }

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

  void _handlePointerEvent(PointerEvent event) {
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      // _startTimer();
    } else if (event is PointerDownEvent) {
      // _stopTimer();
    }
  }

  void _setFocus(bool value) {
    _hasFocus = value;
    if (value) {
      widget.stopTimer();
    } else {
      widget.remove(MessageClosedReason.dismiss);
    }
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter
        .removeGlobalRoute(_handlePointerEvent);
    RendererBinding.instance.mouseTracker
        .removeListener(_handleMouseTrackerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    _animation ??= CurvedAnimation(
      parent: widget.animation!,
      curve: Curves.easeInCubic,
    );

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
            color: _hasFocus ? colorScheme.shade[100] : iconForeground,
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
                          textAlign: TextAlign.start,
                          style: textTheme.caption.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    Text(
                      widget.message,
                      textAlign: TextAlign.start,
                      style: textTheme.caption,
                    ),
                  ],
                ),
              ),
              if (widget.actions?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    children: widget.actions!
                        .map(
                          (e) => Button.text(
                            e.title,
                            onPressed: e.onPressed,
                          ),
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );

    result = FadeTransition(opacity: _animation!, child: result);

    if (widget.actions?.isEmpty ?? true) {
      if (_mouseIsConnected) {
        result = MouseRegion(
          onEnter: (_) => !_hasFocus ? widget.stopTimer() : null,
          onExit: (_) => !_hasFocus ? widget.resumeTimer() : null,
          onHover: (_) => !_hasFocus ? widget.stopTimer() : null,
          cursor: SystemMouseCursors.click,
          child: result,
        );
      }

      result = GestureDetector(
        onTap: () => setState(() => _setFocus(!_hasFocus)),
        child: result,
      );
    }

    return Focus(
      child: Container(alignment: Alignment.bottomCenter, child: result),
      autofocus: true,
      debugLabel: 'Dialog',
      onFocusChange: (value) {
        if (widget.actions?.isEmpty ?? true) {
          _setFocus(value);
        }
      },
    );
  }
}
