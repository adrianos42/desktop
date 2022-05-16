import 'package:desktop/desktop.dart';
import '../defaults.dart';

class StatusBarPage extends StatefulWidget {
  StatusBarPage({Key? key}) : super(key: key);

  @override
  _StatusBarPageState createState() => _StatusBarPageState();
}

class _StatusBarPageState extends State<StatusBarPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Status bar'),
        const Expanded(
          child: Center(
            child: Text(''),
          ),
        ),
      ],
    );
  }
}
