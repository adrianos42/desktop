import 'package:flutter/widgets.dart';
import 'package:desktop/desktop.dart';

class CodeTextController extends TextEditingController {
  CodeTextController({super.text});

  static final _regex = RegExp(
    r'''(?<class>\b[_$]*[A-Z][a-zA-Z0-9_$]*\b|bool\b|num\b|int\b|double\b|dynamic\b|(void)\b)|(?<string>(?:'.*?'))|(?<keyword>\b(?:try|on|catch|finally|throw|rethrow|break|case|continue|default|do|else|for|if|in|return|switch|while|abstract|class|enum|extends|extension|external|factory|implements|get|mixin|native|operator|set|typedef|with|covariant|static|final|const|required|late|void|var|library|import|part of|part|export|await|yield|async|sync|true|false)\b)|(?<comment>(?:(?:\/.*?)$))|(?<numeric>\b(?:(?:0(?:x|X)[0-9a-fA-F]*)|(?:(?:[0-9]+\.?[0-9]*)|(?:\.[0-9]+))(?:(?:e|E)(?:\+|-)?[0-9]+)?)\b)''',
    multiLine: true,
    dotAll: true,
  );

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final brightness = Theme.of(context).brightness;

    ///const classColor = Color(0xff5ac4a0);
    ///const commentsColor = Color(0xff696969);
    ///const textColor = Color(0xffd3d3d3);
    ///const stringColor  = Color(0xffcd8162);
    final numericColor =
        brightness == Brightness.dark ? Color(0xffcae6bd) : Color(0xff768a76);

    ///const keywordColor = Color(0xff5dadee);

    final classColor = PrimaryColor.springGreen.withBrightness(brightness)[70];
    final commentsColor = Theme.of(context).colorScheme.shade[40];
    final stringColor = PrimaryColor.sandyBrown.withBrightness(brightness)[70];
    //final numericColor = PrimaryColor.lightGoldenrod.withBrightness(brightness)[70];
    final keywordColor = PrimaryColor.dodgerBlue.withBrightness(brightness)[70];
    final textColor = Theme.of(context).textTheme.textHigh;

    final matches = _regex.allMatches(text);

    final spans = <TextSpan>[];

    int lastEnd = 0;

    for (final match in matches) {
      final start = match.start;
      final end = match.end;

      spans.add(TextSpan(text: text.substring(lastEnd, start)));

      if (match.namedGroup('class') != null) {
        spans.add(TextSpan(
            text: text.substring(start, end),
            style: TextStyle(color: classColor)));
      } else if (match.namedGroup('keyword') != null) {
        spans.add(TextSpan(
            text: text.substring(start, end),
            style: TextStyle(color: keywordColor)));
      } else if (match.namedGroup('string') != null) {
        spans.add(TextSpan(
            text: text.substring(start, end),
            style: TextStyle(color: stringColor)));
      } else if (match.namedGroup('comment') != null) {
        spans.add(TextSpan(
            text: text.substring(start, end),
            style: TextStyle(color: commentsColor)));
      } else if (match.namedGroup('numeric') != null) {
        spans.add(TextSpan(
            text: text.substring(start, end),
            style: TextStyle(color: numericColor)));
      } else {
        spans.add(TextSpan(text: text.substring(start, end)));
      }

      lastEnd = end;
    }

    spans.add(TextSpan(text: text.substring(lastEnd)));

    return TextSpan(
      style: Theme.of(context).textTheme.monospace.copyWith(color: textColor, fontSize: 14),
      children: spans,
    );
  }
}

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
          TabItem(
            itemBuilder: (context, _) => const Icon(Icons.visibility),
            builder: (context, _) => Container(
              decoration: hasBorder ? Defaults.itemDecoration(context) : null,
              child: builder(context),
            ),
          ),
          TabItem(
            itemBuilder: (context, _) => const Icon(Icons.code),
            builder: (context, _) => Container(
              alignment: Alignment.topLeft,
              //decoration: Defaults.itemDecoration(context),
              child: TextField(
                minLines: 1000,
                maxLines: null,
                controller: CodeTextController(text: codeText),
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
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
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
      padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 8.0),
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
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 4.0),
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
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 2.0),
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
        SizedBox(
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
        margin: const EdgeInsets.all(16.0),
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
