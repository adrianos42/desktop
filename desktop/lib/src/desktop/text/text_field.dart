import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import '../theme/theme.dart';
//import 'internal/editable_text.dart';

const double _kCursorWidth = 1.0;
const double _kBorderWidth = 1.0;

class TextField extends StatefulWidget {
  const TextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.placeholder,
    this.placeholderStyle,
    this.style,
    this.strutStyle,
    this.showCursor,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.onEditingComplete,
    this.inputFormatters,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.restorationId,
  }) : super(key: key);

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final String? placeholder;

  final TextAlign textAlign;

  final TextStyle? placeholderStyle;

  final bool autofocus;

  final TextEditingController? controller;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  final TextStyle? style;

  final bool readOnly;

  final int? maxLength;

  final int? minLines;

  final int? maxLines;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  final bool enabled;

  final GestureTapCallback? onTap;

  final String? restorationId;

  final TextInputType keyboardType;

  @override
  _TextFieldState createState() => _TextFieldState();
}

abstract class DesktopTextSelectionGestureDetectorBuilderDelegate {
  /// [GlobalKey] to the [EditableText] for which the
  /// [TextSelectionGestureDetectorBuilder] will build a [TextSelectionGestureDetector].
  GlobalKey<EditableTextState> get editableTextKey;

  /// Whether the textfield should respond to force presses.
  bool get forcePressEnabled;

  /// Whether the user may select text in the textfield.
  bool get selectionEnabled;
}

class _TextFieldState extends State<TextField>
    with AutomaticKeepAliveClientMixin<TextField>, RestorationMixin
    implements DesktopTextSelectionGestureDetectorBuilderDelegate {
  final GlobalKey _clearGlobalKey = GlobalKey();

  RestorableTextEditingController? _controller;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!.value;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  bool get forcePressEnabled => true;

  @override
  bool get selectionEnabled => true;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _createLocalController();
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void dispose() {
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;
  }

  @override
  void restoreState(RestorationBucket? olbBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
    _controller!.value.addListener(updateKeepAlive);
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause cause) {
    if (cause == SelectionChangedCause.longPress) {}
  }

  @override
  bool get wantKeepAlive => _controller?.value.text.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ThemeData theme = Theme.of(context);
    final bool enabled = widget.enabled;

    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final HSLColor background = enabled
        ? _effectiveFocusNode.hasFocus
            ? colorScheme.background
            : colorScheme.background.withAlpha(0.0)
        : colorScheme.shade1;
    final HSLColor characterColor =
        enabled ? textTheme.textHigh : colorScheme.disabled;
    final HSLColor selectionColor = enabled ? colorScheme.primary2 : background;
    final HSLColor borderColor = _effectiveFocusNode.hasFocus
        ? colorScheme.shade5
        : colorScheme.shade6;

    final textStyle = textTheme.body1.copyWith(
      color: characterColor.toColor(),
    );

    final decoration = BoxDecoration(
      color: background.toColor(),
      border: enabled
          ? Border.all(color: borderColor.toColor(), width: _kBorderWidth)
          : null,
    );

    final editable = EditableText(
      key: editableTextKey,
      //autocorrect: true,
      //autocorrectionTextRectColor: ,
      //autofillHints: ,
      autofocus: widget.autofocus,
      backgroundCursorColor: background.toColor(), // FIXME
      controller: _effectiveController,
      cursorColor: characterColor.toColor(),
      //cursorHeight: ,
      cursorOffset: Offset.zero,
      cursorOpacityAnimates: false,
      //cursorRadius: ,
      cursorWidth: _kCursorWidth,
      //dragStartBehavior: ,
      //enableInteractiveSelection: ,
      expands: false,
      focusNode: _effectiveFocusNode,
      inputFormatters: widget.inputFormatters,
      //keyboardAppearance: ,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      //obscureText: ,
      //obscuringCharacter: ,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      //onSelectionChanged: ,
      onSubmitted: widget.onSubmitted,
      paintCursorAboveText: false,
      readOnly: widget.readOnly,
      //rendererIgnoresPointer: ,
      restorationId: 'editable',
      //scrollController: ,
      //scrollPadding: ,
      //scrollPhysics: ,
      selectionColor:
          enabled ? selectionColor.toColor() : colorScheme.background.toColor(),
      //selectionControls: ,
      //selectionHeightStyle: ,
      //selectionWidthStyle: ,
      showCursor: widget.showCursor,
      showSelectionHandles: false,
      //smartDashesType: ,
      //smartQuotesType: ,
      strutStyle: widget.strutStyle,
      style: widget.style ?? textStyle,
      textAlign: widget.textAlign,
      //textCapitalization: ,
      //textInputAction: ,
      //toolbarOptions: ,
    );

    Widget result = IgnorePointer(
      ignoring: !enabled,
      child: MouseRegion(
        cursor: SystemMouseCursors.text,
        child: RepaintBoundary(
          child: UnmanagedRestorationScope(
            bucket: bucket,
            child: Container(
              decoration: decoration,
              child: Align(
                alignment: Alignment.center,
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                  child: editable,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (kIsWeb) {
      return Shortcuts(
        shortcuts: scrollShortcutOverrides,
        child: result,
      );
    }

    return result;
  }
}
