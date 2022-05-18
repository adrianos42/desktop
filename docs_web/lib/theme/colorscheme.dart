import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ColorschemePage extends StatefulWidget {
  ColorschemePage({Key? key}) : super(key: key);

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
    padding: EdgeInsets.all(8.0),
    height: 200.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: textStyle,
        ),
        Text(
          'Hue: ${(HSLColor.fromColor(color).hue.round()).toString()}',
          style: textStyle,
        ),
        Text(
          'Saturation: ${(HSLColor.fromColor(color).saturation * 100.0).round().toString()}%',
          style: textStyle,
        ),
        Text(
          'Lightness: ${(HSLColor.fromColor(color).lightness * 100.0).round().toString()}%',
          style: textStyle,
        ),
        Text(
          'Alpha: ${(HSLColor.fromColor(color).alpha * 100.0).round().toString()}%',
          style: textStyle,
        ),
        Text(
          'ARGB: ${color.value.toRadixString(0x10)}',
          style: textStyle,
        ),
      ],
    ),
  );
}

class _ColorschemePageState extends State<ColorschemePage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final light = const ColorScheme(Brightness.dark).shade[100];

    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Defaults.createHeader(context, 'Color scheme'),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    colorScheme.background[2],
                    'Background 2',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[4],
                    'Background 4',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[6],
                    'Background 6',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[8],
                    'Background 8',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[10],
                    'Background 10',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[12],
                    'Background 12',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[14],
                    'Background 14',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[16],
                    'Background 16',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[18],
                    'Background 18',
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
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[40],
                    'Primary 40',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[50],
                    'Primary 50',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[60],
                    'Primary 60',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[70],
                    'Primary 70',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.error,
                    'Error',
                    light,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomThemePage extends StatefulWidget {
  CustomThemePage({Key? key}) : super(key: key);

  @override
  _CustomThemePageState createState() => _CustomThemePageState();
}

class _CustomThemePageState extends State<CustomThemePage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final light = const ColorScheme(Brightness.dark).shade[100];

    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Defaults.createHeader(context, 'Color scheme'),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    colorScheme.background[2],
                    'Background 2',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[4],
                    'Background 4',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[6],
                    'Background 6',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[8],
                    'Background 8',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[10],
                    'Background 10',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[12],
                    'Background 12',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[14],
                    'Background 14',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[16],
                    'Background 16',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background[18],
                    'Background 18',
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
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[40],
                    'Primary 40',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[50],
                    'Primary 50',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[60],
                    'Primary 60',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[70],
                    'Primary 70',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.error,
                    'Error',
                    light,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
