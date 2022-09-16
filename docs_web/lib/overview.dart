import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defaults.dart';
import 'theme/primaryColor.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Defaults.createHeader(context, 'Overview'),
              Defaults.createTitle(context, 'Resources'),
            ],
          ),
        ),
        SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (Theme.of(context).brightness == Brightness.dark)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset(
                          'assets/GitHub-Mark-Light-32px.png',
                          width: 20.0,
                          height: 20.0,
                        ),
                      ),
                    if (Theme.of(context).brightness == Brightness.light)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset(
                          'assets/GitHub-Mark-32px.png',
                          width: 20.0,
                          height: 20.0,
                        ),
                      ),
                    HyperlinkButton(
                      'Homepage [Github]',
                      onPressed: (_) async {
                        await launchUrl(
                            Uri.parse('https://github.com/adrianos42/desktop'));
                      },
                    ),
                  ],
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
        ),
      ],
    );
  }
}
