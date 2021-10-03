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
    final enabledCode = '''
Button(
  body: Text('Button'),
  trailing: Icon(Icons.phone),
  leading: Icon(Icons.control_camera),
  onPressed: () {},
)
''';

    final disabledCode = '''
Button(
  body: Text('Button'),
  trailing: Icon(Icons.phone),
  leading: Icon(Icons.control_camera),
)
''';

    final customCode = '''
Button.text(
  'Custom',
  color: HSLColor.fromAHSL(1.0, 150, 0.8, 0.4),
  hoverColor: HSLColor.fromAHSL(1.0, 150, 0.8, 0.6),
  highlightColor: HSLColor.fromAHSL(1.0, 150, 0.8, 0.4),
  onPressed: () {},
)
''';

    final customColor = HSLColor.fromAHSL(1.0, 150, 0.6, 0.5).toColor();
    final buttonTheme = Theme.of(context).buttonTheme;

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Button(
                body: Text('Button'),
                leading: Icon(Icons.control_camera),
                onPressed: () {},
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
            child: Container(
              child: Button(
                body: Text('Button'),
                leading: Icon(Icons.control_camera),
              ),
            ),
          ),
          codeText: disabledCode,
          title: 'Disabled',
          height: 200.0,
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Button(
                body: Text('Custom'),
                // Uses a recommended color for the button.
                color: customColor,
                highlightColor: Theme.of(context).textTheme.textLow,
                onPressed: () {},
              ),
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
