import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../localizations.dart';
import '../theme/theme.dart';
import '../input/button.dart';

const Duration _kDialogDuration = Duration(milliseconds: 300);
const Curve _kDialogCurve = Curves.easeOut;

class DialogAction {
  const DialogAction({
    required this.title,
    required this.onPressed,
  });

  final String title;

  final VoidCallback onPressed;
}

/// The reason the dialog was closed.
enum DialogClosedReason {
  /// The message was closed.
  close,

  /// The user dismissed the dialog.
  dismiss,
}

class DialogController {
  const DialogController._({
    required OverlayEntry overlayEntry,
    required Completer<DialogClosedReason> completer,
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

  final Completer<DialogClosedReason> _completer;

  final VoidCallback close;

  Future<DialogClosedReason> get closed => _completer.future;
}

// class DialogScope extends InheritedWidget {
//   /// Creates a [DialogScope].
//   DialogScope({
//     Key? key,
//     required Widget child,
//   }) : super(key: key, child: child);

//   DialogController? _currentDialogController;

//   static void closeDialog(BuildContext context) {
//     final DialogScope scope =
//         context.dependOnInheritedWidgetOfExactType<DialogScope>()!;

//     final DialogController? currentDialogController =
//         scope._currentDialogController;

//     if (currentDialogController != null) {
//       currentDialogController.close();
//     }

//     scope._currentDialogController = null;
//   }

//   @override
//   bool updateShouldNotify(DialogScope oldWidget) {
//     return _currentDialogController != oldWidget._currentDialogController;
//   }
// }

class _DialogView extends StatefulWidget {
  const _DialogView({
    required this.builder,
    required this.close,
    required this.closeComplete,
    required this.dismissible,
    this.barrierColor,
    Key? key,
  }) : super(key: key);

  final WidgetBuilder builder;
  final VoidCallback close;
  final void Function(DialogClosedReason) closeComplete;
  final bool dismissible;
  final Color? barrierColor;

  @override
  _DialogViewState createState() => _DialogViewState();
}

class _DialogViewState extends State<_DialogView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  void dismiss() {
    if (widget.dismissible) {
      close();
    }
  }

  void close([DialogClosedReason reason = DialogClosedReason.dismiss]) {
    widget.closeComplete(reason);
    controller.reverse().then<void>((void value) => widget.close());
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: _kDialogDuration,
      debugLabel: 'Dialog',
      vsync: this,
    );

    animation = CurvedAnimation(
      curve: _kDialogCurve,
      reverseCurve: _kDialogCurve.flipped,
      parent: controller,
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Color barrierColor =
        widget.barrierColor ?? DialogTheme.of(context).barrierColor!;

    return FadeTransition(
      opacity: animation,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: dismiss,
        child: Container(
          color: barrierColor,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {},
            child: Builder(
              builder: widget.builder,
            ),
          ),
        ),
      ),
    );
  }
}

class Dialog extends StatelessWidget {
  /// Creates a [Dialog].
  const Dialog({
    Key? key,
    this.title,
    this.actions,
    this.constraints,
    //this.padding,
    //this.dialogPadding,
    required this.body,
  }) : super(key: key);

  /// The widget placed between the title and menus.
  final Widget body;

  /// The widget placed above the body.
  final Widget? title;

  /// Widgets to be placed at the bottom right of the dialog.
  final List<DialogAction>? actions;

  /// The constraints for the dialog.
  final BoxConstraints? constraints;

  // final EdgeInsets? padding;

  //final EdgeInsets? dialogPadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    final DialogThemeData dialogThemeData = DialogTheme.of(context);

    final Color backgroundColor = dialogThemeData.background!;

    Widget result = Container(
      constraints: constraints ?? dialogThemeData.constraints,
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: dialogThemeData.titlePadding,
              child: DefaultTextStyle(
                child: title!, // TODO(as): ???
                style: dialogThemeData.titleTextStyle!,
              ),
            ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                0.0,
                dialogThemeData.bodyPadding.top,
                0.0,
                dialogThemeData.bodyPadding.bottom,
              ),
              child: SingleChildScrollView(
                controller: ScrollController(),
                padding: EdgeInsets.fromLTRB(
                  dialogThemeData.bodyPadding.left,
                  0.0,
                  dialogThemeData.bodyPadding.right,
                  0.0,
                ),
                child: DefaultTextStyle(
                  child: body,
                  textAlign: dialogThemeData.bodyTextAlign!,
                  style: textTheme.body1,
                ),
              ),
            ),
          ),
          if (actions != null)
            Container(
              alignment: Alignment.centerRight,
              padding: dialogThemeData.menuPadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: actions!
                    .map(
                      (e) => Button.text(
                        e.title,
                        padding: EdgeInsets.zero,
                        onPressed: e.onPressed,
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );

    result = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(flex: 2),
        Flexible(child: result, flex: 8),
        const Spacer(flex: 2),
      ],
    );

    return Focus(
      child: Center(child: result),
      autofocus: true,
      debugLabel: 'Dialog',
    );
  }
}

DialogController showDialog(
  BuildContext context, {
  required WidgetBuilder builder,
  Duration? duration,
  List<DialogAction>? actions,
  Color? barrierColor,
  bool dismissible = true,
}) {
  final GlobalKey<_DialogViewState> viewKey = GlobalKey<_DialogViewState>();

  late DialogController entry;
  entry = DialogController._(
    overlayEntry: OverlayEntry(
      builder: (context) => _DialogView(
        key: viewKey,
        builder: builder,
        dismissible: dismissible,
        barrierColor: barrierColor,
        close: () => entry._overlayEntry.remove(),
        closeComplete: (reason) {
          if (!entry._completer.isCompleted) {
            entry._completer.complete(reason);
          }
        },
      ),
      maintainState: false,
    ),
    completer: Completer<DialogClosedReason>(),
    hasMenu: actions?.isNotEmpty ?? false,
    duration: duration ?? _kDialogDuration,
    close: () => viewKey.currentState!.close(DialogClosedReason.close),
  );

  Overlay.of(context, rootOverlay: true)!.insert(entry._overlayEntry);

  return entry;
}
