import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TabPage extends StatefulWidget {
  TabPage({Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    final codeSample = '''
Tab(
  items: [
    TabItem.text('page 0',
      builder: (context, _) => TabView(
        builder: (context) => Center(
          child: Text(
            'page 0',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    ),
    TabItem.text('page 1',
      builder: (context, _) => TabView(
        builder: (context) => Center(
          child: Text(
            'page 1',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    ),
    TabItem.text('page 2',
      builder: (context, _) => TabView(
        builder: (context) => Center(
          child: Text(
            'page 2',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    ),
  ],
)
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) {
            return Tab(
              items: [
                TabItem.text(
                  'page 0',
                  builder: (context) => TabView(
                    builder: (context) => Center(
                      child: Text(
                        'page 0',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                ),
                TabItem.text(
                  'page 1',
                  builder: (context) => TabView(
                    builder: (context) => Center(
                      child: Text(
                        'page 1',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                ),
                TabItem.text(
                  'page 2',
                  builder: (context) => TabView(
                    builder: (context) => Center(
                      child: Text(
                        'page 2',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          codeText: codeSample,
          title: 'Basic example',
          height: 600.0,
        ),
      ],
      header: 'Tab',
    );
  }
}
