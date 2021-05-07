import 'package:desktop/desktop.dart';
import 'defaults.dart';

class ColorschemePage extends StatefulWidget {
  ColorschemePage({Key? key}) : super(key: key);

  @override
  _ColorschemePageState createState() => _ColorschemePageState();
}

Widget _itemPrimary(
  BuildContext context,
  PrimaryColor color, [
  HSLColor? foreground,
]) {
  return _createItemForColor(context, color, color.toString(), foreground);
}

Widget _createItemForColor(
  BuildContext context,
  HSLColor color,
  String name, [
  HSLColor? foreground,
]) {
  final textStyle = Theme.of(context).textTheme.body2.copyWith(
        color: foreground?.toColor(),
      );
  return Container(
    color: color.toColor(),
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
          'Hue: ${(color.hue.round()).toString()}',
          style: textStyle,
        ),
        Text(
          'Saturation: ${(color.saturation * 100.0).round().toString()}%',
          style: textStyle,
        ),
        Text(
          'Lightness: ${(color.lightness * 100.0).round().toString()}%',
          style: textStyle,
        ),
        Text(
          'Alpha: ${(color.alpha * 100.0).round().toString()}%',
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
    final light = ColorScheme(Brightness.dark).shade;
    final dark = ColorScheme(Brightness.dark).background;

    final controller = ScrollController();

    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Defaults.createHeader(context, 'Color Scheme'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _createItemForColor(
                    context,
                    colorScheme.background,
                    'Background',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background1,
                    'Background 1',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background2,
                    'Background 2',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background3,
                    'Background 3',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.disabled,
                    'Disabled',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.shade6,
                    'Shade 6',
                    colorScheme.background,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.shade5,
                    'Shade 5',
                    colorScheme.background,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.shade4,
                    'Shade 4',
                    colorScheme.background,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.shade3,
                    'Shade 3',
                    colorScheme.background,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.shade2,
                    'Shade 2',
                    colorScheme.background,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.shade1,
                    'Shade 1',
                    colorScheme.background,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.shade,
                    'Shade',
                    colorScheme.background,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[20],
                    'Primary 20',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[20],
                    'Primary 30',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[20],
                    'Primary 40',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[20],
                    'Primary 50',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[20],
                    'Primary 60',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[20],
                    'Primary 70',
                    light,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary[20],
                    'Primary 80',
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Defaults.createTitle(context, 'Primary Colors'),
                  _itemPrimary(context, PrimaryColor.coral, light),
                  _itemPrimary(context, PrimaryColor.sandyBrown, light),
                  _itemPrimary(context, PrimaryColor.orange, light),
                  _itemPrimary(context, PrimaryColor.goldenrod, light),
                  _itemPrimary(context, PrimaryColor.springGreen, light),
                  _itemPrimary(context, PrimaryColor.turquoise, light),
                  _itemPrimary(context, PrimaryColor.deepSkyBlue, light),
                  _itemPrimary(context, PrimaryColor.dodgerBlue, light),
                  _itemPrimary(context, PrimaryColor.cornflowerBlue, light),
                  _itemPrimary(context, PrimaryColor.royalBlue, light),
                  _itemPrimary(context, PrimaryColor.slateBlue, light),
                  _itemPrimary(context, PrimaryColor.purple, light),
                  _itemPrimary(context, PrimaryColor.violet, light),
                  _itemPrimary(context, PrimaryColor.orchid, light),
                  _itemPrimary(context, PrimaryColor.hotPink, light),
                  _itemPrimary(context, PrimaryColor.violetRed, light),
                  _itemPrimary(context, PrimaryColor.red, light),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
