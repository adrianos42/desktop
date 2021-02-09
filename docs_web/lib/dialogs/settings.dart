import 'package:desktop/desktop.dart';
import '../defaults.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Settings'),
        Expanded(
          child: Text(''),
        ),
      ],
    );
  }
}
