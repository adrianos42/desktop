import 'package:desktop/desktop.dart';

import '../defaults.dart';

class PrimaryColorPage extends StatefulWidget {
  const PrimaryColorPage({super.key});

  @override
  State<PrimaryColorPage> createState() => PrimaryColorPageState();
}

Widget _itemPrimary(
  BuildContext context,
  PrimaryColors color,
  Brightness brightness,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: Text(
            color.toString(),
            style: Theme.of(context).textTheme.subtitle.copyWith(
                  color: TextTheme.withColorScheme(ColorScheme(brightness))
                      .textHigh,
                ),
          ),
        ),
        _createItemForColor(
            context, color.primaryColor.withBrightness(brightness)[30], 30),
        _createItemForColor(
            context, color.primaryColor.withBrightness(brightness)[40], 40),
        _createItemForColor(
            context, color.primaryColor.withBrightness(brightness)[50], 50),
        _createItemForColor(
            context, color.primaryColor.withBrightness(brightness)[60], 60),
        _createItemForColor(
            context, color.primaryColor.withBrightness(brightness)[70], 70),
      ],
    ),
  );
}

Widget _createItemForColor(BuildContext context, Color color, int index) {
  final textStyle = Theme.of(context).textTheme.body2;

  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text.rich(
            TextSpan(
                text: 'ARGB: ',
                style: textStyle.copyWith(color: color),
                children: [
                  WidgetSpan(
                    child: SelectableText(
                      color.value.toRadixString(0x10),
                      style: textStyle.copyWith(color: color),
                      maxLines: 1,
                    ),
                  ),
                ]),
          ),
        ),
        ColoredBox(
          color: color,
          child: ConstrainedBox(
              constraints: const BoxConstraints.expand(height: 60)),
        )
      ],
    ),
  );
}

class PrimaryColorPageState extends State<PrimaryColorPage> {
  @override
  Widget build(BuildContext context) {
    final lightBackground = const ColorScheme(Brightness.light).background[0];
    final darkBackground = const ColorScheme(Brightness.dark).background[0];

    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(children: [
            Defaults.createHeader(context, 'Primary Colors'),
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: ScrollController(),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Defaults.createTitle(context, 'Dark'),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  color: darkBackground,
                  child: Column(
                    children: [
                      _itemPrimary(
                          context, PrimaryColors.coral, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.sandyBrown, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.orange, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.goldenrod, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.springGreen, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.turquoise, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.deepSkyBlue, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.dodgerBlue, Brightness.dark),
                      _itemPrimary(context, PrimaryColors.cornflowerBlue,
                          Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.royalBlue, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.slateBlue, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.purple, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.violet, Brightness.dark),
                      _itemPrimary(
                          context, PrimaryColors.hotPink, Brightness.dark),
                      _itemPrimary(context, PrimaryColors.red, Brightness.dark),
                    ],
                  ),
                ),
                Defaults.createTitle(context, 'Light'),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  color: lightBackground,
                  child: Column(
                    children: [
                      _itemPrimary(
                          context, PrimaryColors.coral, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.sandyBrown, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.orange, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.goldenrod, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.springGreen, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.turquoise, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.deepSkyBlue, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.dodgerBlue, Brightness.light),
                      _itemPrimary(context, PrimaryColors.cornflowerBlue,
                          Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.royalBlue, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.slateBlue, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.purple, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.violet, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.hotPink, Brightness.light),
                      _itemPrimary(
                          context, PrimaryColors.red, Brightness.light),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
