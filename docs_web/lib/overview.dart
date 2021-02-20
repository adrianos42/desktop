import 'package:desktop/desktop.dart';
import 'package:url_launcher/url_launcher.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Overview',
              style: Theme.of(context).textTheme.header,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    style: Theme.of(context).textTheme.body1.copyWith(),
                    text: '   Flutter wigdets for desktop usage'),
                WidgetSpan(
                  child: HyperlinkButton(
                    'https://www.figma.com/file/WQCf5O9Jh7cLtOY4zRDL0U/Model?node-id=2%3A0',
                    onPressed: (link) async {
                      if (await canLaunch(link)) {
                        await launch(link);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
