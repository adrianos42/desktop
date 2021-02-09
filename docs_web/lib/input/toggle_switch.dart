import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ToggleSwitchPage extends StatefulWidget {
  ToggleSwitchPage({Key? key}) : super(key: key);

  @override
  _ToggleSwitchPageState createState() => _ToggleSwitchPageState();
}

class _ToggleSwitchPageState extends State<ToggleSwitchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Toggle switch'),
        Expanded(
          child: Center(
            child: ToggleSwitch(
              onChanged: (value) {},
              autofocus: true,
              value: true,
            ),
          ),
        ),
      ],
    );
  }
}
