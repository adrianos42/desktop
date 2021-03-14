import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonHyperlinkPage extends StatefulWidget {
  ButtonHyperlinkPage({Key? key}) : super(key: key);

  @override
  _ButtonHyperlinkPageState createState() => _ButtonHyperlinkPageState();
}

class _ButtonHyperlinkPageState extends State<ButtonHyperlinkPage> {
  @override
  Widget build(BuildContext context) {
    final enabledCode = '''
HyperlinkButton(
  'https://github.com/adrianos42/desktop',
  onPressed: (value) {},
),
''';

    final disabledCode = '''
HyperlinkButton('https://github.com/adrianos42/desktop'),
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 50,
              child: HyperlinkButton(
                'https://github.com/adrianos42/desktop',
                onPressed: (value) {},
              ),
            ),
          ),
          codeText: enabledCode,
          title: 'Enabled',
          height: 200.0,
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 50,
              child: HyperlinkButton('https://github.com/adrianos42/desktop'),
            ),
          ),
          codeText: disabledCode,
          title: 'Disabled',
          height: 200.0,
        ),
      ],
      header: 'Hyperlink',
    );
  }
}
