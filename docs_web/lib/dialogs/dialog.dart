import 'package:desktop/desktop.dart';
import '../defaults.dart';

class DialogPage extends StatefulWidget {
  DialogPage({Key? key}) : super(key: key);

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Dialog'),
        Expanded(
          child: Text(''),
        ),
      ],
    );
  }
}
