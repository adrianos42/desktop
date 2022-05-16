import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonPage extends StatefulWidget {
  ButtonPage({Key? key}) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
Button(
  body: Text('Button'),
  trailing: Icon(Icons.phone),
  leading: Icon(Icons.control_camera),
  onPressed: () {},
)
''';

    const disabledCode = '''
Button(
  body: Text('Button'),
  trailing: Icon(Icons.phone),
  leading: Icon(Icons.control_camera),
)
''';

    const customCode = '''
Button.text(
  'Custom',
  color: HSLColor.fromAHSL(1.0, 150, 0.8, 0.4),
  hoverColor: HSLColor.fromAHSL(1.0, 150, 0.8, 0.6),
  highlightColor: HSLColor.fromAHSL(1.0, 150, 0.8, 0.4),
  onPressed: () {},
)
''';

    final customColor = (const HSLColor.fromAHSL(1.0, 150, 0.6, 0.5)).toColor();

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Button(
              body: const Text('Button'),
              leading: const Icon(Icons.control_camera),
              onPressed: () {},
            ),
          ),
          codeText: enabledCode,
          title: 'Enabled',
          height: 200.0,
        ),
        ItemTitle(
          body: (context) => const Align(
            alignment: Alignment.centerLeft,
            child: Button(
              body: Text('Button'),
              leading: Icon(Icons.control_camera),
            ),
          ),
          codeText: disabledCode,
          title: 'Disabled',
          height: 200.0,
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Button(
              body: const Text('Custom'),
              // Uses a recommended color for the button.
              color: customColor,
              highlightColor: Theme.of(context).textTheme.textLow,
              onPressed: () {},
            ),
          ),
          codeText: customCode,
          title: 'Enabled',
          height: 200.0,
        ),
      ],
      header: 'Button with custom color',
    );
  }
}
