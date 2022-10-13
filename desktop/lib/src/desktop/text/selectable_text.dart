import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import '../theme/theme.dart';

const double _kCursorWidth = 1.0;

class _SelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _SelectionGestureDetectorBuilder({
    required _SelectableTextState state,
  })  : _state = state,
        super(delegate: state);

  final _SelectableTextState _state;

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

/// Selectable text.
class SelectableText extends StatefulWidget {
  /// Creates a selectable text.
  const SelectableText(
    String this.text, {
    Key? key,
    this.autofocus = false,
    this.cursorWidth = _kCursorWidth,
    this.focusNode,
    this.maxLines,
    this.minLines,
    this.textDirection,
    this.onTap,
    this.showCursor = false,
    this.strutStyle,
    this.style,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.cursorHeight,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onSelectionChanged,
    ToolbarOptions? toolbarOptions,
  })  : assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        toolbarOptions = toolbarOptions ??
            const ToolbarOptions(
              copy: true,
              selectAll: true,
            ),
        textSpan = null,
        super(key: key);

  ///
  const SelectableText.rich(
    TextSpan this.textSpan, {
    Key? key,
    this.autofocus = false,
    this.cursorWidth = _kCursorWidth,
    this.focusNode,
    this.maxLines,
    this.minLines,
    this.textDirection,
    this.onTap,
    this.showCursor = false,
    this.strutStyle,
    this.style,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.cursorHeight,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onSelectionChanged,
    ToolbarOptions? toolbarOptions,
  })  : assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        toolbarOptions = toolbarOptions ??
            const ToolbarOptions(
              copy: true,
              selectAll: true,
            ),
        text = null,
        super(key: key);

  ///
  final String? text;

  ///
  final TextSpan? textSpan;

  ///
  final bool enabled;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  final TextStyle? style;

  final ToolbarOptions toolbarOptions;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.material.textfield.onTap}
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.editableText.onSelectionChanged}
  final SelectionChangedCallback? onSelectionChanged;

  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  @override
  _SelectableTextState createState() => _SelectableTextState();
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
  TextSelection? _lastSeenTextSelection;

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }
    if (widget.onSelectionChanged != null &&
        _lastSeenTextSelection != selection) {
      widget.onSelectionChanged!(selection, cause);
    }
    _lastSeenTextSelection = selection;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        if (cause == SelectionChangedCause.longPress) {
          _editableText?.bringIntoView(selection.base);
        }
        return;
      default:
        return;
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
  bool get forcePressEnabled => true;

  @override
  bool get selectionEnabled => widget.enabled;

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder =
        _SelectionGestureDetectorBuilder(state: this);
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

    final FocusNode focusNode = _effectiveFocusNode;

    final ThemeData theme = Theme.of(context);
    final bool enabled = widget.enabled;

    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final Color background = colorScheme.background[0].withAlpha(0);
    final Color characterColor =
        enabled ? textTheme.textHigh : colorScheme.disabled;
    final Color selectionColor = enabled ? colorScheme.primary[30] : background;

    final textStyle = textTheme.body1.copyWith(
      color: characterColor,
    );

    final editable = EditableText(
      forceLine: false,
      autofocus: widget.autofocus,
      backgroundCursorColor: background,
      controller: _controller,
      cursorColor: characterColor,
      cursorHeight: widget.cursorHeight,
      cursorOffset: Offset.zero,
      cursorOpacityAnimates: false,
      cursorRadius: Radius.zero,
      cursorWidth: widget.cursorWidth,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      focusNode: focusNode,
      key: editableTextKey,
      maxLines: widget.maxLines ?? DefaultTextStyle.of(context).maxLines,
      minLines: widget.minLines,
      paintCursorAboveText: true,
      readOnly: true,
      rendererIgnoresPointer: true,
      onSelectionChanged: _handleSelectionChanged,
      selectionColor: selectionColor,
      selectionControls:
          widget.enableInteractiveSelection ? textSelectionControls : null,
      showCursor: widget.showCursor,
      showSelectionHandles: _showSelectionHandles,
      strutStyle: widget.strutStyle,
      style: widget.style ?? textStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      toolbarOptions: widget.toolbarOptions,
      onSelectionHandleTapped: _handleSelectionHandleTapped,
      selectionHeightStyle: ui.BoxHeightStyle.tight,
      selectionWidthStyle: ui.BoxWidthStyle.tight,
      scrollBehavior: const _InputScrollBehavior(),
    );

    return _selectionGestureDetectorBuilder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: GestureDetector(
        onLongPress: () => _effectiveFocusNode.requestFocus(),
        child: RepaintBoundary(
          child: editable,
        ),
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
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return TextSpan(
      style: style,
      children: <TextSpan>[_textSpan],
    );
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
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
