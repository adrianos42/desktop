import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonPage extends StatefulWidget {
  ButtonPage({super.key});

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _disabledText = false;

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
      styleItems: Defaults.createStyle(themeData.toString()),
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.center,
            child: Button.text(
              'Button',
              onPressed: !_disabledText ? () {} : null,
            ),
          ),
          codeText: !_disabledText ? enabledCode : disabledCode,
          title: 'Text',
          options: [
            Button.icon(
              Icons.close,
              active: _disabledText,
              onPressed: () => setState(() => _disabledText = !_disabledText),
            ),
          ],
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.center,
            child: Button.icon(
              Icons.control_camera,
              onPressed: () {},
            ),
          ),
          codeText: enabledCode,
          title: 'Icon',
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.center,
            child: Button(
              body: const Text('Button'),
              leading: const Icon(Icons.control_camera),
              onPressed: () {},
            ),
          ),
          codeText: enabledCode,
          title: 'Text and icon',
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.center,
            child: Button.filled(
              'Login',
              onPressed: () {},
            ),
          ),
          codeText: enabledCode,
          title: 'Filled',
        ),
        // ItemTitle(
        //   body: (context) => const Align(
        //     alignment: Alignment.center,
        //     child: Button(
        //       body: Text('Button'),
        //       leading: Icon(Icons.control_camera),
        //       onPressed: null,
        //     ),
        //   ),
        //   codeText: disabledCode,
        //   title: 'Disabled',
        //   height: 200.0,
        // ),
        ItemTitle(
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
          title: 'Custom',
        ),
      ],
      header: 'Button',
    );
  }
}
