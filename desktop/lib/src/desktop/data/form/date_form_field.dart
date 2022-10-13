import 'dart:async';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../dialogs/calendar/calendar_date.dart';
import '../../dialogs/calendar/date_picker_dialog.dart';
import '../../dialogs/calendar/month_picker.dart';
import '../../dialogs/context_menu/context_menu_layout.dart';
import '../../icons.dart';
import '../../input/button.dart';
import '../../localizations.dart';
import '../../text/text_field.dart';
import '../../theme/theme.dart';

export 'package:flutter/services.dart' show SmartDashesType, SmartQuotesType;

// TODO(as): Set in theme.
const double _kBorderWidth = 1.0;

/// A [FormField] with date input.
class DateFormField extends FormField<String> {
  /// Creates a [DateFormField].
  DateFormField({
    super.key,
    this.controller,
    String? initialValue,
    TextInputAction? textInputAction, // TODO
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions, // TODO
    bool? showCursor,
    bool enableSuggestions = true, // TODO
    MaxLengthEnforcement? maxLengthEnforcement, // TODO
    bool expands = false, // TODO
    int? maxLength, // TODO
    this.onChanged,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    super.onSaved,
    super.validator, // TODO
    bool enabled = true,
    double cursorWidth = 2.0,
    double? cursorHeight,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    Iterable<String>? autofillHints, // TODO
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    super.restorationId,
    bool enableIMEPersonalizedLearning = true,
    this.focusNode,
    List<TextInputFormatter>? inputFormatters,

    // Used for the date picker.
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.currentDate,
    this.selectableDayPredicate,
    this.initialCalendarMode = DatePickerMode.day,
    // MouseCursor? mouseCursor,
  })  : assert(initialValue == null || controller == null),
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

            final Color borderColor = field._calendarButtonActive
                ? colorScheme.background[8]
                : foreground;

            final BoxDecoration decoration = BoxDecoration(
              color: background,
              border: enabled
                  ? Border.all(color: borderColor, width: _kBorderWidth)
                  : null,
            );

