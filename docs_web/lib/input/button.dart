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

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Button(
                body: Text('Button'),
                trailing: Icon(Icons.phone),
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
                trailing: Icon(Icons.phone),
                leading: Icon(Icons.control_camera),
              ),
            ),
          ),
          codeText: disabledCode,
          title: 'Disabled',
          height: 200.0,
        ),
      ],
      header: 'Button',
    );
  }
}
