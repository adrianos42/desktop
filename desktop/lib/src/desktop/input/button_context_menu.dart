import 'package:flutter/widgets.dart';

import '../dialogs/context_menu/context_menu.dart';
import '../icons.dart';
import '../theme/theme.dart';
import 'button.dart';

/// Button that shows a context menu when pressed.
class ContextMenuButton<T> extends Button {
  ///
  const ContextMenuButton({
    super.key,
    super.body,
    super.trailing,
    super.leading,
    super.tooltip,
    super.theme,
    super.leadingPadding,
    super.padding,
    super.bodyPadding,
    super.trailingPadding,
    super.onLongPress,
    super.focusNode,
    super.canRequestFocus,
    super.autofocus,
    super.filled,
    super.willChangeState,
    super.enableAnimation,
    this.onCanceled,
    this.value,
    required this.onSelected,
    required this.itemBuilder,
  })  : assert(body != null || trailing != null || leading != null),
        super(onPressed: null);

  /// Creates a button with a text.
  factory ContextMenuButton.text(
    String text, {
    Key? key,
    double? fontSize,
    String? tooltip,
    ButtonThemeData? theme,
    EdgeInsets? padding,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool willChangeState = false,
    VoidCallback? onLongPress,
    T? value,
    ContextMenuCanceled? onCanceled,
    required ContextMenuItemSelected<T>? onSelected,
    required ContextMenuItemBuilder<T> itemBuilder,
  }) {
    return ContextMenuButton(
      key: key,
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      tooltip: tooltip,
      onLongPress: onLongPress,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      willChangeState: willChangeState,
      theme: theme,
      enableAnimation: true,
      filled: false,
      value: value,
      itemBuilder: itemBuilder,
      onCanceled: onCanceled,
      onSelected: onSelected,
      body: Text(
        text,
        style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
      ),
    );
  }

  /// Creates a button with a icon.
  factory ContextMenuButton.icon(
    IconData icon, {
    Key? key,
    String? tooltip,
    double? size,
    EdgeInsets? padding,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool willChangeState = false,
    VoidCallback? onLongPress,
    ButtonThemeData? theme,
    T? value,
    ContextMenuCanceled? onCanceled,
    required ContextMenuItemSelected<T>? onSelected,
    required ContextMenuItemBuilder<T> itemBuilder,
  }) {
    return ContextMenuButton(
      key: key,
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      tooltip: tooltip,
      onLongPress: onLongPress,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      willChangeState: willChangeState,
      enableAnimation: true,
      filled: false,
      theme: theme,
      value: value,
      itemBuilder: itemBuilder,
      onCanceled: onCanceled,
      onSelected: onSelected,
      body: Icon(icon, size: size),
    );
  }

  /// Creates a button with a filled background.
  factory ContextMenuButton.filled(
    String text, {
    Key? key,
    double? fontSize,
    String? tooltip,
    EdgeInsets? padding,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool enableAnimation = false,
    bool willChangeState = false,
    VoidCallback? onLongPress,
    ButtonThemeData? theme,
    T? value,
    ContextMenuCanceled? onCanceled,
    required ContextMenuItemSelected<T>? onSelected,
    required ContextMenuItemBuilder<T> itemBuilder,
  }) {
    return ContextMenuButton(
      key: key,
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      theme: theme,
      tooltip: tooltip,
      onLongPress: onLongPress,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      filled: true,
      willChangeState: willChangeState,
      enableAnimation: enableAnimation,
      value: value,
      itemBuilder: itemBuilder,
      onCanceled: onCanceled,
      onSelected: onSelected,
      body: Text(
        text,
        style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
      ),
    );
  }

  /// Creates a dropdown button. The difference with a regular [DropdownButton],
  /// is that a widget will be used alongside the icon instead of the context menu value.
  factory ContextMenuButton.dropdown(
    Widget body, {
    Key? key,
    String? tooltip,
    EdgeInsets? padding,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autofocus = false,
    bool willChangeState = false,
    VoidCallback? onLongPress,
    ButtonThemeData? theme,
    T? value,
    ContextMenuCanceled? onCanceled,
    required ContextMenuItemSelected<T>? onSelected,
    required ContextMenuItemBuilder<T> itemBuilder,
  }) {
    return _ContextMenuButtonDropdown(
      key: key,
      padding: padding,
      bodyPadding: padding != null ? EdgeInsets.zero : null,
      theme: theme,
      tooltip: tooltip,
      onLongPress: onLongPress,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      autofocus: autofocus,
      willChangeState: willChangeState,
      enableAnimation: true,
      value: value,
      itemBuilder: itemBuilder,
      onCanceled: onCanceled,
      onSelected: onSelected,
      body: body,
    );
  }

  /// The list of [ContextMenuItem] used for the context menu.
  final ContextMenuItemBuilder<T> itemBuilder;

  /// The current value in the context menu.
  final T? value;

  /// Called when the context menu selection changes.
  final ContextMenuItemSelected<T>? onSelected;

  /// Called when the user cancels the context menu selection.
  final ContextMenuCanceled? onCanceled;

  @override
  State<ContextMenuButton<T>> createState() => _ContextMenuButtonState<T>();
}

class _ContextMenuButtonState<T> extends ButtonState<ContextMenuButton<T>> {
  bool _buttonActive = false;

  Future<void> showButtonMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Overlay.of(context, rootOverlay: true)
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

    final List<ContextMenuEntry<T>> items = widget.itemBuilder(context);

    assert(items.isNotEmpty);

    final newValue = await showMenu<T>(
      context: context,
      items: items,
      initialValue: widget.value,
      position: position,
    );

    if (!mounted) {
      return;
    }

    if (newValue == null) {
      if (widget.onCanceled != null) {
        widget.onCanceled!();
      }
      return;
    }

    if (widget.onSelected != null) {
      widget.onSelected!(newValue);
    }
  }

  bool get _enabled => widget.onSelected != null;

  @override
  bool? get active => _buttonActive;

  void _update(bool value) {
    setState(() {
      _buttonActive = value;
      updateColor();
    });
  }

  @override
  VoidCallback? get onPressed {
    return _enabled
        ? () async {
            _update(true);
            final _ = await showButtonMenu(context);
            _update(false);
          }
        : null;
  }
}

class _ContextMenuButtonDropdown<T> extends ContextMenuButton<T> {
  const _ContextMenuButtonDropdown({
    super.key,
    super.body,
    super.tooltip,
    super.theme,
    super.padding,
    super.bodyPadding,
    super.onLongPress,
    super.focusNode,
    super.canRequestFocus,
    super.autofocus,
    super.filled,
    super.willChangeState,
    super.enableAnimation,
    super.onCanceled,
    super.onSelected,
    super.value,
    required super.itemBuilder,
  });

  @override
  State<ContextMenuButton<T>> createState() =>
      _ContextMenuButtonDropdownState<T>();
}

class _ContextMenuButtonDropdownState<T> extends _ContextMenuButtonState<T> {
  @override
  Widget? get trailing => Icon(
        _buttonActive ? Icons.expandLess : Icons.expandMore,
      );
}
