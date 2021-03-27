import 'package:desktop/desktop.dart';
import '../defaults.dart';

class NavPage extends StatefulWidget {
  NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    final codeSample = '''
Nav(
  items: [
    NavItem(
      builder: (context) => Center(child: Text('page1')),
      title: 'page1',
      icon: Icons.today,
      route: '/page1',
    ),
    NavItem(
      builder: (context) => Center(child: Text('page2')),
      title: 'page2',
      route: '/page2',
      icon: Icons.stars,
    ),
    NavItem(
      builder: (context) => Center(child: Text('page3')),
      title: 'page3',
      route: '/page3',
      icon: Icons.share,
    ),
  ],
)''';

    final codeHorizontalSample = '''
Nav(
  navAxis: Axis.horizontal,
  items: [
    NavItem(
      builder: (context) => Center(child: Text('page1')),
      title: 'page1',
      icon: Icons.today,
      route: '/page1',
    ),
    NavItem(
      builder: (context) => Center(child: Text('page2')),
      title: 'page2',
      route: '/page2',
      icon: Icons.stars,
    ),
    NavItem(
      builder: (context) => Center(child: Text('page3')),
      title: 'page3',
      route: '/page3',
      icon: Icons.share,
    ),
  ],
)''';

    return Scrollbar(
      controller: controller,
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Defaults.createHeader(context, 'Nav'),
            Defaults.createTitle(context, 'Vertical example'),
            Container(
              constraints: BoxConstraints.tightFor(height: 600.0),
              child: Defaults.createCodeSession(
                context,
                builder: (context) => Nav(
                  trailingMenu: [
                    NavItem(
                      title: 'settings',
                      route: '/settings',
                      builder: (context) => NavDialog(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(32.0),
                          child: Text('Settings page'),
                        ),
                      ),
                      icon: Icons.settings,
                    ),
                  ],
                  items: [
                    NavItem(
                      builder: (context) => Center(child: Text('page1')),
                      title: 'page1',
                      icon: Icons.today,
                      route: '/page1',
                    ),
                    NavItem(
                      builder: (context) => Center(child: Text('page2')),
                      title: 'page2',
                      route: '/page2',
                      icon: Icons.stars,
                    ),
                    NavItem(
                      builder: (context) => Center(child: Text('page3')),
                      title: 'page3',
                      route: '/page3',
                      icon: Icons.share,
                    ),
                  ],
                ),
                codeText: codeSample,
              ),
            ),
            Defaults.createTitle(context, 'Horizontal example'),
            Container(
              constraints: BoxConstraints.tightFor(height: 600.0),
              child: Defaults.createCodeSession(
                context,
                builder: (context) => Nav(
                  navAxis: Axis.horizontal,
                  trailingMenu: [
                    NavItem(
                      title: 'settings',
                      route: '/settings',
                      builder: (context) => NavDialog(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(32.0),
                          child: Text('Settings page'),
                        ),
                      ),
                      icon: Icons.settings,
                    ),
                  ],
                  items: [
                    NavItem(
                      builder: (context) => Center(child: Text('page1')),
                      title: 'page1',
                      icon: Icons.today,
                      route: '/page1',
                    ),
                    NavItem(
                      builder: (context) => Center(child: Text('page2')),
                      title: 'page2',
                      route: '/page2',
                      icon: Icons.stars,
                    ),
                    NavItem(
                      builder: (context) => Center(child: Text('page3')),
                      title: 'page3',
                      route: '/page3',
                      icon: Icons.share,
                    ),
                  ],
                ),
                codeText: codeHorizontalSample,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
