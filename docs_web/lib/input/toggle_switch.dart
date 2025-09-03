import 'package:desktop/desktop.dart';

import '../defaults.dart';

class ToggleSwitchPage extends StatefulWidget {
  const ToggleSwitchPage({super.key});

  @override
  State<ToggleSwitchPage> createState() => _ToggleSwitchPageState();
}

class _ToggleSwitchPageState extends State<ToggleSwitchPage> {
  bool value = false;
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    const exampleCode = '''
return ToggleSwitch(
  onChanged: (fvalue) {
    setState(() => value = fvalue);
  },
  autofocus: false,
  value: value,
);
''';

    return Defaults(
      header: 'Toggle Switch',
      styleItems: Defaults.createStyle(
        ToggleSwitchTheme.of(context).toString(),
      ),
      items: [
        ItemTitle(
          title: 'Example',
          body: (context) => Center(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToggleSwitch(
                      onChanged: !_disabled
                          ? (fvalue) {
                              setState(() => value = fvalue);
                            }
                          : null,
                      autofocus: false,
                      value: value,
                    ),
                  ],
                ),
              ),
            ),
          ),
          codeText: exampleCode,
          options: [
            Button.icon(
              Icons.close,
              active: _disabled,
              onPressed: () => setState(() => _disabled = !_disabled),
            ),
          ],
        ),
      ],
    );
  }
}
