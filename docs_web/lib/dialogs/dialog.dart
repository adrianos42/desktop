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
    final requiresActionCode = '''
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => Dialog(
    title: Text(''),
    menus: [
      Button.text(
        'Remove',
      ),
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

    final controller = ScrollController();

    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Defaults.createHeader(context, 'Dialog'),
            Defaults.createTitle(context, 'Dialog that requires action'),
            Container(
              constraints: BoxConstraints.tightFor(height: 400.0),
              child: Defaults.createCodeSession(
                context,
                builder: (context) => Center(
                  child: Button.text(
                    'Open dialog',
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Dialog(
                          menus: [
                            Button.text(
                              'Remove',
                            ),
                            Button.text(
                              'Close',
                              onPressed: () => Dialog.close(context),
                            ),
                          ],
                          title: Text('Lorem Ipsum'),
                          body: Text('''
Porro ut culpa voluptatem. Et quia nobis iste. Voluptatem ea voluptates nemo enim dolor ut dolorem odit. Similique impedit nesciunt nemo rerum ipsam qui. Odio unde ut fugiat dolore. Possimus itaque qui necessitatibus possimus recusandae nisi.

Vel iste voluptatum ex tenetur voluptate non atque. Porro quasi omnis voluptatem dolor quis. Corrupti eius et quo voluptatem est quo quas possimus. Culpa ex quisquam adipisci pariatur.

Est est est tempora. Pariatur ad at ut nobis nihil illo aliquid rerum. Illo non animi commodi rerum eveniet voluptates ut omnis. Error repellat blanditiis repudiandae nesciunt sit quis et maiores. Assumenda maiores sint saepe voluptate cum perspiciatis non. Cum sapiente aliquam accusamus occaecati quasi quisquam assumenda.

Possimus ea hic modi. Quas accusamus eos rerum sint quaerat. Voluptate fugit sit officia.

Eos sed fuga neque. Rerum adipisci ducimus et aspernatur in. Atque sequi fugiat officiis ducimus est voluptates minima iste. Non eius labore cum et qui. Voluptatem dolorem dolorum fugiat numquam.
'''),
                        ),
                      );
                    },
                  ),
                ),
                codeText: requiresActionCode,
              ),
            ),
            Defaults.createTitle(context, 'Dismissible dialog'),
            Container(
              constraints: BoxConstraints.tightFor(height: 400.0),
              child: Defaults.createCodeSession(
                context,
                builder: (context) => Center(
                  child: Button.text(
                    'Open dialog',
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => Dialog(
                          title: Text('Lorem Ipsum'),
                          body: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                        ),
                      );
                    },
                  ),
                ),
                codeText: dismissableDialog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
