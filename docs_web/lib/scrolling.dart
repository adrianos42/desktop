import 'dart:async';

import 'dart:ui' show PointerDeviceKind;
import 'package:desktop/desktop.dart';
import 'package:flutter/services.dart';
import 'defaults.dart';

final _kFileNames = [
  'pexels-anete-lusina-4790622',
  'pexels-bianca-marolla-3030635',
  'pexels-christopher-schruff-720684',
  'pexels-danielle-daniel-479009',
  'pexels-david-savochka-192384',
  'pexels-akbar-nemati-5622738',
  'pexels-dương-nhân-2817405',
  'pexels-emily-geibel-3772262',
  'pexels-emir-kaan-okutan-2255565',
  'pexels-engin-akyurt-1571724',
  'pexels-evg-culture-1416792',
  'pexels-faris-subriun-4391733',
  'pexels-flickr-156321',
  'pexels-fotografierende-3127729',
  'pexels-francesco-ungaro-96428',
  'pexels-halil-i̇brahim-çeti̇n-1754986',
  'pexels-hugo-zoccal-fernandes-laguna-1299518',
  'pexels-jan-kopřiva-5800065',
  'pexels-josé-andrés-pacheco-cortes-5456616',
  'pexels-leonardo-de-oliveira-1770918',
  'pexels-levent-simsek-4411430',
  'pexels-luan-oosthuizen-1784289',
  'pexels-mark-burnett-731553',
  'pexels-mati-mango-4734723',
  'pexels-matteo-petralli-1828875',
  'pexels-matthias-oben-5281143',
  'pexels-mustafa-ezz-979503',
  'pexels-peng-louis-1643457',
  'pexels-peng-louis-1653357',
  'pexels-piers-olphin-5044690',
  'pexels-pixabay-45170',
  'pexels-pixabay-45201',
  'pexels-pixabay-104827',
  'pexels-pixabay-160755',
  'pexels-pixabay-271611',
  'pexels-tamba-budiarsana-979247',
  'pexels-tomas-ryant-2693561',
  'pexels-utku-koylu-2611939',
  'pexels-xue-guangjian-1687831',
  'pexels-zhang-kaiyv-4858815',
  'pexels-александар-цветановић-1440406',
  'pexels-aleksandr-nadyojin-4492149',
];

class ScrollingPage extends StatefulWidget {
  ScrollingPage({Key? key}) : super(key: key);

  @override
  _ScrollingPageState createState() => _ScrollingPageState();
}

class _ScrollingPageState extends State<ScrollingPage> {
  String? _requestPrevious(String name) {
    final lastIndex = _kFileNames.indexOf(name);

    if (lastIndex >= 0) {
      final index = lastIndex - 1;

      if (index >= 0 && index < _kFileNames.length) {
        return _kFileNames[index];
      }
    }

    return null;
  }

  String? _requestNext(String name) {
    final lastIndex = _kFileNames.indexOf(name);

    if (lastIndex >= 0) {
      final index = lastIndex + 1;

      if (index >= 0 && index < _kFileNames.length) {
        return _kFileNames[index];
      }
    }

    return null;
  }

