import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _multiFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    const multiLineExample = '''
  return TextField(
    maxLines: 3,
    minLines: 3,
  );
    ''';

    const basicExample = 'return TextField();';

    return Defaults(
      header: 'Text Field',
      items: [
        ItemTitle(
          body: (context) => Container(
            margin: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0,
              child: TextField(
                focusNode: _focusNode,
                maxLines: 1,
              ),
            ),
          ),
          codeText: basicExample,
          title: 'Basic example',
        ),
        ItemTitle(
          body: (context) => Container(
            margin: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: SizedBox(
              width: 300.0,
              child: TextField(
                minLines: 1,
                maxLines: 3,
                focusNode: _multiFocusNode,
              ),
            ),
          ),
          codeText: multiLineExample,
          title: 'Multiline example',
        ),
      ],
    );
  }
}
