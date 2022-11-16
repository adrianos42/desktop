import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

export 'package:flutter/services.dart'
    show
        TextInputType,
        TextInputAction,
        TextCapitalization,
        SmartQuotesType,
        SmartDashesType;

const double _kCursorWidth = 1.0;
const double _kBorderWidth = 1.0;

// TODO(as): Set in theme data.
const double _kDefaultHeight = 32.0;

class _TextFieldSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilder({
    required _TextFieldState state,
  })  : _state = state,
        super(delegate: state);

  final _TextFieldState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onSingleLongTapMoveUpdate(LongPressMoveUpdateDetails details) {
    if (delegate.selectionEnabled) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          renderEditable.selectPositionAt(
            from: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          renderEditable.selectWordsInRange(
            from: details.globalPosition - details.offsetFromOrigin,
            to: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
      }
    }
  }

  @override
  void onSingleTapUp(TapUpDetails details) {
    editableText.hideToolbar();
    if (delegate.selectionEnabled) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          switch (details.kind) {
            case PointerDeviceKind.mouse:
            case PointerDeviceKind.stylus:
            case PointerDeviceKind.invertedStylus:
              renderEditable.selectPosition(cause: SelectionChangedCause.tap);
              break;
            case PointerDeviceKind.touch:
            case PointerDeviceKind.unknown:
              renderEditable.selectWordEdge(cause: SelectionChangedCause.tap);

              break;
            default:
              break;
          }
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          renderEditable.selectPosition(cause: SelectionChangedCause.tap);
          break;
      }
    }
    _state._requestKeyboard();
    _state.widget.onTap?.call();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    if (delegate.selectionEnabled) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          renderEditable.selectPositionAt(
            from: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          renderEditable.selectWord(cause: SelectionChangedCause.longPress);
          break;
      }
    }
  }
}

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
    this.clipBehavior = Clip.hardEdge,
    this.controller,
    this.cursorWidth = _kCursorWidth,
    this.decoration,
    this.enabled = true,
    this.expands = false,
    this.focusNode,
    this.inputFormatters,
    this.scrollController,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textDirection,
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
    this.enableSuggestions = false,
    this.dragStartBehavior = DragStartBehavior.down,
    this.cursorHeight,
    this.autofillHints = const <String>[],
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection = true,
    this.onAppPrivateCommand,
    this.selectionControls,
    this.textInputAction,
    this.scrollBehavior,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    TextInputType? keyboardType,
    ToolbarOptions? toolbarOptions,
    this.scrollPadding = const EdgeInsets.all(0),
    this.textCapitalization = TextCapitalization.none,
    this.maxLengthEnforcement,
    // TODO(as): Remove it when TextField's style is created.
    this.padding,
  })  : smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(!obscureText || maxLines == 1,
            'Obscured fields cannot be multiline.'),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !identical(textInputAction, TextInputAction.newline) ||
              maxLines == 1 ||
              !identical(keyboardType, TextInputType.text),
          'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline TextField.',
        ),
        assert(obscuringCharacter.length == 1),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        toolbarOptions = toolbarOptions ??
            (obscureText
                ? const ToolbarOptions(
                    selectAll: true,
                    paste: true,
                  )
                : const ToolbarOptions(
                    copy: true,
                    cut: true,
                    selectAll: true,
                    paste: true,
                  )),
        super(key: key);

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final String? placeholder;

  final TextStyle? placeholderStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

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

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  final TextStyle? style;

  final Clip clipBehavior;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  final ToolbarOptions toolbarOptions;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///    automatically shift the focus to the next/previous focusable item when
  ///    the user is done editing.
  final ValueChanged<String>? onSubmitted;

  final bool enabled;

  /// {@macro flutter.widgets.editableText.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// {@macro flutter.services.TextInputConfiguration.smartDashesType}
  final SmartDashesType smartDashesType;

  /// {@macro flutter.services.TextInputConfiguration.smartQuotesType}
  final SmartQuotesType smartQuotesType;

  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.material.textfield.onTap}
  final GestureTapCallback? onTap;

  /// {@macro flutter.material.textfield.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.services.textFormatter.effectiveMaxLengthEnforcement}
  ///
  /// {@macro flutter.services.textFormatter.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// {@template flutter.widgets.shadow.scrollBehavior}
  final ScrollBehavior? scrollBehavior;

  ///
  final EdgeInsets? padding;

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

  late _TextFieldSelectionGestureDetectorBuilder
      _selectionGestureDetectorBuilder;

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(
          defaultTargetPlatform);

  EditableTextState? get _editableText => editableTextKey.currentState;

  bool _hovering = false;

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  void _handleFocusChanged() => setState(() {});

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
    _selectionGestureDetectorBuilder =
        _TextFieldSelectionGestureDetectorBuilder(state: this);
    if (widget.controller == null) {
      _createLocalController();
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
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

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
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

  void _handleHover(bool value) {
    if (value != _hovering) {
      setState(() => _hovering = value);
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

    final TextSelectionControls? textSelectionControls =
        widget.selectionControls;

    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;

    final ThemeData themeData = Theme.of(context);
    final bool enabled = widget.enabled;

    final textTheme = themeData.textTheme;
    final colorScheme = themeData.colorScheme;

    final Color background =
        enabled ? colorScheme.background[0] : colorScheme.shade[90];
    final Color characterColor =
        enabled ? textTheme.textHigh : colorScheme.disabled;
    final Color selectionColor = enabled ? colorScheme.primary[30] : background;
    final Color borderColor =
        focusNode.hasFocus ? colorScheme.shade[50] : colorScheme.shade[30];

    final textStyle = textTheme.body1.copyWith(
      color: characterColor,
    );

    const Brightness keyboardAppearance = Brightness.dark;

    final decoration = widget.decoration ??
        BoxDecoration(
          color: background,
          border: enabled
              ? Border.all(color: borderColor, width: _kBorderWidth)
              : null,
        );

    final MouseCursor effectiveMouseCursor = widget.enabled && _hovering
        ? SystemMouseCursors.text
        : SystemMouseCursors.basic;

    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    final editable = EditableText(
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      backgroundCursorColor: background, // TODO(as): ???
      controller: controller,
      cursorColor: characterColor,
      cursorHeight: widget.cursorHeight,
      cursorOffset: Offset.zero,
      cursorOpacityAnimates: false,
      cursorRadius: Radius.zero,
      cursorWidth: widget.cursorWidth,
      dragStartBehavior: widget.dragStartBehavior,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableSuggestions: widget.enableSuggestions,
      expands: widget.expands,
      focusNode: focusNode,
      inputFormatters: formatters,
      key: editableTextKey,
      keyboardAppearance: keyboardAppearance,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      obscureText: widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      paintCursorAboveText: true,
      readOnly: widget.readOnly,
      rendererIgnoresPointer: true,
      restorationId: 'editable',
      scrollBehavior: widget.scrollBehavior ?? const _InputScrollBehavior(),
      scrollController: widget.scrollController,
      scrollPadding: widget.scrollPadding,
      selectionColor: enabled ? selectionColor : colorScheme.background[0],
      selectionControls:
          widget.enableInteractiveSelection ? textSelectionControls : null,
      showCursor: widget.showCursor,
      showSelectionHandles: false,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      strutStyle: widget.strutStyle,
      style: widget.style ?? textStyle,
      textAlign: widget.textAlign,
      textCapitalization: widget.textCapitalization,
      textDirection: widget.textDirection,
      textInputAction: widget.textInputAction,
      toolbarOptions: widget.toolbarOptions,
      mouseCursor: MouseCursor.defer,
    );

    final bool isMultiline = widget.maxLines != 1;

    final Widget result = ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: TextFieldTapRegion(
        child: MouseRegion(
          cursor: effectiveMouseCursor,
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          child: IgnorePointer(
            ignoring: !enabled,
            child: RepaintBoundary(
              child: UnmanagedRestorationScope(
                bucket: bucket,
                child: Container(
                  decoration: decoration,
                  height: isMultiline ? _kDefaultHeight : null,
                  alignment: isMultiline ? Alignment.topLeft : Alignment.center,
                  child: Padding(
                    padding: widget.padding ??
                        const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 4.0,
                        ),
                    child:
                        _selectionGestureDetectorBuilder.buildGestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: editable,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return result;
  }
}

/// Default [ScrollBehavior] for desktop.
class _InputScrollBehavior extends ScrollBehavior {
  /// Creates a [DesktopScrollBehavior].
  const _InputScrollBehavior() : super();

  /// Applies a [Scrollbar] to the child widget.
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