  final ScrollController _controler = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Defaults.createHeader(context, 'Scrolling'),
        ),
        Expanded(
          child: GridView.custom(
            controller: _controler,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            childrenDelegate: SliverChildListDelegate.fixed(
              _kFileNames.map((assetName) {
                return GestureDetector(
                  onTap: () async {
                    // TODO(as): Create a merge instead.
                    final themeData = ThemeData.dark();

                    late DialogController dialogController;
                    dialogController = showDialog(
                      context,
                      barrierColor: themeData.colorScheme.background[0],
                      dismissible: true,
                      builder: (context) {
                        return Theme(
                          data: themeData,
                          child: Builder(
                            builder: (context) => _ImagePage(
                              assetName,
                              close: () => dialogController.close(),
                              requestNext: _requestNext,
                              requestPrevious: _requestPrevious,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Image.asset(
                      'assets/cats_small/$assetName.jpg',
                      frameBuilder: _frameBuilder,
                      fit: BoxFit.cover,
                    );
                  }),
                );
              }).toList(),
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
    required this.close,
    Key? key,
  }) : super(key: key);

  final String assetName;

  final VoidCallback close;

  final RequestAssetNameCallback? requestNext;
  final RequestAssetNameCallback? requestPrevious;

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<_ImagePage> with TickerProviderStateMixin {
  Timer? _fadeoutTimer;
  bool _offstage = false;
  bool _menuFocus = true;

  void _startFadeoutTimer() {
    _fadeoutTimer?.cancel();

    setState(() {
      _offstage = false;
      _fadeoutTimer = Timer(const Duration(milliseconds: 2000), () {
        setState(() => _fadeoutTimer = null);
      });
    });
  }

  String? _replaceAssetName;

  late Map<Type, Action<Intent>> _actionMap;
  late Map<LogicalKeySet, Intent> _shortcutMap;

  void _requestPrevious() {
    final replace =
        widget.requestPrevious!(_replaceAssetName ?? widget.assetName);
    if (replace != null) {
      setState(() {
        _menuFocus = true;
        _replaceAssetName = replace;
      });
    }
  }

  void _requestNext() {
    final replace = widget.requestNext!(_replaceAssetName ?? widget.assetName);
    if (replace != null) {
      setState(() {
        _menuFocus = true;
        _replaceAssetName = replace;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _actionMap = <Type, Action<Intent>>{
      ScrollIntent: CallbackAction<ScrollIntent>(onInvoke: (action) {
        switch (action.direction) {
          case AxisDirection.left:
            if (widget.requestPrevious != null) _requestPrevious();
            break;
          case AxisDirection.right:
            if (widget.requestNext != null) _requestNext();
            break;
          default:
        }
      }),
    };

    _shortcutMap = <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.arrowLeft):
          const ScrollIntent(direction: AxisDirection.left),
      LogicalKeySet(LogicalKeyboardKey.arrowRight):
          const ScrollIntent(direction: AxisDirection.right),
    };
  }

  @override
  void dispose() {
    _fadeoutTimer?.cancel();
    _fadeoutTimer = null;
    super.dispose();
  }

  double _xOffset = 0.0;
  double? _offset;

  void onDragStart(DragStartDetails details) {
    if (details.kind == PointerDeviceKind.touch) {
      setState(() {
        _menuFocus = false;
        _offset = details.globalPosition.dx;
      });
    }
  }

  void onDragCancel() {
    setState(() {
      _offset = null;
      _xOffset = 0.0;
    });
  }

  void onDragEnd(DragEndDetails details) {
    if (_offset != null) {
      // TODO(as): Calculate proper velocity.
      if (details.primaryVelocity != null) {
        final assetName = _replaceAssetName ?? widget.assetName;

        final canRequestPrevious =
            widget.requestPrevious?.call(assetName) != null;
        final canRequestNext = widget.requestNext?.call(assetName) != null;

        if (details.primaryVelocity! < 0.0 && _xOffset < -40.0) {
          if (canRequestNext) {
            _requestNext();
          }
        } else if (details.primaryVelocity! > 0.0 && _xOffset > 40.0) {
          if (canRequestPrevious) {
            _requestPrevious();
          }
        }
      }

      setState(() {
        _offset = null;
        _xOffset = 0.0;
      });
    }
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (_offset != null) {
      setState(() {
        _xOffset = details.globalPosition.dx - _offset!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final assetName = _replaceAssetName ?? widget.assetName;

    final canRequestPrevious = widget.requestPrevious?.call(assetName) != null;
    final canRequestNext = widget.requestNext?.call(assetName) != null;

    final colorScheme = Theme.of(context).colorScheme;

    Widget result = MouseRegion(
      onHover: (_) => _startFadeoutTimer(),
      child: GestureDetector(
        onTap: () => _startFadeoutTimer(),
        onHorizontalDragStart: onDragStart,
        onHorizontalDragCancel: onDragCancel,
        onHorizontalDragEnd: onDragEnd,
        onHorizontalDragUpdate: onDragUpdate,
        child: Stack(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight,
                color: const Color(0xFF000000),
                alignment: Alignment.center,
                child: Transform(
                  transform: Matrix4.translationValues(_xOffset, 0.0, 0.0),
                  child: Image.asset(
                    'assets/cats/$assetName.jpg',
                    frameBuilder: _frameBuilder,
                    fit: BoxFit.contain,
                    cacheHeight: constraints.maxHeight.toInt(),
                  ),
                ),
              );
            }),
            Offstage(
              offstage: _offstage,
              child: AnimatedOpacity(
                opacity: _fadeoutTimer == null && !_menuFocus ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: _fadeoutTimer == null && !_menuFocus
                    ? Curves.easeOut
                    : Curves.easeIn,
                onEnd: () => setState(
                    () => _offstage = _fadeoutTimer == null && !_menuFocus),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: colorScheme.background[0].withAlpha(0xE6),
                    height: 60.0,
                    child: MouseRegion(
                      onEnter: (_) => setState(() => _menuFocus = true),
                      onExit: (_) => setState(() => _menuFocus = false),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                assetName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          if (widget.requestPrevious != null)
                            Button.icon(
                              Icons.navigate_before,
                              onPressed:
                                  canRequestPrevious ? _requestPrevious : null,
                              tooltip: 'Previous',
                            ),
                          if (widget.requestNext != null)
                            Button.icon(
                              Icons.navigate_next,
                              onPressed: canRequestNext ? _requestNext : null,
                              tooltip: 'Next',
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Button.icon(
                              Icons.close,
                              onPressed: widget.close,
                              tooltip: 'Close',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //curve: Curves.easeOutSine,
              ),
            ),
          ],
        ),
      ),
    );

    return FocusableActionDetector(
      autofocus: true,
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: result,
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
    opacity: frame == null ? 0 : 1,
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOutSine,
    child: child,
  );
}
