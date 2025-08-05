import 'package:flutter/foundation.dart';
import 'package:desktop/desktop.dart';
import 'dart:math' show Random;

const _kFontFamily = 'IBM Plex Serif';
const _kFontPackage = 'desktop';

const _kFileNames = [
  'pexels-3127729',
  'pexels-5456616',
  'pexels-4734723',
  'pexels-1828875',
  'pexels-979503',
  'pexels-1643457',
  'pexels-45170',
  'pexels-45201',
  'pexels-160755',
  'pexels-979247',
  'pexels-2693561',
  'pexels-2611939',
  'pexels-1687831',
  'pexels-4858815',
  'pexels-3030635',
  'pexels-720684',
  'pexels-479009',
  'pexels-192384',
  'pexels-1653357',
  'pexels-2817405',
  'pexels-3772262',
  'pexels-2255565',
  'pexels-1571724',
  'pexels-1416792',
  'pexels-4391733',
  'pexels-156321',
  'pexels-4411430',
  'pexels-96428',
  'pexels-1754986',
  'pexels-1299518',
  'pexels-5800065',
  'pexels-731553',
  'pexels-5044690',
  'pexels-1784289',
  'pexels-1770918',
  'pexels-104827',
];

Widget _frameBuilder(
  BuildContext context,
  Widget child,
  int? frame,
  bool wasSynchronouslyLoaded,
) {
  if (wasSynchronouslyLoaded) return child;
  return AnimatedOpacity(
    opacity: frame == null ? 0 : 1,
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOut,
    child: child,
  );
}

const paragraphTitle = 'Lorem ipsum';

const paragraph =
    '''Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.

''';

const TextStyle headerStyle = TextStyle(
  inherit: false,
  fontFamily: _kFontFamily,
  package: _kFontPackage,
  fontWeight: FontWeight.w300,
  fontSize: 44.0,
);

const TextStyle titleStyle = TextStyle(
  inherit: false,
  fontFamily: _kFontFamily,
  package: _kFontPackage,
  fontWeight: FontWeight.w400,
  fontSize: 24.0,
);

const TextStyle paragraphStyle = TextStyle(
  inherit: false,
  fontFamily: _kFontFamily,
  package: _kFontPackage,
  fontWeight: FontWeight.w400,
  fontSize: 14.0,
);

class PageOne extends StatefulWidget {
  const PageOne({
    this.index,
    this.title,
    super.key,
  }) : assert(index == null || index <= 5);

  final int? index;

  final String? title;

