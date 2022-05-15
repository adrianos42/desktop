import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defaults.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

// final _controller = CodeTextCotroller();

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    // return TextField(
    //   controller: _controller,
    //   minLines: 1000,
    //   maxLines: null,
    // );

    return SingleChildScrollView(
      controller: ScrollController(),
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
                await launchUrl(
                    Uri.parse('https://github.com/adrianos42/desktop'));
              },
            ),
            Defaults.createTitle(context, 'Flutter resources'),
            HyperlinkButton(
              'Desktop support for Flutter',
              onPressed: (_) async {
                await launchUrl(Uri.parse('https://flutter.dev/desktop'));
              },
            ),
            HyperlinkButton(
              'Build and release a Linux app',
              onPressed: (_) async {
                await launchUrl(
                    Uri.parse('https://flutter.dev/docs/deployment/linux'));
              },
            ),
            HyperlinkButton(
              'Build and release a web app',
              onPressed: (_) async {
                await launchUrl(
                    Uri.parse('https://flutter.dev/docs/deployment/web'));
              },
            ),
            // Defaults.createTitle(context, 'Other projects using desktop'),
            // HyperlinkButton(
            //   'Music',
            //    await parse(Uri.dataFromString('https://github.com/adrianos42/music'));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
