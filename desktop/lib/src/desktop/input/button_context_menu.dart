import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../dialogs/context_menu.dart';

import 'button_icon.dart';

class ContextMenuButton<T> extends StatefulWidget {
  const ContextMenuButton(
    this.icon, {
    required this.itemBuilder,
    this.value,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  final IconData icon;

  final ContextMenuItemBuilder<T> itemBuilder;

  final T? value;

  final ContextMenuItemSelected<T>? onSelected;

  final ContextMenuCanceled? onCanceled;

  final String? tooltip;

  final bool enabled;

  @override
  _ContextMenuButtonState<T> createState() => _ContextMenuButtonState<T>();
}

class _ContextMenuButtonState<T> extends State<ContextMenuButton<T>> {
  void showButtonMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject()! as RenderBox;

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

    await showMenu<T>(
      context: context,
      items: items,
      initialValue: widget.value,
      position: position,
      settings: const RouteSettings(),
    ).then<void>((T? newValue) {
      if (!mounted) {
        return null;
      }

      if (newValue == null) {
        if (widget.onCanceled != null) {
          widget.onCanceled!();
        }
        return null;
      }

      if (widget.onSelected != null) {
        widget.onSelected!(newValue);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      widget.icon,
      onPressed: widget.enabled ? () => showButtonMenu(context) : null,
      tooltip: widget.tooltip,
    );
  }
}
