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
    return Column(
      children: [
        Defaults.createHeader(context, 'Nav'),
        Defaults.createTitle(context, 'Tab example'),
        Expanded(
          child: Container(
            decoration: Defaults.itemDecoration(context),
            margin: EdgeInsets.symmetric(vertical: 4.0),
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
                    icon: Icons.stars),
                NavItem(
                    builder: (context) => Center(child: Text('page3')),
                    title: 'page3',
                    route: '/page3',
                    icon: Icons.share),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
