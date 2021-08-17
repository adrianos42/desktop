import 'package:desktop/desktop.dart';
import '../defaults.dart';

class DialogMessagePage extends StatefulWidget {
  DialogMessagePage({Key? key}) : super(key: key);

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogMessagePage> {
  @override
  Widget build(BuildContext context) {
    final requiresActionCode = '''
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => Dialog(
    title: Text(''),
    menus: [
      Button.text(
        'Close',
        onPressed: () => Dialog.close(context),
      ),
    ],
  ),
  body: Text(''),
)
''';

    final dismissableDialog = '''
showDialog(
  context: context, 
  barrierDismissible: true,
  builder: (context) => Dialog(
    title: Text(''),
  ),
  body: Text(''),
)
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Open dialog',
              onPressed: () async {
                showMessageDialog(
                  context: context,
                  title: 'Lorem Ipsum',
                  kind: MessageKind.error,
                  message:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                );
              },
            ),
          ),
          codeText: dismissableDialog,
          title: 'Dismissible dialog',
          height: 400.0,
        )
      ],
      header: 'Dialog',
    );
  }
}
