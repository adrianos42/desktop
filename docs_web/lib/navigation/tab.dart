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

    return Column(
      children: [
        Defaults.createHeader(context, 'Tab'),
        Expanded(
          child: Defaults.createCodeSession(
            context,
            builder: (context) {
              // return Tab(
              //   color: Theme.of(context).colorScheme.background1,
              //   items: [
              //     TabItem(
              //       builder: (context, _) => TabView(
              //         builder: (context) => Center(
              //           child: Text(
              //             'page 0',
              //             style: Theme.of(context).textTheme.title,
              //           ),
              //         ),
              //       ),
              //       tabItemBuilder: (context, index, active) => Container(
              //         alignment: Alignment.center,
              //         color: TabScope.of(context)!.currentIndex! == index
              //             ? Theme.of(context).colorScheme.background.toColor()
              //             : null,
              //         child: Text('page 0'),
              //       ),
              //     ),
              //     TabItem(
              //       builder: (context, _) => TabView(
              //         builder: (context) => Center(
              //           child: Text(
              //             'page 1',
              //             style: Theme.of(context).textTheme.title,
              //           ),
              //         ),
              //       ),
              //       tabItemBuilder: (context, index, active) => Container(
              //         alignment: Alignment.center,
              //         color: TabScope.of(context)!.currentIndex == index
              //             ? Theme.of(context).colorScheme.background.toColor()
              //             : null,
              //         child: Text('page 1'),
              //       ),
              //     ),
              //     TabItem(
              //       builder: (context, _) => TabView(
              //         builder: (context) => Center(
              //           child: Text(
              //             'page 2',
              //             style: Theme.of(context).textTheme.title,
              //           ),
              //         ),
              //       ),
              //       tabItemBuilder: (context, index, active) => Container(
              //         alignment: Alignment.center,
              //         color: TabScope.of(context)!.currentIndex == index
              //             ? Theme.of(context).colorScheme.background.toColor()
              //             : null,
              //         child: Text('page 2'),
              //       ),
              //     ),
              //   ],
              // );
              return Tab(
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
              );
            },
            codeText: codeSample,
          ),
        ),
      ],
    );
  }
}
