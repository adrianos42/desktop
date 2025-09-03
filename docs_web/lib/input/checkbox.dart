import 'package:desktop/desktop.dart';

import '../defaults.dart';
import 'content.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool first = false;
  bool second = false;
  bool? third;
  bool _disabled = false;
  bool _buttonContent = false;

  @override
  Widget build(BuildContext context) {
    const exampleCode = '''
return Container(
  width: 200.0,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Checkbox(
        value: first,
        tristate: false,
        onChanged: (fvalue) {
          setState(() => first = fvalue!);
        },
      ),
      Checkbox(
        value: second,
        tristate: false,
        onChanged: (fvalue) {
          setState(() => second = fvalue!);
        },
      ),
      Checkbox(
        value: third,
        tristate: true,
        onChanged: (fvalue) {
          setState(() => third = fvalue);
        },
      ),
    ],
  ),
);
''';

    final themeData = CheckboxTheme.of(context);

    return Defaults(
      header: 'Checkbox',
      styleItems: Defaults.createStyle(themeData.toString()),
      items: [
        ItemTitle(
          title: 'Example',
          body: (context) => InputContent(
            enabled: _buttonContent,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Checkbox(
                      value: first,
                      tristate: false,
                      onChanged: !_disabled
                          ? (fvalue) {
                              setState(() => first = fvalue!);
                            }
                          : null,
                    ),
                    Checkbox(
                      value: second,
                      tristate: false,
                      onChanged: !_disabled
                          ? (fvalue) {
                              setState(() => second = fvalue!);
                            }
                          : null,
                    ),
                    Checkbox(
                      value: third,
                      tristate: true,
                      onChanged: !_disabled
                          ? (fvalue) {
                              setState(() => third = fvalue);
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          options: [
            Button.icon(
              Icons.lightMode,
              active: _buttonContent,
              onPressed: () => setState(() => _buttonContent = !_buttonContent),
            ),
            Button.icon(
              Icons.close,
              active: _disabled,
              onPressed: () => setState(() => _disabled = !_disabled),
            ),
          ],
          codeText: exampleCode,
        ),
      ],
    );
  }
}
