import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonTogglePage extends StatefulWidget {
  ButtonTogglePage({Key? key}) : super(key: key);

  @override
  _ButtonTogglePageState createState() => _ButtonTogglePageState();
}

class _ButtonTogglePageState extends State<ButtonTogglePage> {
  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
''';

    const disabledCode = '''
''';

    return Defaults(
      items: [
        ItemTitle(
          body: (context) => const Text(''),
          codeText: enabledCode,
          title: 'Enabled',
        ),
        ItemTitle(
          body: (context) => const Text(''),
          codeText: disabledCode,
          title: 'Disabled',
        ),
      ],
      header: 'Toggle button',
    );
  }
}
