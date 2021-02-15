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
    final pColor = ColorScheme(Brightness.light).background;

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
                    colorScheme.background4,
                    'Background 4',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.background5,
                    'Background 5',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.disabled,
                    'Disabled',
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.inverted,
                    'Inverted',
                    colorScheme.background,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary,
                    'Primary',
                    pColor,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary1,
                    'Primary 1',
                    pColor,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.primary2,
                    'Primary 2',
                    pColor,
                  ),
                  _createItemForColor(
                    context,
                    colorScheme.error,
                    'Error',
                    pColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Defaults.createTitle(context, 'Primary Colors'),
                  _itemPrimary(context, PrimaryColors.coral, pColor),
                  _itemPrimary(context, PrimaryColors.sandyBrown, pColor),
                  _itemPrimary(context, PrimaryColors.orange, pColor),
                  _itemPrimary(context, PrimaryColors.goldenrod, pColor),
                  _itemPrimary(context, PrimaryColors.springGreen, pColor),
                  _itemPrimary(context, PrimaryColors.turquoise, pColor),
                  _itemPrimary(context, PrimaryColors.deepSkyBlue, pColor),
                  _itemPrimary(context, PrimaryColors.steelBlue, pColor),
                  _itemPrimary(context, PrimaryColors.dodgerBlue, pColor),
                  _itemPrimary(context, PrimaryColors.cornflowerBlue, pColor),
                  _itemPrimary(context, PrimaryColors.royalBlue, pColor),
                  _itemPrimary(context, PrimaryColors.slateBlue, pColor),
                  _itemPrimary(context, PrimaryColors.purple, pColor),
                  _itemPrimary(context, PrimaryColors.violet, pColor),
                  _itemPrimary(context, PrimaryColors.orchid, pColor),
                  _itemPrimary(context, PrimaryColors.hotPink, pColor),
                  _itemPrimary(context, PrimaryColors.violetRed, pColor),
                  _itemPrimary(context, PrimaryColors.red, pColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
