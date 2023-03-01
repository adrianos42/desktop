import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ColorschemePage extends StatefulWidget {
  ColorschemePage({super.key});

  @override
  _ColorschemePageState createState() => _ColorschemePageState();
}

Widget _itemPrimary(
  BuildContext context,
  PrimaryColor color, [
  Color? foreground,
]) {
  return _createItemForColor(
      context, color.color, color.toString(), foreground);
}

Widget _createItemForColor(
  BuildContext context,
  Color color,
  String name, [
  Color? foreground,
]) {
  final textStyle = Theme.of(context).textTheme.body2.copyWith(
        color: foreground,
      );

  return Container(
    color: color,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: textStyle),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text.rich(
            TextSpan(text: 'ARGB: ', style: textStyle, children: [
              WidgetSpan(
                child: SelectableText(
                  color.value.toRadixString(0x10),
                  style: textStyle,
                  maxLines: 1,
                ),
              ),
            ]),
          ),
        ),
      ],
    ),
  );
}

class _ColorschemePageState extends State<ColorschemePage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lightForeground = const ColorScheme(Brightness.dark).shade[100];

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
                _createItemForColor(
                  context,
                  colorScheme.background[0],
                  'Background 0',
                ),
                _createItemForColor(
                  context,
                  colorScheme.background[4],
                  'Background 4',
                ),
                _createItemForColor(
                  context,
                  colorScheme.background[8],
                  'Background 8',
                ),
                _createItemForColor(
                  context,
                  colorScheme.background[12],
                  'Background 12',
                ),
                _createItemForColor(
                  context,
                  colorScheme.background[16],
                  'Background 16',
                ),
                _createItemForColor(
                  context,
                  colorScheme.background[20],
                  'Background 20',
                ),
                _createItemForColor(
                  context,
                  colorScheme.disabled,
                  'Disabled',
                ),
                _createItemForColor(
                  context,
                  colorScheme.shade[30],
                  'Shade 30',
                  colorScheme.background[0],
                ),
                _createItemForColor(
                  context,
                  colorScheme.shade[40],
                  'Shade 40',
                  colorScheme.background[0],
                ),
                _createItemForColor(
                  context,
                  colorScheme.shade[50],
                  'Shade 50',
                  colorScheme.background[0],
                ),
                _createItemForColor(
                  context,
                  colorScheme.shade[60],
                  'Shade 60',
                  colorScheme.background[0],
                ),
                _createItemForColor(
                  context,
                  colorScheme.shade[70],
                  'Shade 70',
                  colorScheme.background[0],
                ),
                _createItemForColor(
                  context,
                  colorScheme.shade[80],
                  'Shade 80',
                  colorScheme.background[0],
                ),
                _createItemForColor(
                  context,
                  colorScheme.shade[90],
                  'Shade 90',
                  colorScheme.background[0],
                ),
                _createItemForColor(
                  context,
                  colorScheme.shade[100],
                  'Shade 100',
                  colorScheme.background[0],
                ),
                _createItemForColor(
                  context,
                  colorScheme.primary[30],
                  'Primary 30',
                  lightForeground,
                ),
                _createItemForColor(
                  context,
                  colorScheme.primary[40],
                  'Primary 40',
                  lightForeground,
                ),
                _createItemForColor(
                  context,
                  colorScheme.primary[50],
                  'Primary 50',
                  lightForeground,
                ),
                _createItemForColor(
                  context,
                  colorScheme.primary[60],
                  'Primary 60',
                  lightForeground,
                ),
                _createItemForColor(
                  context,
                  colorScheme.primary[70],
                  'Primary 70',
                  lightForeground,
                ),
                _createItemForColor(
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
