import 'package:desktop/desktop.dart';

import '../defaults.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  late PageController controller;

  Widget buildPage(BuildContext context, int index) {
    return _MainPage(index, () {});
  }

  Widget buildItem(BuildContext context, int index) {
    return Text('page $index');
  }

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(
      text: '''
''',
    );

    return Defaults(
      styleItems: Defaults.createStyle(BreadcrumbTheme.of(context).toString()),
      items: [
        ItemTitle(
          body: (context) => NavBar(
            controller: controller,
            items: [
              NavBarItem(
                title: 'history',
                builder: (context) => Container(
                  alignment: Alignment.center,
                  child: Text('history'),
                ),
              ),
              NavBarItem(
                title: 'speed dial',
                builder: (context) => Container(
                  alignment: Alignment.center,
                  child: Text('speed dial'),
                ),
              ),
              NavBarItem(
                title: 'setings',
                builder: (context) => Container(
                  alignment: Alignment.center,
                  child: Text('settings'),
                ),
              ),
              NavBarItem(
                title: 'usage',
                builder: (context) => Container(
                  alignment: Alignment.center,
                  child: Text('usage'),
                ),
              ),
            ],
          ),
          codeText: textController.text,
          title: 'Basic example',
        ),
      ],
      header: 'NavBar',
    );
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage(this.count, this.pushPage);

  final int count;

  final VoidCallback pushPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Defaults.createSubheader(context, 'Page $count'),
        ),
        Expanded(
          child: Center(child: Button.text('Next page', onPressed: pushPage)),
        ),
      ],
    );
  }
}
