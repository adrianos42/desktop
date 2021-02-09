import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TextFieldPage extends StatefulWidget {
  TextFieldPage({Key? key}) : super(key: key);

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Text field'),
        Expanded(
          child: Center(child: Center(child: TextField(),),),
        ),
      ],
    );
  }
}
