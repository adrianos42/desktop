import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../text/text_field.dart';

export 'package:flutter/services.dart' show SmartDashesType, SmartQuotesType;

// TODO(as): Set in theme.
const double _kBorderWidth = 1.0;

/// A [FormField] that contains a [TextField].
class TextFormField extends FormField<String> {
  /// Creates a [TextFormField].
  TextFormField({
    super.key,
    this.controller,
    String? initialValue,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    super.onSaved,
    super.validator,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    double? cursorHeight,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    super.restorationId,
    bool enableIMEPersonalizedLearning = true,
    this.prefix,
    this.focusNode,
    // MouseCursor? mouseCursor,
  })  : assert(initialValue == null || controller == null),
        assert(obscuringCharacter.length == 1),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "MinLines can't be greater than maxLines.",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'MinLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength > 0),
        super(
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          enabled: enabled,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<String> field) {
            final _TextFormFieldState state = field as _TextFormFieldState;

            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            final FocusNode effectiveFocusNode = state._effectiveFocusNode;

            final ThemeData themeData = Theme.of(field.context);
            final ColorScheme colorScheme = themeData.colorScheme;
            final TextTheme textTheme = themeData.textTheme;

            final Widget? error = field.errorText != null
                ? Text(
                    field.errorText!,
                    style: textTheme.caption.copyWith(
                      color: textTheme.textError,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : null;

            final Color background =
                enabled ? colorScheme.background[0] : colorScheme.shade[90];

            final foreground = effectiveFocusNode.hasFocus
                ? colorScheme.shade[50]
                : colorScheme.shade[30];

            final Color borderColor = foreground;

            final BoxDecoration decoration = BoxDecoration(
              color: background,
              border: enabled
                  ? Border.all(color: borderColor, width: _kBorderWidth)
                  : null,
            );

            final TextStyle prefixTextStyle = textTheme.caption.copyWith(
              color: foreground,
              fontWeight: FontWeight.w500,
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: decoration,
                  child: Padding(
                    padding: decoration.padding!,
                    child: Row(
                      children: [
                        if (prefix != null)
                          Padding(
                            // Considering the padding inside [TextField].
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              prefix,
                              style: prefixTextStyle,
                            ),
                          ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: UnmanagedRestorationScope(
                              bucket: field.bucket,
                              child: TextField(
                                restorationId: restorationId,
                                controller: state._effectiveController,
                                focusNode: effectiveFocusNode,
                                decoration: const BoxDecoration(),
                                keyboardType: keyboardType,
                                textInputAction: textInputAction,
                                style: style,
                                strutStyle: strutStyle,
                                textAlign: textAlign,
                                textDirection: textDirection,
                                textCapitalization: textCapitalization,
                                autofocus: autofocus,
                                toolbarOptions: toolbarOptions,
                                readOnly: readOnly,
                                showCursor: showCursor,
                                obscuringCharacter: obscuringCharacter,
                                obscureText: obscureText,
                                autocorrect: autocorrect,
                                smartDashesType: smartDashesType ??
                                    (obscureText
                                        ? SmartDashesType.disabled
                                        : SmartDashesType.enabled),
                                smartQuotesType: smartQuotesType ??
                                    (obscureText
                                        ? SmartQuotesType.disabled
                                        : SmartQuotesType.enabled),
                                enableSuggestions: enableSuggestions,
                                maxLines: maxLines,
                                minLines: minLines,
                                expands: expands,
                                maxLength: maxLength,
                                onChanged: onChangedHandler,
                                onTap: onTap,
                                onEditingComplete: onEditingComplete,
                                onSubmitted: onFieldSubmitted,
                                inputFormatters: inputFormatters,
                                enabled: enabled,
                                cursorWidth: cursorWidth,
                                cursorHeight: cursorHeight,
                                scrollPadding: scrollPadding,
                                enableInteractiveSelection:
                                    enableInteractiveSelection ??
                                        (!obscureText || !readOnly),
                                selectionControls: selectionControls,
                                autofillHints: autofillHints,
                                scrollController: scrollController,
                                enableIMEPersonalizedLearning:
                                    enableIMEPersonalizedLearning,
                                maxLengthEnforcement: maxLengthEnforcement,
                                // mouseCursor: mouseCursor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: error,
                    ),
                  ),
              ],
            );
          },
        );

  ///
  final TextEditingController? controller;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Text that is displayed at the start of the input.
  final String? prefix;

  @override
  FormFieldState<String> createState() => _TextFormFieldState();
}

class _TextFormFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      _textFormField.controller ?? _controller!.value;

  TextFormField get _textFormField => super.widget as TextFormField;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      _textFormField.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);

    if (_controller != null) {
      _registerController();
    }

    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);

    registerForRestoration(_controller!, 'controller');
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
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

  void _handleFocusChanged() => setState(() {});

  @override
  void initState() {
    super.initState();

    if (_textFormField.controller == null) {
      _createLocalController(
        widget.initialValue != null
            ? TextEditingValue(text: widget.initialValue!)
            : null,
      );
    } else {
      _textFormField.controller!.addListener(_handleControllerChanged);
    }

    _effectiveFocusNode.canRequestFocus = widget.enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(TextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_textFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _textFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _textFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_textFormField.controller != null) {
        setValue(_textFormField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }

    if (_textFormField.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (_textFormField.focusNode ?? _focusNode)
          ?.addListener(_handleFocusChanged);
    }

    _effectiveFocusNode.canRequestFocus = widget.enabled;
  }

  @override
  void dispose() {
    _textFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }
}
