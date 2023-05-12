import 'package:desktop/desktop.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defaults.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  Widget buildGithubIcon() {
    final brightness = Theme.brightnessOf(context);
    final assetsFile = brightness == Brightness.light
        ? 'assets/GitHub-Mark-32px.png'
        : 'assets/GitHub-Mark-Light-32px.png';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Image.asset(
        assetsFile,
        width: 16.0,
        height: 16.0,
      ),
    );
  }

  Widget buildPubIcon() {
    const assetsFile = 'assets/dart-logo.png';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Image.asset(
        assetsFile,
        width: 16.0,
        height: 16.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Defaults.createHeader(context, 'Overview'),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Button(
                      padding: EdgeInsets.zero,
                      body: Image.network(
                          'https://img.shields.io/pub/v/desktop.png'),
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse('https://pub.dev/packages/desktop'),
                        );
                      },
                    ),
                  ),
                  Defaults.createTitle(context, 'Resources'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildGithubIcon(),
                      HyperlinkButton(
                        'Homepage [Github]',
                        onPressed: (_) async {
                          await launchUrl(
                            Uri.parse(
                              'https://github.com/adrianos42/desktop',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Defaults.createTitle(context, 'Flutter resources'),
                  HyperlinkButton(
                    'Desktop support for Flutter',
                    onPressed: (_) async {
                      await launchUrl(
                        Uri.parse('https://flutter.dev/desktop'),
                      );
                    },
                  ),
                  HyperlinkButton(
                    'Build and release a Linux app',
                    onPressed: (_) async {
                      await launchUrl(
                        Uri.parse('https://flutter.dev/docs/deployment/linux'),
                      );
                    },
                  ),
                  HyperlinkButton(
                    'Build and release a web app',
                    onPressed: (_) async {
                      await launchUrl(
                        Uri.parse('https://flutter.dev/docs/deployment/web'),
                      );
                    },
                  ),
                  Defaults.createTitle(context, 'Other projects using Desktop'),
                  HyperlinkButton(
                    'Desktop Charts',
                    onPressed: (_) async {
                      await launchUrl(
                        Uri.parse('https://pub.dev/packages/desktop_charts'),
                      );
                    },
                  ),
                  HyperlinkButton(
                    'Desktop Charts [Github]',
                    onPressed: (_) async {
                      await launchUrl(
                        Uri.parse(
                            'https://github.com/adrianos42/desktop_charts'),
                      );
                    },
                  ),
                  HyperlinkButton(
                    'Sudoku [Github]',
                    onPressed: (_) async {
                      await launchUrl(
                        Uri.parse('https://github.com/adrianos42/sudoku'),
                      );
                    },
                  ),

                  // HyperlinkButton(
                  //   'Music',
                  //    await parse(Uri.dataFromString('https://github.com/adrianos42/music'));
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
