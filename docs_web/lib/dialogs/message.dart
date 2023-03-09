import 'package:desktop/desktop.dart';
import '../defaults.dart';

class DialogMessagePage extends StatefulWidget {
  DialogMessagePage({super.key});

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogMessagePage> {
  @override
  Widget build(BuildContext context) {
    const dismissableDialog = '''
''';

    return Defaults(
      styleItems: Defaults.createStyle(MessageTheme.of(context).toString()),
      items: [
        // ItemTitle(
        //   body: (context) => Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Text(
        //             'Messages to be shown: ${Messenger.messagesLength(context)}'),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Button.text(
        //           'Clear messages',
        //           onPressed: () => Messenger.clearMessages(context),
        //         ),
        //       ),
        //     ],
        //   ),
        //   title: 'Messager context',
        // ),
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Error message',
              onPressed: () async {
                Messenger.showMessage(
                  context,
                  message:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  title: 'Lorem Ipsum',
                  kind: MessageKind.error,
                  // actions: [
                  //   MessageAction(
                  //     onPressed: () {
                  //       messageController.close();
                  //     },
                  //     title: 'close',
                  //   ),
                  // ],
                );
              },
            ),
          ),
          codeText: dismissableDialog,
          title: 'Error message',
        ),
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Info message',
              onPressed: () async {
                Messenger.showMessage(
                  context,
                  title: 'Lorem Ipsum',
                  kind: MessageKind.info,
                  message:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                );
              },
            ),
          ),
          codeText: dismissableDialog,
          title: 'Info message',
        ),
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Warning message',
              onPressed: () async {
                Messenger.showMessage(
                  context,
                  title: 'Lorem Ipsum',
                  kind: MessageKind.warning,
                  message: 'Lorem ipsum dolor sit amet.',
                );
              },
            ),
          ),
          codeText: dismissableDialog,
          title: 'Warning message',
        ),
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Success message',
              onPressed: () async {
                Messenger.showMessage(
                  context,
                  title: 'Lorem Ipsum',
                  kind: MessageKind.success,
                  message:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                );
              },
            ),
          ),
          codeText: dismissableDialog,
          title: 'Success message',
        )
      ],
      header: 'Message',
    );
  }
}
