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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints.loose(Size(300.0, 300.0)),
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: 3,
                    minLines: 3,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints.loose(Size(300.0, 300.0)),
                  padding: EdgeInsets.all(16.0),
                  child: TextField(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
