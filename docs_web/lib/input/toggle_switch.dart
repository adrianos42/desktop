import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ToggleSwitchPage extends StatefulWidget {
  const ToggleSwitchPage({super.key});

  @override
  State<ToggleSwitchPage> createState() => _ToggleSwitchPageState();
}

class _ToggleSwitchPageState extends State<ToggleSwitchPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
return ToggleSwitch(
  onChanged: (fvalue) {
    setState(() => value = fvalue);
  },
  autofocus: false,
  value: value,
);
''';

    const disabledCode = '''
return ToggleSwitch(
  autofocus: false,
  value: false,
);
''';

    return Defaults(
      styleItems: Defaults.createStyle(ToggleSwitchTheme.of(context).toString()),
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0,
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
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.center,
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
        ),
      ],
      header: 'Toggle Switch',
    );
  }
}
