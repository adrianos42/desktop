import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import 'theme.dart';
//import 'internal/editable_text.dart';

const double _kCursorWidth = 1.0;
const double _kBorderWidth = 1.0;

class TextField extends StatefulWidget {
  const TextField({
    Key? key,
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
    this.maxLines = 1,
  }) : super(key: key);

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final String? placeholder;

  final TextAlign textAlign;

  final TextStyle? placeholderStyle;

  final bool autofocus;

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
    with AutomaticKeepAliveClientMixin
    implements DesktopTextSelectionGestureDetectorBuilderDelegate {
  final GlobalKey _clearGlobalKey = GlobalKey();

  late TextEditingController _controller;
  TextEditingController get _effectiveController => _controller;

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

  void _handleFocusChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: '');
    _controller.addListener(updateKeepAlive);
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(TextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool isEnabled = widget.enabled;
    final bool wasEnabled = oldWidget.enabled;

    if (wasEnabled && !isEnabled) {
      _effectiveFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(updateKeepAlive);
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    super.dispose();
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause cause) {
    if (cause == SelectionChangedCause.longPress) {}
  }

  @override
  bool get wantKeepAlive => _controller.text.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ThemeData theme = Theme.of(context);
    final bool enabled = widget.enabled;

    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final Color background = enabled
        ? _effectiveFocusNode.hasFocus
            ? colorScheme.background
            : colorScheme.background.withOpacity(0.0)
        : colorScheme.overlay3;
    final Color characterColor =
        enabled ? textTheme.textHigh : colorScheme.overlay8;
    final Color selectionColor = enabled ? colorScheme.primary3 : background;
    final Color borderColor = _effectiveFocusNode.hasFocus
        ? colorScheme.overlay10
        : colorScheme.overlay6;

    final textStyle = textTheme.body1.copyWith(
      color: characterColor,
    );

    final decoration = BoxDecoration(
      color: background,
      border:
          enabled ? Border.all(color: borderColor, width: _kBorderWidth) : null,
    );

    final editable = EditableText(
      key: editableTextKey,
      controller: _effectiveController,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      focusNode: _effectiveFocusNode,
      keyboardType: TextInputType.text,
      style: widget.style ?? textStyle,
      backgroundCursorColor: background, // FIXME
      textAlign: widget.textAlign,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: false,
      selectionColor: enabled ? selectionColor : colorScheme.background,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      cursorWidth: _kCursorWidth,
      cursorColor: characterColor,
      cursorOffset: Offset.zero,
      inputFormatters: widget.inputFormatters,
      strutStyle: widget.strutStyle,
      onSubmitted: widget.onSubmitted,
      //obscureText: false,
      //paintCursorAboveText: true,
      //cursorOpacityAnimates: false,
    );

    Widget result = IgnorePointer(
      ignoring: !enabled,
      child: MouseRegion(
        cursor: SystemMouseCursors.text,
        child: RepaintBoundary(
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
    );

    return result;
  }
}
