import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'text_field.dart';
import '../icons.dart';
import '../theme/theme.dart';
import '../input/button.dart';

class SearchTextField extends StatefulWidget {
  /// Creates a [SearchTextField].
  const SearchTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.style,
    this.placeholder,
    this.placeholderStyle,
    this.decoration,
    this.backgroundColor,
    this.keyboardType = TextInputType.text,
    this.padding = EdgeInsets.zero,
    this.itemColor,
    this.itemSize = 20.0,
    this.prefixInsets = const EdgeInsetsDirectional.only(start: 4.0),
    this.prefixIcon = const Icon(Icons.search),
    this.suffixMode = OverlayVisibilityMode.editing,
    this.suffixInsets = const EdgeInsetsDirectional.only(end: 4.0),
    this.suffixIcon = const Icon(Icons.clear),
    this.onPrefixTap,
    this.onSuffixTap,
    this.focusNode,
    this.enableIMEPersonalizedLearning = true,
    this.autofocus = false,
    this.onTap,
    this.autocorrect = true,
    this.enabled,
  });

  /// Controls the text being edited.
  ///
  /// Similar to [TextField], to provide a prefilled text entry, pass
  /// in a [TextEditingController] with an initial value to the [controller]
  /// parameter. Defaults to creating its own [TextEditingController].
  final TextEditingController? controller;

  /// Invoked upon user input.
  final ValueChanged<String>? onChanged;

  /// Invoked upon keyboard submission.
  final ValueChanged<String>? onSubmitted;

  /// Allows changing the style of the text.
  final TextStyle? style;

  /// A hint placeholder text that appears when the text entry is empty.
  ///
  /// Defaults to 'Search'.
  final String? placeholder;

  /// Sets the style of the placeholder of the text field.
  final TextStyle? placeholderStyle;

  /// Sets the decoration for the text field.
  final BoxDecoration? decoration;

  /// Set the [decoration] property's background color.
  final Color? backgroundColor;

  /// The keyboard type for this search field.
  ///
  /// Defaults to [TextInputType.text].
  final TextInputType? keyboardType;

  /// Sets the padding insets for the text and placeholder.
  final EdgeInsetsGeometry padding;

  /// Sets the color for the suffix and prefix icons.
  final Color? itemColor;

  /// Sets the base icon size for the suffix and prefix icons.
  final double itemSize;

  /// Sets the padding insets for the suffix.
  final EdgeInsetsGeometry prefixInsets;

  /// Sets the prefix action.
  final VoidCallback? onPrefixTap;

  /// Sets a prefix widget.
  final Widget prefixIcon;

  /// Sets the padding insets for the prefix.
  final EdgeInsetsGeometry suffixInsets;

  /// Sets the suffix widget's icon.
  final Icon suffixIcon;

  /// Sets the suffix action.
  final VoidCallback? onSuffixTap;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.material.textfield.onTap}
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// Disables the text field when false.
  final bool? enabled;

  /// Whether the clear button should be visible.
  final OverlayVisibilityMode suffixMode;

  @override
  State<StatefulWidget> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _createLocalController();
    }
  }

  @override
  void didUpdateWidget(SearchTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? TextEditingController()
        : TextEditingController.fromValue(value);
  }

  void _defaultOnSuffixTap() {
    final bool textChanged = _effectiveController.text.isNotEmpty;
    _effectiveController.clear();
    if (widget.onChanged != null && textChanged) {
      widget.onChanged!(_effectiveController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final String placeholder = widget.placeholder ?? 'Search';

    final TextStyle placeholderStyle = widget.placeholderStyle ??
        themeData.textTheme.body1.copyWith(
          color: themeData.textTheme.textLow,
        );

    final double scaledIconSize = widget.itemSize;
    // TODO(as): Set scale in theme data.    MediaQuery.textScaleFactorOf(context) * widget.itemSize;

    final BoxDecoration? decoration = widget.decoration;

    final IconThemeData iconThemeData = IconThemeData(
      color: themeData.textTheme.textLow,
      size: scaledIconSize,
      fill: 1.0,
    );

    final Widget prefix;

    if (widget.onPrefixTap != null) {
      prefix = Padding(
        padding: widget.prefixInsets,
        child: Button(
          onPressed: widget.onPrefixTap!,
          padding: EdgeInsets.zero,
          bodyPadding: EdgeInsets.zero,
          theme: ButtonThemeData(
            iconThemeData: iconThemeData,
            color: themeData.textTheme.textLow,
          ),
          body: widget.prefixIcon,
        ),
      );
    } else {
      prefix = Padding(
        padding: widget.prefixInsets,
        child: IconTheme(
          data: iconThemeData,
          child: widget.prefixIcon,
        ),
      );
    }

    final Widget suffix = Padding(
      padding: widget.suffixInsets,
      child: Button(
        onPressed: widget.onSuffixTap ?? _defaultOnSuffixTap,
        padding: EdgeInsets.zero,
        bodyPadding: EdgeInsets.zero,
        theme: ButtonThemeData(
          iconThemeData: iconThemeData,
          color: themeData.textTheme.textLow,
        ),
        body: widget.suffixIcon,
      ),
    );

    return TextField(
      controller: _effectiveController,
      decoration: decoration,
      style: widget.style,
      prefix: prefix,
      suffix: suffix,
      suffixMode: widget.suffixMode,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      enabled: widget.enabled ?? true,
      placeholder: placeholder,
      placeholderStyle: placeholderStyle,
      // TODO padding: widget.padding,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      textInputAction: TextInputAction.search,
    );
  }
}
