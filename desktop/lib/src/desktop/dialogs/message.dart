import 'dart:async';
import 'dart:collection';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../input/button.dart';
import '../theme/theme.dart';

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
    super.key,
    required this.child,
  });

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
    MessageThemeData? theme,
  }) {
    return _of(context).showMessage(
      context,
      message: message,
      kind: kind,
      duration: duration,
      actions: actions,
      clearMessages: clearMessages,
      theme: theme,
      title: title,
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

  MessageController showMessage(
    BuildContext context, {
    String? title,
    Duration? duration,
    List<MessageAction>? actions,
    required String message,
    required MessageKind kind,
    required bool clearMessages,
    MessageThemeData? theme,
  }) {
    late MessageController entry;
    final MessageThemeData messageThemeData =
        MessageTheme.of(context).merge(theme);

    _messageController ??=
        Message._createAnimationController(messageThemeData, vsync: this);

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
          theme: messageThemeData,
        ),
        maintainState: false,
      ),
      completer: Completer<MessageClosedReason>(),
      hasMenu: actions?.isNotEmpty ?? false,
      duration: duration ?? messageThemeData.duration!,
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

      Overlay.of(context, rootOverlay: true).insert(entry._overlayEntry);
      _startTimer();
    } else {
      _messages.addLast(entry);

      if (_messages.length == 1) {
        _messageController!.forward(from: 0.0);
        Overlay.of(context, rootOverlay: true).insert(entry._overlayEntry);
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
          .insert(_messages.first._overlayEntry);
      _startTimer();
    } else {
      _messageController?.reverse().then<void>((void value) {
        final entry = _messages.removeFirst();
        entry._overlayEntry.remove();
        entry._completer.complete(reason);

        if (_messages.isNotEmpty && _hideTimer == null) {
          Overlay.of(context, rootOverlay: true)
              .insert(_messages.first._overlayEntry);
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
    super.key,
    required super.child,
    required _MessengerState messengerState,
    required int length,
  })  : _messengerState = messengerState,
        _length = length;

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
    super.key,
    this.title,
    this.actions,
    this.animation,
    required this.kind,
    required this.message,
    required this.resumeTimer,
    required this.stopTimer,
    required this.remove,
    this.theme,
  });

  final String message;

  final String? title;

  final List<MessageAction>? actions;

  final MessageKind kind;

  final Animation<double>? animation;

  final VoidCallback resumeTimer;

  final VoidCallback stopTimer;

  final _MessageReasonCallback remove;

  final MessageThemeData? theme;

  static AnimationController _createAnimationController(
    MessageThemeData messageThemeData, {
    required TickerProvider vsync,
  }) {
    return AnimationController(
      duration: messageThemeData.animationDuration!,
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

    _mouseIsConnected = RendererBinding.instance.mouseTracker.mouseIsConnected;
    RendererBinding.instance.mouseTracker
        .addListener(_handleMouseTrackerChange);
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
    RendererBinding.instance.mouseTracker
        .removeListener(_handleMouseTrackerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MessageThemeData messageThemeData =
        MessageTheme.of(context).merge(widget.theme);

    _animation ??= CurvedAnimation(
        parent: widget.animation!, curve: messageThemeData.animationCurve!);

    final Color backgroundColor = messageThemeData.backgroundColor!;
    final Color iconForeground;
    final IconData iconData;

    switch (widget.kind) {
      case MessageKind.info:
        iconData = Icons.info;
        iconForeground = messageThemeData.infoColor!;
        break;
      case MessageKind.error:
        iconData = Icons.error;
        iconForeground = messageThemeData.errorColor!;
        break;
      case MessageKind.warning:
        iconData = Icons.warning;
        iconForeground = messageThemeData.warningColor!;
        break;
      case MessageKind.success:
        iconData = Icons.done;
        iconForeground = messageThemeData.successColor!;
        break;
    }

    Widget result = Container(
      padding: messageThemeData.padding!,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(
            color:
                _hasFocus ? messageThemeData.highlightColor! : iconForeground,
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
                padding: EdgeInsets.only(right: messageThemeData.itemSpacing!),
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
                        padding: messageThemeData.titlePadding!,
                        child: Text(widget.title!,
                            textAlign: TextAlign.start,
                            style: messageThemeData.titleTextStyle!),
                      ),
                    Text(
                      widget.message,
                      textAlign: TextAlign.start,
                      style: messageThemeData.textStyle!,
                    ),
                  ],
                ),
              ),
              if (widget.actions?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(left: messageThemeData.itemSpacing!),
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
