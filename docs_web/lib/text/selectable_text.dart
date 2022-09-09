import 'package:desktop/desktop.dart';
import '../defaults.dart';

class SelectableTextPage extends StatefulWidget {
  SelectableTextPage({Key? key}) : super(key: key);

  @override
  _SelectableTextPageState createState() => _SelectableTextPageState();
}

class _SelectableTextPageState extends State<SelectableTextPage> {
  @override
  Widget build(BuildContext context) {
    const basicExample = 'SelectableText()';

    return Defaults.createItemsWithTitle(
      context,
      header: 'Selectable text',
      items: [
        ItemTitle(
          body: (context) => Container(
            margin: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Column(
              children: const [
                SizedBox(
                  child: SelectableText(
                    '''
Porro ut culpa voluptatem. Et quia nobis iste. Voluptatem ea voluptates nemo enim dolor ut dolorem odit.
Similique impedit nesciunt nemo rerum ipsam qui. Odio unde ut fugiat dolore. Possimus itaque qui necessitatibus possimus recusandae nisi.
Vel iste voluptatum ex tenetur voluptate non atque. Porro quasi omnis voluptatem dolor quis. Corrupti eius et quo voluptatem est quo quas possimus. Culpa ex quisquam adipisci pariatur.
Est est est tempora. Pariatur ad at ut nobis nihil illo aliquid rerum. Illo non animi commodi rerum eveniet voluptates ut omnis. Error repellat blanditiis repudiandae nesciunt sit quis et maiores. Assumenda maiores sint saepe voluptate cum perspiciatis non. Cum sapiente aliquam accusamus occaecati quasi quisquam assumenda.
Possimus ea hic modi. Quas accusamus eos rerum sint quaerat. Voluptate fugit sit officia.
Eos sed fuga neque. Rerum adipisci ducimus et aspernatur in. Atque sequi fugiat officiis ducimus est voluptates minima iste. Non eius labore cum et qui. Voluptatem dolorem dolorum fugiat numquam.
''',
                    minLines: 1,
                    maxLines: 1000,
                  ),
                ),
              ],
            ),
          ),
          codeText: basicExample,
          title: 'Basic example',
          height: 400.0,
        ),
      ],
    );
  }
}
