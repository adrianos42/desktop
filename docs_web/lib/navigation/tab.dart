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
    return Column(
      children: [
        Defaults.createHeader(context, 'Tab'),
        Expanded(
          child: Container(
            decoration: Defaults.itemDecoration(context),
            child: Tab(
              items: [
                TabItem(
                  builder: (context) => Center(child: Text('page1')),
                  title: Text('page1'),
                ),
                TabItem(
                  builder: (context) => Center(child: Text('page2')),
                  title: Text('page2'),
                ),
                TabItem(
                  builder: (context) => Center(child: Text('page3')),
                  title: Text('page3'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