            final List<TextInputFormatter> effectiveInputFormatters =
                inputFormatters ??
                    [
                      DesktopLocalizations.of(field.context)
                          .dateFormInputFormatter
                    ];

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: decoration,
                  child: Padding(
                    padding: decoration.padding!,
                    child: Row(
                      children: [
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
                                keyboardType: TextInputType.datetime,
                                textInputAction: textInputAction,
                                style: style,
                                strutStyle: strutStyle,
                                textAlign: textAlign,
                                textDirection: textDirection,
                                textCapitalization: TextCapitalization.none,
                                autofocus: autofocus,
                                toolbarOptions: toolbarOptions,
                                readOnly: readOnly,
                                showCursor: showCursor,
                                autocorrect: false,
                                smartDashesType: SmartDashesType.disabled,
                                smartQuotesType: SmartQuotesType.disabled,
                                enableSuggestions: enableSuggestions,
                                maxLines: 1,
                                minLines: 1,
                                expands: expands,
                                maxLength: maxLength,
                                onChanged: onChangedHandler,
                                onTap: onTap,
                                onEditingComplete: onEditingComplete,
                                onSubmitted: onFieldSubmitted,
                                inputFormatters: effectiveInputFormatters,
                                enabled: enabled,
                                cursorWidth: cursorWidth,
                                cursorHeight: cursorHeight,
                                scrollPadding: scrollPadding,
                                enableInteractiveSelection:
                                    enableInteractiveSelection ?? !readOnly,
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
                        Padding(
                          // Considering the padding inside [TextField].
                          padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                          child: Button.icon(
                            Icons.edit_calendar,
                            active: field._calendarButtonActive,
                            style: const ButtonThemeData(itemSpacing: 0.0),
                            onPressed: field._openDatePicker,
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

  final ValueChanged<String>? onChanged;

  ///
  final TextEditingController? controller;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final DateTime initialDate;

  final DateTime firstDate;

  final DateTime lastDate;

  final DateTime? currentDate;

  final SelectableDayPredicate? selectableDayPredicate;

  final DatePickerMode initialCalendarMode;

  @override
  FormFieldState<String> createState() => _TextFormFieldState();
}

class _TextFormFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      _textFormField.controller ?? _controller!.value;

  DateFormField get _textFormField => super.widget as DateFormField;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      _textFormField.focusNode ?? (_focusNode ??= FocusNode());

  bool _calendarButtonActive = false;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);

    if (_controller != null) {
      _registerController();
    }

    setValue(_effectiveController.text);
  }

  Future<DateTime?> _openDatePickerContext() async {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Overlay.of(context, rootOverlay: true)!
        .context
        .findRenderObject()! as RenderBox;

    final Rect position = Rect.fromPoints(
      button.localToGlobal(
        Offset.zero,
        ancestor: overlay,
      ),
      button.localToGlobal(
        button.size.bottomRight(Offset.zero),
        ancestor: overlay,
      ),
    );

    final controller = _DatePickerController._(
      position: position,
      value: _textFormField.initialDate,
      firstDate: _textFormField.firstDate,
      initialDate: _textFormField.initialDate,
      lastDate: _textFormField.lastDate,
      currentDate: _textFormField.currentDate,
      initialCalendarMode: _textFormField.initialCalendarMode,
      selectableDayPredicate: _textFormField.selectableDayPredicate,
      background: colorScheme.background[8],
    );

    Overlay.of(context, rootOverlay: true)!.insert(controller._overlayEntry);

    return controller._completer.future;
  }

  Future<DateTime?> _openDatePickerDialog() async {
    return DatePickerDialog.showDatePicker(
      context,
      initialDate: _textFormField.initialDate,
      firstDate: _textFormField.firstDate,
      lastDate: _textFormField.lastDate,
      initialDatePickerMode: _textFormField.initialCalendarMode,
      currentDate: _textFormField.currentDate,
      selectableDayPredicate: _textFormField.selectableDayPredicate,
    );
  }

  Future<void> _openDatePicker() async {
    setState(() => _calendarButtonActive = true);

    DateTime? newDate;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        newDate = await _openDatePickerDialog();
        break;
      default:
        newDate = await _openDatePickerContext();
        break;
    }

    if (newDate != null && _textFormField.onChanged != null) {
      final newDateText =
          DesktopLocalizations.of(context).formatCompactDate(newDate);

      _effectiveController.text = newDateText;
      super.didChange(newDateText);
      _textFormField.onChanged!(newDateText);
    }

    setState(() => _calendarButtonActive = false);
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
  void didUpdateWidget(DateFormField oldWidget) {
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

// TODO(as): Use theme.
const double _kDefaultCalendarSpacing = 8.0;
const double _KDefaultHeight = 320.0 + _kDefaultCalendarSpacing * 2;

class _DatePickerController {
  _DatePickerController._({
    this.value,
    required this.position,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required DateTime? currentDate,
    required SelectableDayPredicate? selectableDayPredicate,
    required DatePickerMode initialCalendarMode,
    required Color background,
  }) : _completer = Completer<DateTime?>() {
    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _close(null),
        child: CustomSingleChildLayout(
          delegate: ContextMenuLayoutDelegate(position),
          child: SizedBox(
            width: _KDefaultHeight,
            height: _KDefaultHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: () {},
              child: ColoredBox(
                color: background,
                child: CalendarDate(
                  firstDate: firstDate,
                  initialDate: initialDate,
                  lastDate: lastDate,
                  onDateChanged: (selectedDate) {
                    _close(selectedDate);
                  },
                  currentDate: currentDate,
                  initialCalendarMode: initialCalendarMode,
                  selectableDayPredicate: selectableDayPredicate,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  late OverlayEntry _overlayEntry;

  final Completer<DateTime?> _completer;

  final Rect position;

  final DateTime? value;

  void _close(DateTime? completeValue) {
    _overlayEntry.remove();
    _completer.complete(completeValue ?? value);
  }
}
