import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TreePage extends StatefulWidget {
  TreePage({Key? key}) : super(key: key);

  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Tree'),
        Expanded(
          child: Text(''),
        ),
      ],
    );
  }
}
