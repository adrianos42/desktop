import 'dart:async';

import 'package:desktop/desktop.dart';
import 'defaults.dart';
import 'package:path/path.dart' show basenameWithoutExtension;

final _kFileNames = [
  'assets/cats/pexels-akbar-nemati-5622738.jpg',
  'assets/cats/pexels-aleksandr-nadyojin-4492149.jpg',
  'assets/cats/pexels-anete-lusina-4790622.jpg',
  'assets/cats/pexels-bianca-marolla-3030635.jpg',
  'assets/cats/pexels-christopher-schruff-720684.jpg',
  'assets/cats/pexels-danielle-daniel-479009.jpg',
  'assets/cats/pexels-david-savochka-192384.jpg',
  'assets/cats/pexels-dương-nhân-2817405.jpg',
  'assets/cats/pexels-emily-geibel-3772262.jpg',
  'assets/cats/pexels-emir-kaan-okutan-2255565.jpg',
  'assets/cats/pexels-engin-akyurt-1571724.jpg',
  'assets/cats/pexels-evg-culture-1416792.jpg',
  'assets/cats/pexels-faris-subriun-4391733.jpg',
  'assets/cats/pexels-flickr-156321.jpg',
  'assets/cats/pexels-fotografierende-3127729.jpg',
  'assets/cats/pexels-francesco-ungaro-96428.jpg',
  'assets/cats/pexels-halil-i̇brahim-çeti̇n-1754986.jpg',
  'assets/cats/pexels-hugo-zoccal-fernandes-laguna-1299518.jpg',
  'assets/cats/pexels-jan-kopřiva-5800065.jpg',
  'assets/cats/pexels-josé-andrés-pacheco-cortes-5456616.jpg',
  'assets/cats/pexels-leonardo-de-oliveira-1770918.jpg',
  'assets/cats/pexels-levent-simsek-4411430.jpg',
  'assets/cats/pexels-luan-oosthuizen-1784289.jpg',
  'assets/cats/pexels-mark-burnett-731553.jpg',
  'assets/cats/pexels-mati-mango-4734723.jpg',
  'assets/cats/pexels-matteo-petralli-1828875.jpg',
  'assets/cats/pexels-matthias-oben-5281143.jpg',
  'assets/cats/pexels-mustafa-ezz-979503.jpg',
  'assets/cats/pexels-peng-louis-1643457.jpg',
  'assets/cats/pexels-peng-louis-1653357.jpg',
  'assets/cats/pexels-piers-olphin-5044690.jpg',
  'assets/cats/pexels-pixabay-45170.jpg',
  'assets/cats/pexels-pixabay-45201.jpg',
  'assets/cats/pexels-pixabay-104827.jpg',
  'assets/cats/pexels-pixabay-160755.jpg',
  'assets/cats/pexels-pixabay-271611.jpg',
  'assets/cats/pexels-tamba-budiarsana-979247.jpg',
  'assets/cats/pexels-tomas-ryant-2693561.jpg',
  'assets/cats/pexels-utku-koylu-2611939.jpg',
  'assets/cats/pexels-xue-guangjian-1687831.jpg',
  'assets/cats/pexels-zhang-kaiyv-4858815.jpg',
  'assets/cats/pexels-александар-цветановић-1440406.jpg',
];

class ScrollingPage extends StatefulWidget {
  ScrollingPage({Key? key}) : super(key: key);

  @override
  _ScrollingPageState createState() => _ScrollingPageState();
}

class _ScrollingPageState extends State<ScrollingPage> {
  final controller = ScrollController();

  String? _requestPrevious(String name) {
    final index = _kFileNames.lastIndexOf(name) - 1;

    if (index >= 0) {
      return _kFileNames[index];
    } else {
      return null;
    }
  }

  String? _requestNext(String name) {
    final index = _kFileNames.lastIndexOf(name) + 1;

    if (index > 0 && index < _kFileNames.length) {
      return _kFileNames[index];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Scrolling'),
        Expanded(
          child: Scrollbar(
            controller: controller,
            child: GridView.custom(
              controller: controller,
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              childrenDelegate:
                  SliverChildListDelegate.fixed(_kFileNames.map((assetName) {
                return GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return _ImagePage(
                          assetName,
                          requestNext: _requestNext,
                          requestPrevious: _requestPrevious,
                        );
                      },
                    );
                  },
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Image.asset(
                      assetName,
                      frameBuilder: _frameBuilder,
                      fit: BoxFit.cover,
                      cacheWidth: constraints.maxWidth.toInt() * 2,
                    );
                  }),
                );
              }).toList()),
            ),
          ),
        ),
      ],
    );
  }
}

