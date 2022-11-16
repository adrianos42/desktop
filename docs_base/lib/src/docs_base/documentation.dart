import 'package:desktop/desktop.dart';
import 'package:dart_style/dart_style.dart';
import 'dart:math' as math;

import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/widgets.dart';

import '../defaults/defaults.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:path/path.dart' as path;

class _ResolveImageTypeHttp {
  const _ResolveImageTypeHttp(this.type, this.result);

  final String type;
  final Uint8List result;
}

class MarkdownImage extends StatelessWidget {
  const MarkdownImage(
    this.url, {
    this.imageDirectory,
    this.title,
    this.alternative,
  });

  final String url;

  final String? alternative;

  final String? title;

  static String _resolveTypeFromMimeType(String mimeType) {
    switch (mimeType) {
      case 'image/svg+xml':
        return 'svg';
      case 'image/webp':
      case 'image/jpeg':
      case 'image/png':
      case 'image/gif':
        return 'any';
      default:
        throw 'Invalid data type';
    }
  }

  static Future<_ResolveImageTypeHttp> _resolveNetworkImage(Uri uri) async {
    final HttpClient httpClient = HttpClient();
    final HttpClientRequest request = await httpClient.getUrl(uri);

    final HttpClientResponse response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException('Could not get network asset', uri: uri);
    }

    return _ResolveImageTypeHttp(
        _resolveTypeFromMimeType(response.headers.contentType!.mimeType),
        await consolidateHttpClientResponseBytes(response));
  }

  ///
  final String? imageDirectory;

  Widget _errorBuilder() {
    if (title != null || alternative != null) {
      return Text(title ?? alternative!);
    } else {
      return const Icon(Icons.image_not_supported);
    }
  }

  Widget _getNetworkImage(Uri uri) {
    if (path.extension(uri.path) == '.svg') {
      return SvgPicture.network(
        uri.toString(),
        placeholderBuilder: (context) => _errorBuilder(),
      );
    } else {
      return Image.network(
        uri.toString(),
        errorBuilder: (context, _, __) => _errorBuilder(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(url);

    if (uri.scheme == 'https') {
      return _getNetworkImage(uri);
    } else if (uri.scheme == 'data') {
      if (_resolveTypeFromMimeType(uri.data!.mimeType) == 'svg') {
        return SvgPicture.memory(uri.data!.contentAsBytes());
      } else {
        return Image.memory(
          uri.data!.contentAsBytes(),
          errorBuilder: (context, _, __) => _errorBuilder(),
        );
      }
    } else if (uri.scheme.isEmpty) {
      if (path.extension(uri.path) == '.svg') {
        return SvgPicture.asset(
          uri.path,
          placeholderBuilder: (context) => _errorBuilder(),
        );
      } else {
        return Image.asset(
          uri.path,
          errorBuilder: (context, _, __) => _errorBuilder(),
        );
      }
    } else {
      return const SizedBox();
    }
  }
}

/// The button used in text for links.
class LinkButton extends StatefulWidget {
  /// Creates a [LinkButton].
  const LinkButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.style,
  }) : super(key: key);

  /// Called when button is pressed.
  final VoidCallback onPressed;

  /// The button text.
  final TextSpan text;

  ///
  final TextStyle style;

  @override
  _LinkButtonState createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton>
    with ComponentStateMixin, SingleTickerProviderStateMixin {
  void _handleHoverEntered() {
    if (!hovered && !_globalPointerDown) {
      hovered = true;
      _updateColor();
    }
  }

  void _handleHoverExited() {
    if (hovered) {
      hovered = false;
      _updateColor();
    }
  }

  void _handleHover() {
    if (!hovered && !pressed && !_globalPointerDown) {
      hovered = true;
      _updateColor();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (pressed) {
      pressed = false;
      _updateColor();
    }
  }

  void _handleTapDown(TapDownDetails event) {
    if (!pressed) {
      pressed = true;
      _updateColor();
    }
  }

  void _handleTapCancel() {
    pressed = false;
    hovered = false;
    _updateColor();
  }

  bool _globalPointerDown = false;

  void _mouseRoute(PointerEvent event) {
    _globalPointerDown = event.down;
  }

  late AnimationController _controller;

  ColorTween? _color;

  void _handleTap() => widget.onPressed();

  void _updateColor() {
    if (mounted) {
      final TextTheme textTheme = Theme.of(context).textTheme;

      final Color foregroundColor;

      final Color pressedForeground = textTheme.textLow;

      final Color enabledForeground = textTheme.textPrimaryHigh;

      final Color hoveredForeground = textTheme.textHigh;

      foregroundColor = pressed
          ? pressedForeground
          : hovered
              ? hoveredForeground
              : enabledForeground;

      final bool wasPressed = pressed;
      final bool wasHovered = hovered;

      if (_controller.isAnimating) {
        return;
      }
      _color = ColorTween(
        begin: _color?.end ?? foregroundColor,
        end: foregroundColor,
      );

      _controller.forward(from: 0.0).then((_) {
        if (wasPressed != pressed || wasHovered != hovered) {
          _updateColor();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      value: 1.0,
    );

    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(_mouseRoute);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);

    _controller.duration = buttonThemeData.animationDuration;

    if (_color == null) {
      _updateColor();
    }

    Widget result = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final Color? foreground =
            _color!.evaluate(AlwaysStoppedAnimation(_controller.value));

        final TextStyle textStyle = widget.style.copyWith(
          color: foreground,
        );

        return Text.rich(
          widget.text,
          style: textStyle,
        );
      },
    );

    result = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _handleHoverEntered(),
      onExit: (_) => _handleHoverExited(),
      onHover: (event) {
        if (event.kind == PointerDeviceKind.mouse) {
          _handleHover();
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: _handleTap,
        child: result,
      ),
    );

    return result;
  }
}

///
class Documentation extends StatefulWidget {
  ///
  const Documentation({
    super.key,
  });

  ///
  static BoxDecoration itemDecoration(BuildContext context) => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.background[20],
            width: 1.0,
          ),
        ),
      );

  ///
  static Widget createConstructors(BuildContext context, List<String> names) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 8.0),
          child: Text(
            'Constructors',
            style: Theme.of(context).textTheme.subheader,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ...names
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text.rich(
                  CodeTextController(text: e).buildTextSpan(
                    context: context,
                    withComposing: false,
                  ),
                ),
              ),
            )
            .toList()
      ],
    );
  }

  ///
  static Widget createHeader(
      BuildContext context, String name, String docType) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text.rich(
        TextSpan(
          children: [
            CodeTextController(text: name).buildTextSpan(
              context: context,
              withComposing: false,
              style: textTheme.header.copyWith(
                fontFamily: textTheme.monospace.fontFamily,
              ),
            ),
            TextSpan(
              text: ' $docType',
              style: textTheme.header.copyWith(
                color: textTheme.textMedium,
              ),
            ),
          ],
        ),
        style: textTheme.header,
      ),
    );
  }

  ///
  static Widget createSubheader(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subheader,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  ///
  static Widget createSection(
      BuildContext context, String section, Widget child) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text(
              section,
              style: Theme.of(context).textTheme.subheader,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          child,
        ],
      ),
    );
  }

  ///
  static Widget createTitle(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 8.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.title,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  ///
  static Widget createSubtitle(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 4.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.subtitle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  ///
  static Widget createCaption(BuildContext context, String name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
      child: Text(
        name,
        style: Theme.of(context).textTheme.caption,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  DocumentationState createState() => DocumentationState();
}

///
class DocumentationState extends State<Documentation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }
}
