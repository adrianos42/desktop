import 'dart:async';

import 'package:desktop/desktop.dart';
import 'package:flutter/services.dart';
import 'defaults.dart';

import 'dart:ui' show PointerDeviceKind;

const _kFileNames = [
  'pexels-3127729',
  'pexels-5456616',
  'pexels-4734723',
  'pexels-1828875',
  'pexels-979503',
  'pexels-1643457',
  'pexels-45170',
  'pexels-45201',
  'pexels-160755',
  'pexels-979247',
  'pexels-2693561',
  'pexels-2611939',
  'pexels-1687831',
  'pexels-4858815',
  'pexels-3030635',
  'pexels-720684',
  'pexels-479009',
  'pexels-192384',
  'pexels-1653357',
  'pexels-2817405',
  'pexels-3772262',
  'pexels-2255565',
  'pexels-1571724',
  'pexels-1416792',
  'pexels-4391733',
  'pexels-156321',
  'pexels-4411430',
  'pexels-96428',
  'pexels-1754986',
  'pexels-1299518',
  'pexels-5800065',
  'pexels-731553',
  'pexels-5044690',
  'pexels-1784289',
  'pexels-1770918',
  'pexels-104827',
];

const _kPageDuration = Duration(milliseconds: 200);
const _kPageCurve = Curves.easeOut;

class ScrollingPage extends StatefulWidget {
  const ScrollingPage({super.key});

  @override
  State<ScrollingPage> createState() => _ScrollingPageState();
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
    return Defaults(
      styleItems: Defaults.createStyle(ScrollbarTheme.of(context).toString()),
      header: 'Scrollbar',
      items: [
        ItemTitle(
          title: 'Vertical scrollbar',
          body: (context) => Padding(
            padding: const EdgeInsets.only(top: 12.0),
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

                      Dialog.showCustomDialog(
                        context,
                        barrierColor: themeData.colorScheme.background[0],
                        barrierDismissible: true,
                        builder: (context) {
                          return Theme(
                            data: themeData,
                            child: Builder(
                              builder: (context) => _ImagePage(
                                _kFileNames.indexOf(assetName),
                                close: () => Navigator.of(context).pop(),
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
                        'assets/cats_small/$assetName.webp',
                        frameBuilder: _frameBuilder,
                        fit: BoxFit.cover,
                      );
                    }),
                  );
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}

typedef RequestAssetNameCallback = String? Function(String);

class _ImagePage extends StatefulWidget {
  const _ImagePage(
    this.assetIndex, {
    this.requestNext,
    this.requestPrevious,
    required this.close,
    super.key,
  });

  final int assetIndex;

  final VoidCallback close;

  final RequestAssetNameCallback? requestNext;
  final RequestAssetNameCallback? requestPrevious;

  @override
  State<_ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<_ImagePage> with TickerProviderStateMixin {
  Timer? _fadeoutTimer;
  bool _offstage = false;
  bool _menuFocus = false;
  bool _initialMenuFocus = true;

  void _startFadeoutTimer(
      [Duration duration = const Duration(milliseconds: 2000)]) {
    _fadeoutTimer?.cancel();

    setState(() {
      _offstage = false;
      _fadeoutTimer = Timer(duration, () {
        setState(() => _fadeoutTimer = null);
      });
    });
  }

  late Map<Type, Action<Intent>> _actionMap;
  late Map<LogicalKeySet, Intent> _shortcutMap;

  void _requestPrevious() {
    _startFadeoutTimer();
    controller.previousPage(
      duration: _kPageDuration,
      curve: _kPageCurve,
    );
  }

  void _requestNext() {
    _startFadeoutTimer();
    controller.nextPage(
      duration: _kPageDuration,
      curve: _kPageCurve,
    );
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
            break;
        }
        return null;
      }),
    };

    _shortcutMap = <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.arrowLeft):
          const ScrollIntent(direction: AxisDirection.left),
      LogicalKeySet(LogicalKeyboardKey.arrowRight):
          const ScrollIntent(direction: AxisDirection.right),
    };

    controller = PageController(initialPage: widget.assetIndex);

    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      if (controller.hasClients) {
        setState(() {});
      }
    });

    controller.addListener(onChangedPage);
  }

  void onChangedPage() {
    if (controller.hasClients) {
      controller.removeListener(onChangedPage);
    }
  }

  @override
  void dispose() {
    _fadeoutTimer?.cancel();
    _fadeoutTimer = null;
    controller.dispose();
    super.dispose();
  }

  late PageController controller;

  bool? _canRequestPrevious;
  bool get canRequestPrevious =>
      _canRequestPrevious ??
      controller.hasClients && (controller.page?.toInt() ?? 0) > 0;

  bool? _canRequestNext;
  bool get canRequestNext =>
      _canRequestNext ??
      controller.hasClients &&
          (controller.page?.toInt() ?? _kFileNames.length) <
              _kFileNames.length - 1;

  String? _pageTitle;
  String get pageTitle =>
      _pageTitle ??
      (controller.hasClients ? _kFileNames[controller.page!.toInt()] : '');

  void _onPageChanged(int index) {
    setState(() {
      _pageTitle = _kFileNames[index];
      _canRequestNext = index < _kFileNames.length - 1;
      _canRequestPrevious = index > 0;

      if (_initialMenuFocus) {
        _startFadeoutTimer();
        _initialMenuFocus = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget result = MouseRegion(
      onHover: (event) {
        if (event.kind == PointerDeviceKind.mouse) {
          _startFadeoutTimer();
          if (_initialMenuFocus) {
            _initialMenuFocus = false;
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          _startFadeoutTimer();
          if (_initialMenuFocus) {
            _initialMenuFocus = false;
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              PageView.custom(
                controller: controller,
                onPageChanged: _onPageChanged,
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      color: const Color(0xFF000000),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/cats/${_kFileNames[index]}.webp',
                        frameBuilder: _frameBuilder,
                        fit: BoxFit.contain,
                        cacheHeight: constraints.maxHeight.toInt(),
                      ),
                    );
                  },
                  childCount: _kFileNames.length,
                ),
              ),
              Offstage(
                offstage: _offstage,
                child: AnimatedOpacity(
                  opacity:
                      _fadeoutTimer == null && !_menuFocus && !_initialMenuFocus
                          ? 0.0
                          : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve:
                      _fadeoutTimer == null && !_menuFocus && !_initialMenuFocus
                          ? Curves.easeOut
                          : Curves.easeIn,
                  onEnd: () => setState(
                    () => _offstage = _fadeoutTimer == null &&
                        !_menuFocus &&
                        !_initialMenuFocus,
                  ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  pageTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            if (widget.requestPrevious != null)
                              Button.icon(
                                Icons.keyboard_arrow_left,
                                onPressed: canRequestPrevious
                                    ? _requestPrevious
                                    : null,
                                tooltip: 'Previous',
                              ),
                            if (widget.requestNext != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Button.icon(
                                  Icons.keyboard_arrow_right,
                                  onPressed:
                                      canRequestNext ? _requestNext : null,
                                  tooltip: 'Next',
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 0, 16, 0),
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
    curve: Curves.easeOut,
    child: child,
  );
}
