import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import 'selection_menubar.dart';

const double _kCursorWidth = 1.0;
const int iOSHorizontalOffset = -2;

class _SelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _SelectionGestureDetectorBuilder({required _SelectableTextState state})
    : _state = state,
      super(delegate: state);

  final _SelectableTextState _state;

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    if (!delegate.selectionEnabled) {
      return;
    }
    super.onSingleTapUp(details);
    _state.widget.onTap?.call();
  }
}

/// Selectable text.
class SelectableText extends StatefulWidget {
  /// Creates a selectable text.
  const SelectableText(
    String this.text, {
    super.key,
    this.autofocus = false,
    this.cursorWidth = _kCursorWidth,
    this.focusNode,
    this.maxLines,
    this.minLines,
    this.textDirection,
    this.onTap,
    this.showCursor = false,
    this.enableInteractiveSelection = true,
    this.strutStyle,
    this.style,
    this.cursorColor,
    this.scrollBehavior,
    this.scrollPhysics,
    this.scrollController,
    this.enabled = true,
    this.textAlign,
    this.selectionColor,
    this.cursorHeight,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.onSelectionChanged,
  }) : assert(
         (maxLines == null) || (minLines == null) || (maxLines >= minLines),
         "minLines can't be greater than maxLines",
       ),
       assert(maxLines == null || maxLines > 0),
       assert(minLines == null || minLines > 0),
       textSpan = null;

  ///
  const SelectableText.rich(
    TextSpan this.textSpan, {
    super.key,
    this.autofocus = false,
    this.cursorWidth = _kCursorWidth,
    this.focusNode,
    this.maxLines,
    this.minLines,
    this.textDirection,
    this.onTap,
    this.showCursor = false,
    this.enableInteractiveSelection = true,
    this.strutStyle,
    this.style,
    this.cursorColor,
    this.scrollBehavior,
    this.scrollPhysics,
    this.scrollController,
    this.enabled = true,
    this.textAlign,
    this.selectionColor,
    this.cursorHeight,
    this.selectionControls,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.dragStartBehavior = DragStartBehavior.start,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.onSelectionChanged,
  }) : assert(
         (maxLines == null) || (minLines == null) || (maxLines >= minLines),
         "minLines can't be greater than maxLines",
       ),
       assert(maxLines == null || maxLines > 0),
       assert(minLines == null || minLines > 0),
       text = null;

  ///
  final String? text;

  ///
  final TextSpan? textSpan;

  ///
  final bool enabled;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final Color? cursorColor;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign? textAlign;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  final Color? selectionColor;

  /// {@macro flutter.material.textfield.onTap}
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// {@macro flutter.widgets.editableText.onSelectionChanged}
  final SelectionChangedCallback? onSelectionChanged;

  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.scrollBehavior}
  final ScrollBehavior? scrollBehavior;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionMenubar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  State<SelectableText> createState() => _SelectableTextState();
}

