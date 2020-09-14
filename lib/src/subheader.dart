import 'package:flutter/widgets.dart';
import 'theme.dart';

const double kLeftPadding = 12.0;

class Subheader extends StatelessWidget {
  const Subheader(
    this.text, {
    Key key,
    this.foreground,
  })  : assert(text != null),
        super(key: key);

  final Color foreground;

  final String text;

  @override
  Widget build(BuildContext context) {
    final Color itemForeground =
        foreground ?? Theme.of(context).textTheme.textMedium;

    return Padding(
      padding: EdgeInsets.only(
        left: kLeftPadding,
        top: 12.0,
        bottom: 12.0,
        right: 12.0,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subheader.copyWith(
              color: itemForeground,
            ),
      ),
    );
  }
}