  @override
  State<StatefulWidget> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  static bool get _isMobile =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  WidgetSpan _createHeader(String title, Color foreground) {
    final style = headerStyle.copyWith(color: foreground);

    return WidgetSpan(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Text(
          title,
          style: style,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  WidgetSpan _createParagraphsWithRightImage(
      List<TextSpan> contents, String image, Color foreground) {
    final style = paragraphStyle.copyWith(color: foreground);

    return WidgetSpan(
      child: Flex(
        direction: _isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!_isMobile)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: style,
                    children: contents,
                  ),
                ),
              ),
            ),
          Container(
            constraints: const BoxConstraints(maxWidth: 300.0),
            child: Image.asset(
              'assets/cats_small/$image.webp',
              fit: BoxFit.contain,
              frameBuilder: _frameBuilder,
            ),
          ),
          if (_isMobile)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RichText(
                text: TextSpan(
                  style: style,
                  children: contents,
                ),
              ),
            ),
        ],
      ),
    );
  }

  WidgetSpan _createParagraphsWithLeftImage(
      List<TextSpan> contents, String image, Color foreground) {
    final style = paragraphStyle.copyWith(color: foreground);

    return WidgetSpan(
      child: Flex(
        direction: _isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 300.0),
            child: Image.asset(
              'assets/cats_small/$image.webp',
              fit: BoxFit.contain,
              frameBuilder: _frameBuilder,
            ),
          ),
          if (_isMobile)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RichText(
                text: TextSpan(
                  style: style,
                  children: contents,
                ),
              ),
            ),
          if (!_isMobile)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: style,
                    children: contents,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  WidgetSpan _createTitle(String title, Color foreground) {
    final style = titleStyle.copyWith(color: foreground);

    return WidgetSpan(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
            child: Text(
              title,
              style: style,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  late int index;

  TextSpan _createItem0() {
    return TextSpan(
      style: bodyStyle,
      children: [
        _createHeader(paragraphTitle, foreground),
        _createTitle(paragraphTitle, foreground),
        _createParagraphsWithRightImage(
          [paragraph, paragraph, paragraph, paragraph, paragraph]
              .map((e) => TextSpan(text: e))
              .toList(),
          _kFileNames[3],
          foreground,
        ),
        _createTitle(paragraphTitle, foreground),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        _createParagraphsWithLeftImage(
          [paragraph, paragraph].map((e) => TextSpan(text: e)).toList(),
          _kFileNames[4],
          foreground,
        ),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
      ],
    );
  }

  TextSpan _createItem1() {
    return TextSpan(
      style: bodyStyle,
      children: [
        _createHeader(paragraphTitle, foreground),
        _createTitle(paragraphTitle, foreground),
        _createParagraphsWithLeftImage(
          [paragraph, paragraph, paragraph, paragraph, paragraph]
              .map((e) => TextSpan(text: e))
              .toList(),
          _kFileNames[12],
          foreground,
        ),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
      ],
    );
  }

  TextSpan _createItem2() {
    return TextSpan(
      style: bodyStyle,
      children: [
        _createHeader(paragraphTitle, foreground),
        _createTitle(paragraphTitle, foreground),
        _createParagraphsWithRightImage(
          [paragraph, paragraph, paragraph]
              .map((e) => TextSpan(text: e))
              .toList(),
          _kFileNames[13],
          foreground,
        ),
        _createTitle(paragraphTitle, foreground),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
      ],
    );
  }

  TextSpan _createItem3() {
    return TextSpan(
      style: bodyStyle,
      children: [
        _createHeader(paragraphTitle, foreground),
        _createTitle(paragraphTitle, foreground),
        _createParagraphsWithLeftImage(
          [paragraph, paragraph, paragraph, paragraph, paragraph]
              .map((e) => TextSpan(text: e))
              .toList(),
          _kFileNames[18],
          foreground,
        ),
        _createTitle(paragraphTitle, foreground),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        _createParagraphsWithRightImage(
          [paragraph, paragraph, paragraph, paragraph, paragraph]
              .map((e) => TextSpan(text: e))
              .toList(),
          _kFileNames[19],
          foreground,
        ),
      ],
    );
  }

  TextSpan _createItem4() {
    return TextSpan(
      style: bodyStyle,
      children: [
        _createHeader(paragraphTitle, foreground),
        _createTitle(paragraphTitle, foreground),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        _createTitle(paragraphTitle, foreground),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        _createParagraphsWithLeftImage(
          [paragraph, paragraph].map((e) => TextSpan(text: e)).toList(),
          _kFileNames[22],
          foreground,
        ),
      ],
    );
  }

  TextSpan _createItem5() {
    final bodyStyle = paragraphStyle.copyWith(color: foreground);

    return TextSpan(
      style: bodyStyle,
      children: [
        _createHeader(paragraphTitle, foreground),
        _createTitle(paragraphTitle, foreground),
        _createParagraphsWithLeftImage(
          [paragraph, paragraph, paragraph, paragraph, paragraph]
              .map((e) => TextSpan(text: e))
              .toList(),
          _kFileNames[24],
          foreground,
        ),
        _createTitle(paragraphTitle, foreground),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
        const TextSpan(text: paragraph),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    index = widget.index ?? Random().nextInt(5);
  }

  Color get foreground => Theme.of(context).contentTextTheme.textHigh;
  Color get background => Theme.of(context).contentColorScheme.background[0];
  TextStyle get bodyStyle => paragraphStyle.copyWith(color: foreground);

  @override
  Widget build(BuildContext context) {
    final text = switch (index) {
      1 => _createItem1(),
      2 => _createItem2(),
      3 => _createItem3(),
      4 => _createItem4(),
      5 => _createItem5(),
      _ => _createItem0(),
    };

    return ColoredBox(
      color: background,
      child: SingleChildScrollView(
        padding: const EdgeInsetsGeometry.all(32.0),
        child: SelectableText.rich(
          text,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
