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
  'Click Me',
  onPressed: () {},
)
''';

    final disabledCode = '''
Button.text('Click Me')
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Button.text(
              'Click Me',
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
            child: Button.text('Click Me'),
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
