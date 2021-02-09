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
    return Column(
      children: [
        Defaults.createHeader(context, 'Button'),
        Expanded(
          child: Center(
            child: Button(
              body: Text('Button'),
              trailing: Icon(Icons.phone),
              leading: Icon(Icons.dashboard),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