class _SelectableTextState extends State<SelectableText>
    implements TextSelectionGestureDetectorBuilderDelegate {
  EditableTextState? get _editableText => editableTextKey.currentState;

  late _TextSpanEditingController _controller;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode(skipTraversal: true));

  late _SelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;

  void _handleFocusChanged() {
    setState(() {}); // TODO(as): ?
  }

  void _onControllerChanged() {
    final bool showSelectionHandles =
        !_effectiveFocusNode.hasFocus || !_controller.selection.isCollapsed;
    if (showSelectionHandles == _showSelectionHandles) {
      return;
    }
    setState(() {
      _showSelectionHandles = showSelectionHandles;
    });
  }

  bool _showSelectionHandles = false;

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    widget.onSelectionChanged?.call(selection, cause);

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.base);
        }
        return;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
    }
  }

  void _handleSelectionHandleTapped() {
    if (_controller.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    if (_controller.selection.isCollapsed) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress) {
      return true;
    }

    if (_controller.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  late bool forcePressEnabled;

  @override
  bool get selectionEnabled => widget.enabled;

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder = _SelectionGestureDetectorBuilder(
      state: this,
    );
    _controller = _TextSpanEditingController(
      textSpan: widget.textSpan ?? TextSpan(text: widget.text),
    );
    _controller.addListener(_onControllerChanged);
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _controller.removeListener(_onControllerChanged);
    _focusNode?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SelectableText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text ||
        widget.textSpan != oldWidget.textSpan) {
      _controller.removeListener(_onControllerChanged);
      _controller = _TextSpanEditingController(
        textSpan: widget.textSpan ?? TextSpan(text: widget.text),
      );
      _controller.addListener(_onControllerChanged);
    }
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }
    if (_effectiveFocusNode.hasFocus && _controller.selection.isCollapsed) {
      _showSelectionHandles = false;
    } else {
      _showSelectionHandles = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextSelectionControls? textSelectionControls =
        widget.selectionControls;

    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(
      context,
    );
    final FocusNode focusNode = _effectiveFocusNode;

    final ThemeData theme = Theme.of(context);
    final bool enabled = widget.enabled;

    final colorScheme = theme.colorScheme;

    final Color background = colorScheme.background[0].withAlpha(0);
    // final Color characterColor =
    //     enabled ? textTheme.textHigh : colorScheme.disabled;

    final bool paintCursorAboveText;
    final bool cursorOpacityAnimates;
    final Offset cursorOffset;
    final Color cursorColor;
    final Color selectionColor;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        //final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = true;
        // textSelectionControls ??= cupertinoTextSelectionHandleControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates = true;
        cursorColor =
            widget.cursorColor ??
            selectionStyle.cursorColor ??
            colorScheme.primary[40];
        selectionColor =
            selectionStyle.selectionColor ?? colorScheme.primary[50];
        cursorOffset = Offset(
          iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context),
          0,
        );
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        // textSelectionControls ??= materialTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor =
            widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary[40];
        cursorOffset = Offset.zero;
        selectionColor = enabled ? colorScheme.primary[50] : background;
        break;

      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        forcePressEnabled = false;
        // textSelectionControls ??= desktopTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor =
            widget.cursorColor ??
            selectionStyle.cursorColor ??
            theme.colorScheme.primary[40];
        cursorOffset = Offset.zero;
        selectionColor = enabled ? colorScheme.primary[50] : background;
        break;
    }

    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

    TextStyle? effectiveTextStyle = widget.style;
    if (effectiveTextStyle == null || effectiveTextStyle.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(
        widget.style ?? _controller._textSpan.style,
      );
    }

    final editable = EditableText(
      key: editableTextKey,
      style: effectiveTextStyle,
      readOnly: true,
      textWidthBasis: widget.textWidthBasis ?? defaultTextStyle.textWidthBasis,
      textHeightBehavior:
          widget.textHeightBehavior ?? defaultTextStyle.textHeightBehavior,
      showSelectionHandles: _showSelectionHandles,
      showCursor: widget.showCursor,
      controller: _controller,
      focusNode: focusNode,
      strutStyle: widget.strutStyle ?? const StrutStyle(),
      textAlign:
          widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: widget.textDirection,
      autofocus: widget.autofocus,
      forceLine: false,
      minLines: widget.minLines,
      maxLines: widget.maxLines ?? defaultTextStyle.maxLines,
      selectionColor: widget.selectionColor ?? selectionColor,
      selectionControls: widget.selectionEnabled ? textSelectionControls : null,
      onSelectionChanged: _handleSelectionChanged,
      onSelectionHandleTapped: _handleSelectionHandleTapped,
      rendererIgnoresPointer: true,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: Radius.zero,
      cursorColor: cursorColor,
      selectionHeightStyle: ui.BoxHeightStyle.tight,
      selectionWidthStyle: ui.BoxWidthStyle.tight,
      cursorOpacityAnimates: cursorOpacityAnimates,
      cursorOffset: cursorOffset,
      paintCursorAboveText: paintCursorAboveText,
      backgroundCursorColor: background,
      enableInteractiveSelection: widget.selectionEnabled,
      scrollPhysics: widget.scrollPhysics,
      scrollBehavior: widget.scrollBehavior ?? const _InputScrollBehavior(),
      autofillHints: null,
      contextMenuBuilder: widget.contextMenuBuilder,
      dragStartBehavior: widget.dragStartBehavior,
      scrollController: widget.scrollController,
    );

    return _selectionGestureDetectorBuilder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: GestureDetector(
        onLongPress: () => _effectiveFocusNode.requestFocus(),
        child: RepaintBoundary(child: editable),
      ),
    );
  }
}

class _TextSpanEditingController extends TextEditingController {
  _TextSpanEditingController({required TextSpan textSpan})
    : _textSpan = textSpan,
      super(text: textSpan.toPlainText(includeSemanticsLabels: false));

  final TextSpan _textSpan;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(style: style, children: <TextSpan>[_textSpan]);
  }

  @override
  set text(String? newText) {
    throw UnimplementedError();
  }
}

/// Default [ScrollBehavior] for desktop.
class _InputScrollBehavior extends ScrollBehavior {
  /// Creates a [DesktopScrollBehavior].
  const _InputScrollBehavior() : super();

  /// Applies a [Scrollbar] to the child widget.
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
