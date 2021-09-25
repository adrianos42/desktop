import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

//import 'editable_text.dart';

export 'package:flutter/services.dart'
    show
        TextInputType,
        TextInputAction,
        TextCapitalization,
        SmartQuotesType,
        SmartDashesType;

const double _kCursorWidth = 1.0;
const double _kBorderWidth = 1.0;

/// Desktop text field.
///
/// See also:
///
///  * [EditableText], which is the raw text editing control.
class TextField extends StatefulWidget {
  /// Creates a desktop text field.
  const TextField({
    Key? key,
    this.autocorrect = true,
    this.autofocus = false,
    this.controller,
    this.cursorWidth = 2.0,
    this.decoration,
    this.enabled = true,
    this.expands = false,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.scrollController,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTap,
    this.placeholder,
    this.placeholderStyle,
    this.readOnly = false,
    this.restorationId,
    this.showCursor,
    this.strutStyle,
    this.style,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.textAlign = TextAlign.start,
  })  : assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        super(key: key);

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final String? placeholder;

  final TextStyle? placeholderStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// Controls the [BoxDecoration] of the box behind the text input.
  final BoxDecoration? decoration;

  final TextEditingController? controller;

  /// {@macro flutter.widgets.editableText.obscuringCharacter}
  final String obscuringCharacter;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///    automatically shift the focus to the next/previous focusable item when
  ///    the user is done editing.
  final ValueChanged<String>? onSubmitted;

  final bool enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.material.textfield.onTap}
  final GestureTapCallback? onTap;

  /// {@macro flutter.material.textfield.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField>
    with AutomaticKeepAliveClientMixin<TextField>, RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate {
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

  // void _handleSelectionChanged(
  //     TextSelection selection, SelectionChangedCause cause) {
  //   if (cause == SelectionChangedCause.longPress) {}
  // }

  @override
  bool get wantKeepAlive => _controller?.value.text.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;

    final ThemeData theme = Theme.of(context);
    final bool enabled = widget.enabled;

    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final Color background = enabled
        ? focusNode.hasFocus
            ? colorScheme.background[0]
            : colorScheme.background.withAlpha(0.0).toColor()
        : colorScheme.shade[90];
    final Color characterColor =
        enabled ? textTheme.textHigh : colorScheme.disabled;
    final Color selectionColor = enabled ? colorScheme.primary[30] : background;
    final Color borderColor =
        focusNode.hasFocus ? colorScheme.shade[50] : colorScheme.shade[40];

    final textStyle = textTheme.body1.copyWith(
      color: characterColor,
    );

    final decoration = widget.decoration ??
        BoxDecoration(
          color: background,
          border: enabled
              ? Border.all(color: borderColor, width: _kBorderWidth)
              : null,
        );

    final editable = EditableText(
      key: editableTextKey,
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      backgroundCursorColor: background, // TODO(as): ???
      controller: controller,
      cursorColor: characterColor,
      cursorOffset: Offset.zero,
      cursorOpacityAnimates: false,
      cursorWidth: _kCursorWidth,
      dragStartBehavior: DragStartBehavior.down,
      enableInteractiveSelection: true,
      expands: widget.expands,
      focusNode: focusNode,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      obscureText: widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      paintCursorAboveText: false,
      rendererIgnoresPointer: true,
      readOnly: widget.readOnly,
      restorationId: 'editable',
      scrollController: widget.scrollController,
      selectionColor: enabled ? selectionColor : colorScheme.background[0],
      showCursor: widget.showCursor,
      showSelectionHandles: false,
      strutStyle: widget.strutStyle,
      style: widget.style ?? textStyle,
      textAlign: widget.textAlign,
    );

    final Widget result = IgnorePointer(
      ignoring: !enabled,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: TextSelectionGestureDetectorBuilder(delegate: this)
                    .buildGestureDetector(
                  child: editable,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // if (kIsWeb) {
    //   return Shortcuts(
    //     shortcuts: scrollShortcutOverrides,
    //     child: result,
    //   );
    // }

    return result;
  }
}
