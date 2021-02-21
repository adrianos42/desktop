import 'package:flutter/widgets.dart';
import 'package:desktop/desktop.dart';

class Defaults {
  static BoxDecoration itemDecoration(BuildContext context) => BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.shade6.toColor(),
          width: 1.0,
        ),
      );

  static Widget createHeader(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.header,
      ),
    );
  }

  static Widget createSubheader(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subheader,
      ),
    );
  }

  static Widget createTitle(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  static Widget createSubtitle(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 4.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }

  static Widget createCaption(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 2.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  double get borderWidth => 2.0;
}
