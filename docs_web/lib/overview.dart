import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defaults.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Defaults.createHeader(context, 'Overview'),
            Defaults.createTitle(context, 'Resources'),
            HyperlinkButton(
              'Homepage',
              onPressed: (_) async {
                final link = 'https://github.com/adrianos42/desktop';
                if (await canLaunch(link)) {
                  await launch(link);
                }
              },
            ),
            // HyperlinkButton(
            //   'Figma',
            //   onPressed: (_) async {
            //     final link =
            //         'https://www.figma.com/file/WQCf5O9Jh7cLtOY4zRDL0U/Model?node-id=2%3A0';
            //     if (await canLaunch(link)) {
            //       await launch(link);
            //     }
            //   },
            // ),
            Defaults.createTitle(context, 'Flutter resources'),
            HyperlinkButton(
              'Desktop support for Flutter',
              onPressed: (_) async {
                final link = 'https://flutter.dev/desktop';
                if (await canLaunch(link)) {
                  await launch(link);
                }
              },
            ),
            HyperlinkButton(
              'Build and release a Linux app',
              onPressed: (_) async {
                final link = 'https://flutter.dev/docs/deployment/linux';
                if (await canLaunch(link)) {
                  await launch(link);
                }
              },
            ),
            HyperlinkButton(
              'Build and release a web app',
              onPressed: (_) async {
                final link = 'https://flutter.dev/docs/deployment/web';
                if (await canLaunch(link)) {
                  await launch(link);
                }
              },
            ),
            // Defaults.createTitle(context, 'Other projects using desktop'),
            // HyperlinkButton(
            //   'Music',
            //   onPressed: (_) async {
            //     final link = 'https://github.com/adrianos42/music';
            //     if (await canLaunch(link)) {
            //       await launch(link);
            //     }
            //   },
            // ),
            // HyperlinkButton(
            //   'Photos',
            //   onPressed: (_) async {
            //     final link = 'https://github.com/adrianos42/photos';
            //     if (await canLaunch(link)) {
            //       await launch(link);
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
