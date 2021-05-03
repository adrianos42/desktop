import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonTextPage extends StatefulWidget {
  ButtonTextPage({Key? key}) : super(key: key);

  @override
  _ButtonTextPageState createState() => _ButtonTextPageState();
}

class _ButtonTextPageState extends State<ButtonTextPage> {
  @override
  Widget build(BuildContext context) {
    final enabledCode = '''
Button.text(
  'Click me',
  onPressed: () {},
)
''';

    final disabledCode = '''
Button.text('Click me')
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Button.text(
              'Click me',
              onPressed: () {},
            ),
          ),
          codeText: enabledCode,
          title: 'Enabled',
          height: 200.0,
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Button.text('Click me'),
          ),
          codeText: disabledCode,
          title: 'Disabled',
          height: 200.0,
        ),
      ],
      header: 'Text button',
    );
  }
}
