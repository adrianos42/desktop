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
    TabItem(
      builder: (context) => Center(
          child: Text(
        'page 0',
        style: textTheme.title,
      )),
      title: Text('page 0'),
    ),
    TabItem(
      builder: (context) => Center(
          child: Text(
        'page 1',
        style: textTheme.title,
      )),
      title: Text('page 1'),
    ),
    TabItem(
      builder: (context) => Center(
          child: Text(
        'page 2',
        style: textTheme.title,
      )),
      title: Text('page 2'),
    ),
  ],
)
''';

    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Defaults.createHeader(context, 'Tab'),
        Expanded(
          child: Defaults.createCodeSession(
            context,
            builder: (context) => Tab(
              items: [
                TabItem(
                  builder: (context) => Center(
                      child: Text(
                    'page 0',
                    style: textTheme.title,
                  )),
                  title: Text('page 0'),
                ),
                TabItem(
                  builder: (context) => Center(
                      child: Text(
                    'page 1',
                    style: textTheme.title,
                  )),
                  title: Text('page 1'),
                ),
                TabItem(
                  builder: (context) => Center(
                      child: Text(
                    'page 2',
                    style: textTheme.title,
                  )),
                  title: Text('page 2'),
                ),
              ],
            ),
            codeText: codeSample,
          ),
        ),
      ],
    );
  }
}
