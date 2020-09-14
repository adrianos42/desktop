import 'package:flutter/widgets.dart';
import 'theme.dart';

const double _kPadding = 8.0;

class Header extends StatelessWidget {
  const Header(
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

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.all(_kPadding),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .subheader
              .copyWith(color: itemForeground),
        ),
      ),
    );
  }
}
