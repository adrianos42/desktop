import 'package:desktop/desktop.dart';

Widget createItemForColor(
  BuildContext context,
  Color color,
  String name, [
  Color? foreground,
]) {
  final textStyle = Theme.of(context).textTheme.caption.copyWith(
        color: foreground,
        fontWeight: FontWeight.bold,
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
                  color.toARGB32().toRadixString(0x10),
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