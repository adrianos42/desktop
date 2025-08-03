import 'package:desktop/desktop.dart';

import '../defaults.dart';
import 'content.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _disabledFilled = false;
  bool _contentFilled = false;
  bool _disabledText = false;
  bool _disabledIcon = false;

  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
return Button(
  body: Text('Button'),
  trailing: Icon(Icons.phone),
  leading: Icon(Icons.control_camera),
  onPressed: () {},
);
''';

    const disabledCode = '''
return Button(
  body: Text('Button'),
  trailing: Icon(Icons.phone),
  leading: Icon(Icons.control_camera),
);
''';

    const customCode = '''
return Button.text(
  'Custom',
  color: HSLColor.fromAHSL(1.0, 150, 0.8, 0.4),
  hoverColor: HSLColor.fromAHSL(1.0, 150, 0.8, 0.6),
  highlightColor: HSLColor.fromAHSL(1.0, 150, 0.8, 0.4),
  onPressed: () {},
);
''';

    final customColor = (const HSLColor.fromAHSL(1.0, 150, 0.6, 0.5)).toColor();

    final ButtonThemeData themeData = ButtonTheme.of(context);

    return Defaults(
      header: 'Button',
      styleItems: Defaults.createStyle(themeData.toString()),
      items: [
        ItemTitle(
          title: 'Filled',
          body: (context) => InputContent(
            enabled: _contentFilled,
            child: Button.filled(
              'Login',
              onPressed: !_disabledFilled ? () {} : null,
            ),
          ),
          codeText: enabledCode,
          options: [
            Button.icon(
              Icons.lightMode,
              active: _contentFilled,
              onPressed: () => setState(
                () => _contentFilled = !_contentFilled,
              ),
            ),
            Button.icon(
              Icons.close,
              active: _disabledFilled,
              onPressed: () =>
                  setState(() => _disabledFilled = !_disabledFilled),
            ),
          ],
        ),
        ItemTitle(
          title: 'Text',
          body: (context) => Center(
            child: Button.text(
              'Button',
              onPressed: !_disabledText ? () {} : null,
            ),
          ),
          codeText: !_disabledText ? enabledCode : disabledCode,
          options: [
            Button.icon(
              Icons.close,
              active: _disabledText,
              onPressed: () => setState(() => _disabledText = !_disabledText),
            ),
          ],
        ),
        ItemTitle(
          title: 'Icon',
          body: (context) => Center(
            child:  Button.icon(
              Icons.controlCamera,
              onPressed: !_disabledIcon ? () {} : null,
            ),
          ),
          codeText: enabledCode,
          options: [
            Button.icon(
              Icons.close,
              active: _disabledIcon,
              onPressed: () => setState(() => _disabledIcon = !_disabledIcon),
            ),
          ],
        ),
        ItemTitle(
          title: 'Text and icon',
          body: (context) => Align(
            alignment: Alignment.center,
            child: Button(
              body: const Text('Button'),
              leading: const Icon(Icons.controlCamera),
              onPressed: () {},
            ),
          ),
          codeText: enabledCode,
        ),
        ItemTitle(
          title: 'Custom',
          body: (context) => Align(
            alignment: Alignment.center,
            child: Button(
              body: const Text('Custom Button'),
              // Uses a recommended color for the button.
              theme: ButtonThemeData(
                color: customColor,
                highlightColor: Theme.of(context).textTheme.textLow,
              ),
              onPressed: () {},
            ),
          ),
          codeText: customCode,
        ),
      ],
    );
  }
}
