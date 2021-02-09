import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonTogglePage extends StatefulWidget {
  ButtonTogglePage({Key? key}) : super(key: key);

  @override
  _ButtonTogglePageState createState() => _ButtonTogglePageState();
}

class _ButtonTogglePageState extends State<ButtonTogglePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Toggle button'),
        Expanded(
          child: Center(child: Text(''),),
        ),
      ],
    );
  }
}
