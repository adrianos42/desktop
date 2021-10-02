import 'package:flutter/widgets.dart';
import 'package:desktop/desktop.dart';

class Defaults {
  static BoxDecoration itemDecoration(BuildContext context) => BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.shade[40],
          width: 1.0,
        ),
      );

  static Widget createHeader(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: Theme.of(context).textTheme.header,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static Widget _createCodeSession(
    BuildContext context, {
    required WidgetBuilder builder,
    String? codeText,
    bool hasBorder = true,
  }) {
    if (codeText != null) {
      return Tab(
        padding: EdgeInsets.zero,
        items: [
          TabItem.icon(
            Icons.visibility,
            builder: (context, _) => Container(
              decoration: hasBorder ? Defaults.itemDecoration(context) : null,
              child: builder(context),
            ),
          ),
          TabItem.icon(
            Icons.code,
            builder: (context, _) => Container(
              alignment: Alignment.topLeft,
              //decoration: Defaults.itemDecoration(context),
              child: TextField(
                maxLines: 1000,
                controller: TextEditingController(text: codeText),
                keyboardType: TextInputType.multiline,
                style: Theme.of(context).textTheme.monospace,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        alignment: Alignment.topCenter,
        decoration: hasBorder ? Defaults.itemDecoration(context) : null,
        child: builder(context),
      );
    }
  }

  static Widget createSubheader(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subheader,
        overflow: TextOverflow.ellipsis,
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
        overflow: TextOverflow.ellipsis,
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
        overflow: TextOverflow.ellipsis,
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
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static Widget createItemsWithTitle(
    BuildContext context, {
    required List<ItemTitle> items,
    required String header,
  }) {
    final result = [];

    for (final e in items) {
      result.addAll([
        Defaults.createTitle(context, e.title),
        Container(
          height: e.height,
          child: Defaults._createCodeSession(
            context,
            builder: e.body,
            codeText: e.codeText,
            hasBorder: e.hasBorder,
          ),
        ),
      ]);
    }

    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Defaults.createHeader(context, header), ...result]),
      ),
    );
  }

  double get borderWidth => 2.0;
}

class ItemTitle {
  ItemTitle({
    required this.body,
    this.codeText,
    required this.title,
    this.height,
    this.hasBorder = true,
  });
  final String title;
  final WidgetBuilder body;
  final double? height;
  final String? codeText;
  final bool hasBorder;
}
