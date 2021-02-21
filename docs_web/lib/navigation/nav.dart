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
    final textController = TextEditingController(text: '''
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
)''');
    final controller = ScrollController();

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
              margin: EdgeInsets.symmetric(vertical: 4.0),
              constraints: BoxConstraints.tightFor(height: 600.0),
              child: Tab(
                items: [
                  TabItem(
                    builder: (context) => Container(
                      decoration: Defaults.itemDecoration(context),
                      child: Nav(
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
                    ),
                    title: Icon(Icons.visibility),
                  ),
                  TabItem(
                    builder: (context) => Container(
                      alignment: Alignment.topLeft,
                      //decoration: Defaults.itemDecoration(context),
                      child: TextField(
                        maxLines: 1000,
                        controller: textController,
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).textTheme.monospace,
                      ),
                    ),
                    title: Icon(Icons.code),
                  ),
                ],
              ),
            ),
            Defaults.createTitle(context, 'Horizontal example'),
            Container(
              decoration: Defaults.itemDecoration(context),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              constraints: BoxConstraints.tightFor(height: 600.0),
              child: Nav(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
