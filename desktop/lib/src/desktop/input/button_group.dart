import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import 'button.dart';

typedef ToggleButtonItemSelected<T> = void Function(T value);

class ToggleItem<T> {
  ToggleItem({
    required this.builder,
    required this.value,
    this.tooltip,
  });
  final WidgetBuilder builder;
  final String? tooltip;
  final T value;
}

class ToggleButton<T> extends StatelessWidget {
  const ToggleButton({
    Key? key,
    this.onSelected,
    this.value,
    required this.items,
  }) : super(key: key);

  final List<ToggleItem> items;

  final ToggleButtonItemSelected<T>? onSelected;

  final T? value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    assert(
        items.every((element) =>
            items.where((other) => other.value == element.value).length == 1),
        'Cannot have more than one item with the same value');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: items.map((ToggleItem<dynamic> e) {
          final bool isSelected = value == e.value;
          return ButtonTheme.merge(
            data: ButtonThemeData(
              hoverColor: isSelected ? colorScheme.primary[50] : null,
              highlightColor: isSelected ? colorScheme.primary[50] : null,
              color: isSelected ? colorScheme.primary[50] : null,
            ),
            child: Button(
              padding: EdgeInsets.zero,
              body: e.builder(context),
              tooltip: e.tooltip,
              onPressed:
                  onSelected != null ? () => onSelected!(e.value as T) : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
