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

  static Widget createCodeSession(
    BuildContext context, {
    required WidgetBuilder builder,
    required String codeText,
  }) {
    final textController = TextEditingController(text: codeText);

    return Tab(
      items: [
        TabItem(
          builder: (context) => Container(
            decoration: Defaults.itemDecoration(context),
            child: builder(context),
          ),
          title: Icon(Icons.visibility),
        ),
        TabItem(
          builder: (context) => Container(
            alignment: Alignment.topLeft,
            //decoration: Defaults.itemDecoration(context),
            child: TextField(
              maxLines: 1000,
              controller: textController,
              keyboardType: TextInputType.multiline,
              style: Theme.of(context).textTheme.monospace,
            ),
          ),
          title: Icon(Icons.code),
        ),
      ],
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

  static Widget createItemsWithTitle(
    BuildContext context, {
    required List<ItemTitle> items,
    required String header,
  }) {
    final controller = ScrollController();

    final result = [];

    for (final e in items) {
      result.addAll([
        Defaults.createTitle(context, e.title),
        Container(
          height: e.height,
          child: Defaults.createCodeSession(
            context,
            builder: e.body,
            codeText: e.codeText,
          ),
        ),
      ]);
    }

    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Container(
          alignment: Alignment.center,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Defaults.createHeader(context, 'Context menu'),
                ...result
              ]),
        ),
      ),
    );
  }

  double get borderWidth => 2.0;
}

class ItemTitle {
  ItemTitle({
    required this.body,
    required this.codeText,
    required this.title,
    required this.height,
  });
  final String title;
  final WidgetBuilder body;
  final double height;
  final String codeText;
}
