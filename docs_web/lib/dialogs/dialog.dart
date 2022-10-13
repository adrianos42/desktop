import 'package:desktop/desktop.dart';
import '../defaults.dart';

class DialogPage extends StatefulWidget {
  DialogPage({Key? key}) : super(key: key);

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  bool _dialogActive = false;
  bool _dialogDismissActive = false;

  @override
  Widget build(BuildContext context) {
    const requiresActionCode = '''
return Button.text(
  'Open dialog',
  active: _dialogActive,
  onPressed: () async {
    setState(() => _dialogActive = true);
    late DialogController dialogController;
    dialogController = showDialog(
      context,
      dismissible: false,
      builder: (context) => Dialog(
        actions: [
          DialogAction(
            title: 'Close',
            onPressed: () => dialogController.close(),
          ),
        ],
        title: const Text('Lorem Ipsum'),
        body: const Text(\'\'\'
Porro ut culpa voluptatem. Et quia nobis iste. Voluptatem ea voluptates nemo enim dolor ut dolorem odit. Similique impedit nesciunt nemo rerum ipsam qui. Odio unde ut fugiat dolore. Possimus itaque qui necessitatibus possimus recusandae nisi.

Vel iste voluptatum ex tenetur voluptate non atque. Porro quasi omnis voluptatem dolor quis. Corrupti eius et quo voluptatem est quo quas possimus. Culpa ex quisquam adipisci pariatur.

Est est est tempora. Pariatur ad at ut nobis nihil illo aliquid rerum. Illo non animi commodi rerum eveniet voluptates ut omnis. Error repellat blanditiis repudiandae nesciunt sit quis et maiores. Assumenda maiores sint saepe voluptate cum perspiciatis non. Cum sapiente aliquam accusamus occaecati quasi quisquam assumenda.

Possimus ea hic modi. Quas accusamus eos rerum sint quaerat. Voluptate fugit sit officia.

Eos sed fuga neque. Rerum adipisci ducimus et aspernatur in. Atque sequi fugiat officiis ducimus est voluptates minima iste. Non eius labore cum et qui. Voluptatem dolorem dolorum fugiat numquam.
\'\'\'),
          ),
      );

      final _ = await dialogController.closed;

      setState(() => _dialogActive = false);
    },
  );
''';

    const dismissableDialog = '''
return Button.text(
  'Open dialog',
  active: _dialogDismissActive,
  onPressed: () async {
    setState(() => _dialogDismissActive = true);

    final dialog = showDialog(
      context,
      builder: (context) => const Dialog(
        title: Text('Lorem Ipsum'),
        body: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
      ),
    );

    final _ = await dialog.closed;

    setState(() => _dialogDismissActive = false);
  },
);
''';

    return Defaults(
      styleItems: Defaults.createStyle(DialogTheme.of(context).toString()),
      items: [
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Open dialog',
              active: _dialogActive,
              onPressed: () async {
                setState(() => _dialogActive = true);
                await Dialog.showDialog(
                  context,
                  barrierDismissible: false,
                  actions: [
                    DialogAction(
                      title: 'Close',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                  title: const Text('Lorem Ipsum'),
                  body: const Text('''
Porro ut culpa voluptatem. Et quia nobis iste. Voluptatem ea voluptates nemo enim dolor ut dolorem odit. Similique impedit nesciunt nemo rerum ipsam qui. Odio unde ut fugiat dolore. Possimus itaque qui necessitatibus possimus recusandae nisi.

Vel iste voluptatum ex tenetur voluptate non atque. Porro quasi omnis voluptatem dolor quis. Corrupti eius et quo voluptatem est quo quas possimus. Culpa ex quisquam adipisci pariatur.

Est est est tempora. Pariatur ad at ut nobis nihil illo aliquid rerum. Illo non animi commodi rerum eveniet voluptates ut omnis. Error repellat blanditiis repudiandae nesciunt sit quis et maiores. Assumenda maiores sint saepe voluptate cum perspiciatis non. Cum sapiente aliquam accusamus occaecati quasi quisquam assumenda.

Possimus ea hic modi. Quas accusamus eos rerum sint quaerat. Voluptate fugit sit officia.

Eos sed fuga neque. Rerum adipisci ducimus et aspernatur in. Atque sequi fugiat officiis ducimus est voluptates minima iste. Non eius labore cum et qui. Voluptatem dolorem dolorum fugiat numquam.
'''),
                );

                setState(() => _dialogActive = false);
              },
            ),
          ),
          codeText: requiresActionCode,
          title: 'Dialog that requires action',
        ),
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Open dialog',
              active: _dialogDismissActive,
              onPressed: () async {
                setState(() => _dialogDismissActive = true);

                await Dialog.showDialog(
                  context,
                  title: const Text('Lorem Ipsum'),
                  body: const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                );

                setState(() => _dialogDismissActive = false);
              },
            ),
          ),
          codeText: dismissableDialog,
          title: 'Dismissible dialog',
        )
      ],
      header: 'Dialog',
    );
  }
}
