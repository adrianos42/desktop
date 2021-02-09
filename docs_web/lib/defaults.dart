import 'package:flutter/widgets.dart';
import 'package:desktop/desktop.dart';

class Defaults {
  static BoxDecoration itemDecoration(BuildContext context) => BoxDecoration(
        border: Border.all(
            color: Theme.of(context).colorScheme.background4.toColor(),
            width: 1.0),
      );

  static Widget createHeader(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.hearder,
      ),
    );
  }

  static Widget createSubheader(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subheader,
      ),
    );
  }

  static Widget createTitle(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  static Widget createSubtitle(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  double get borderWidth => 2.0;
}
