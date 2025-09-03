import 'package:desktop/desktop.dart';

import '../defaults.dart';
import 'theme.dart';

class ColorschemePage extends StatefulWidget {
  const ColorschemePage({super.key});

  @override
  State<ColorschemePage> createState() => _ColorschemePageState();
}

class _ColorschemePageState extends State<ColorschemePage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lightForeground = colorScheme.shade[100];

    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Defaults.createHeader(context, 'Color Scheme'),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: ScrollController(),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                createItemForColor(
                  context,
                  colorScheme.background[0],
                  'Background 0',
                ),
                createItemForColor(
                  context,
                  colorScheme.background[4],
                  'Background 4',
                ),
                createItemForColor(
                  context,
                  colorScheme.background[8],
                  'Background 8',
                ),
                createItemForColor(
                  context,
                  colorScheme.background[12],
                  'Background 12',
                ),
                createItemForColor(
                  context,
                  colorScheme.background[16],
                  'Background 16',
                ),
                createItemForColor(
                  context,
                  colorScheme.background[20],
                  'Background 20',
                ),
                createItemForColor(context, colorScheme.disabled, 'Disabled'),
                createItemForColor(
                  context,
                  colorScheme.shade[30],
                  'Shade 30',
                  colorScheme.background[0],
                ),
                createItemForColor(
                  context,
                  colorScheme.shade[40],
                  'Shade 40',
                  colorScheme.background[0],
                ),
                createItemForColor(
                  context,
                  colorScheme.shade[50],
                  'Shade 50',
                  colorScheme.background[0],
                ),
                createItemForColor(
                  context,
                  colorScheme.shade[60],
                  'Shade 60',
                  colorScheme.background[0],
                ),
                createItemForColor(
                  context,
                  colorScheme.shade[70],
                  'Shade 70',
                  colorScheme.background[0],
                ),
                createItemForColor(
                  context,
                  colorScheme.shade[80],
                  'Shade 80',
                  colorScheme.background[0],
                ),
                createItemForColor(
                  context,
                  colorScheme.shade[90],
                  'Shade 90',
                  colorScheme.background[0],
                ),
                createItemForColor(
                  context,
                  colorScheme.shade[100],
                  'Shade 100',
                  colorScheme.background[0],
                ),
                createItemForColor(
                  context,
                  colorScheme.primary[30],
                  'Primary 30',
                  lightForeground,
                ),
                createItemForColor(
                  context,
                  colorScheme.primary[40],
                  'Primary 40',
                  lightForeground,
                ),
                createItemForColor(
                  context,
                  colorScheme.primary[50],
                  'Primary 50',
                  lightForeground,
                ),
                createItemForColor(
                  context,
                  colorScheme.primary[60],
                  'Primary 60',
                  lightForeground,
                ),
                createItemForColor(
                  context,
                  colorScheme.primary[70],
                  'Primary 70',
                  lightForeground,
                ),
                createItemForColor(
                  context,
                  colorScheme.error,
                  'Error',
                  lightForeground,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
