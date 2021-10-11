import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TextFieldPage extends StatefulWidget {
  TextFieldPage({Key? key}) : super(key: key);

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _multiFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    const multiLineExample = '''
  TextField(
    maxLines: 3,
    minLines: 3,
  )
    ''';

    const basicExample = 'TextField()';

    return Defaults.createItemsWithTitle(
      context,
      header: 'Text field',
      items: [
        ItemTitle(
          body: (context) => Container(
              margin: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  SizedBox(
                    width: 200.0,
                    child: TextField(
                      focusNode: _focusNode,
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: TextField(
                      focusNode: _focusNode2,
                    ),
                  ),
                ],
              )),
          codeText: basicExample,
          title: 'Basic example',
          height: 300.0,
        ),
        ItemTitle(
          body: (context) => Container(
            margin: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 300.0,
              child: TextField(
                maxLines: 3,
                focusNode: _multiFocusNode,
              ),
            ),
          ),
          codeText: multiLineExample,
          title: 'Multiline example',
          height: 300.0,
        ),
      ],
    );
  }
}
