import 'package:desktop/desktop.dart';

import '../defaults.dart';
import 'theme.dart';

class PrimaryColorPage extends StatefulWidget {
  const PrimaryColorPage({super.key});

  @override
  State<PrimaryColorPage> createState() => PrimaryColorPageState();
}

Widget _itemPrimary(
  BuildContext context,
  PrimaryColors color,
) {
  final colorScheme = Theme.of(context).colorScheme;
  final lightForeground = colorScheme.shade[100];
  final darkForeground = colorScheme.background[0];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
        child: Text(
          color.toString(),
          style: Theme.of(context).textTheme.title.copyWith(
                color: TextTheme.withColorScheme(const ColorScheme()).textHigh,
              ),
        ),
      ),
      createItemForColor(
          context, color.primaryColor[30], 'Primary 30', lightForeground),
      createItemForColor(
          context, color.primaryColor[40], 'Primary 40', lightForeground),
      createItemForColor(
          context, color.primaryColor[50], 'Primary 50', lightForeground),
      createItemForColor(
          context, color.primaryColor[60], 'Primary 60', darkForeground),
      createItemForColor(
          context, color.primaryColor[70], 'Primary 70', darkForeground),
    ],
  );
}

class PrimaryColorPageState extends State<PrimaryColorPage> {
  @override
  Widget build(BuildContext context) {
    const colors = [
      PrimaryColors.coral,
      PrimaryColors.sandyBrown,
      PrimaryColors.orange,
      PrimaryColors.goldenrod,
      PrimaryColors.springGreen,
      PrimaryColors.turquoise,
      PrimaryColors.deepSkyBlue,
      PrimaryColors.dodgerBlue,
      PrimaryColors.cornflowerBlue,
      PrimaryColors.royalBlue,
      PrimaryColors.slateBlue,
      PrimaryColors.purple,
      PrimaryColors.violet,
      PrimaryColors.hotPink,
      PrimaryColors.red,
    ];

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
          child: ListView.separated(
            itemBuilder: (context, index) =>
                _itemPrimary(context, colors[index]),
            itemCount: colors.length,
            separatorBuilder: (context, _) => const SizedBox(height: 24.0),
            controller: ScrollController(),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          ),
        ),
      ],
    );
  }
}