typedef RequestAssetNameCallback = String? Function(String);

class _ImagePage extends StatefulWidget {
  _ImagePage(
    this.assetName, {
    this.requestNext,
    this.requestPrevious,
    Key? key,
  }) : super(key: key);

  final String assetName;

  final RequestAssetNameCallback? requestNext;
  final RequestAssetNameCallback? requestPrevious;

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<_ImagePage> with TickerProviderStateMixin {
  Timer? _fadeoutTimer;
  bool firstBuild = true;
  bool offstage = false;
  bool menuFocus = false;

  void _startFadeoutTimer() {
    _fadeoutTimer?.cancel();

    setState(() {
      offstage = false;
      _fadeoutTimer = Timer(Duration(milliseconds: 1500), () {
        setState(() => _fadeoutTimer = null);
      });
    });
  }

  String? replaceAssetName;

  void _requestPrevious() {
    setState(() => replaceAssetName =
        widget.requestPrevious!(replaceAssetName ?? widget.assetName));
  }

  void _requestNext() {
    setState(() => replaceAssetName =
        widget.requestNext!(replaceAssetName ?? widget.assetName));
  }

  @override
  void dispose() {
    _fadeoutTimer?.cancel();
    _fadeoutTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FIXME Better way to do this?
    if (firstBuild) {
      _startFadeoutTimer();
      firstBuild = false;
    }

    final assetName = replaceAssetName ?? widget.assetName;

    final canRequestPrevious = widget.requestPrevious?.call(assetName) != null;
    final canRequestNext = widget.requestNext?.call(assetName) != null;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    Widget result = MouseRegion(
      onHover: (_) => _startFadeoutTimer(),
      child: Stack(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: constraints.maxHeight,
                color: Color(0x0),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    assetName,
                    frameBuilder: _frameBuilder,
                    fit: BoxFit.contain,
                    cacheHeight: constraints.maxHeight.toInt(),
                  ),
                ),
              ),
            );
          }),
          Offstage(
            offstage: offstage,
            child: AnimatedOpacity(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: colorScheme.background.withAlpha(0.9).toColor(),
                  height: 60.0,
                  child: MouseRegion(
                    onEnter: (_) => setState(() => menuFocus = true),
                    onExit: (_) => setState(() => menuFocus = false),
                    child: ButtonTheme.merge(
                      data: ButtonThemeData(
                        color: textTheme.textLow,
                        hoverColor: textTheme.textMedium,
                        highlightColor: textTheme.textHigh,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              basenameWithoutExtension(assetName),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      if (widget.requestPrevious != null)
                                        IconButton(
                                          Icons.navigate_before,
                                          onPressed: canRequestPrevious
                                              ? _requestPrevious
                                              : null,
                                          tooltip: 'Previous',
                                        ),
                                      if (widget.requestNext != null)
                                        IconButton(
                                          Icons.navigate_next,
                                          onPressed: canRequestNext
                                              ? _requestNext
                                              : null,
                                          tooltip: 'Next',
                                        ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  Icons.close,
                                  onPressed: () => Navigator.pop(context),
                                  tooltip: 'Close',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              opacity: _fadeoutTimer == null && !menuFocus ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: _fadeoutTimer == null && !menuFocus
                  ? Curves.easeOut
                  : Curves.easeIn,
              onEnd: () => setState(
                  () => offstage = _fadeoutTimer == null && !menuFocus),
              //curve: Curves.easeOutSine,
            ),
          ),
        ],
      ),
    );

    return Focus(
      child: result,
      autofocus: true,
    );
  }
}

Widget _frameBuilder(
  BuildContext context,
  Widget child,
  int? frame,
  bool wasSynchronouslyLoaded,
) {
  if (wasSynchronouslyLoaded) return child;
  return AnimatedOpacity(
    child: child,
    opacity: frame == null ? 0 : 1,
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOutSine,
  );
}
