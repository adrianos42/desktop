import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ToggleSwitchPage extends StatefulWidget {
  ToggleSwitchPage({Key? key}) : super(key: key);

  @override
  _ToggleSwitchPageState createState() => _ToggleSwitchPageState();
}

class _ToggleSwitchPageState extends State<ToggleSwitchPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
ToggleSwitch(
  onChanged: (fvalue) {
    setState(() => value = fvalue);
  },
  autofocus: false,
  value: value,
)
''';

    const disabledCode = '''
ToggleSwitch(
  autofocus: false,
  value: false,
)
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 100.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ToggleSwitch(
                    onChanged: (fvalue) {
                      setState(() => value = fvalue);
                    },
                    autofocus: false,
                    value: value,
                  ),
                ],
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
            child: SizedBox(
              width: 100.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ToggleSwitch(
                    autofocus: false,
                    value: false,
                  ),
                ],
              ),
            ),
          ),
          codeText: disabledCode,
          title: 'Disabled',
          height: 200.0,
        ),
      ],
      header: 'Toggle switch',
    );
  }
}
