import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../input/button.dart';
import '../theme/theme.dart';

import 'nav.dart';

/// Nav Group
class NavBottomGroup extends StatefulWidget {
  ///
  const NavBottomGroup({
    super.key,
    required this.navItems,
    required this.enabled,
    required this.index,
    required this.onChanged,
    required this.navWidgets,
  });

  final int index;

  final List<NavItem> navItems;

  final IndexedWidgetBuilder navWidgets;

  final bool enabled;

  final ValueChanged<int> onChanged;

  @override
  State<NavBottomGroup> createState() => _NavBottomGroupState();
}

class _NavBottomGroupState extends State<NavBottomGroup>
    with TickerProviderStateMixin {
  late List<double> itemLengths;

  @override
  void initState() {
    super.initState();
    itemLengths =
        List<double>.filled(widget.navItems.length, 0.0, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    final titleItems = List<Widget>.empty(growable: true);

    final NavThemeData navThemeData = NavTheme.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    final bool enabled = widget.enabled;
    final highlightColor = colorScheme.shade[100];

    for (int index = 0; index < widget.navItems.length; index++) {
      final bool active = widget.index == index;

      final BoxConstraints constraints = BoxConstraints.tightFor(
        height: navThemeData.height,
        //  width: navThemeData.height,
      );
      final EdgeInsets buttonBodyPadding = EdgeInsets.symmetric(
        horizontal: navThemeData.itemsSpacing!,
      );
      final double buttonHeight = navThemeData.height!;
      double? buttonWidth;

      final TextStyle textStyle = textTheme.body2.copyWith(fontSize: 14.0);
      final IconThemeData iconThemeData = navThemeData.iconThemeData!;
      final color = textTheme.textLow;
      final hoverColor = textTheme.textHigh;

      titleItems.add(
        _NavButtonItem(
          onLayout: (Size value) => itemLengths[index] = value.width,
          button: Container(
            constraints: constraints,
            alignment: Alignment.center,
            child: ButtonTheme(
              data: ButtonThemeData(
                color: active ? highlightColor : color,
                highlightColor: highlightColor,
                hoverColor: active ? highlightColor : hoverColor,
                textStyle: textStyle,
                iconThemeData: iconThemeData,
                height: buttonHeight,
                minWidth: buttonWidth,
              ),
              child: Button(
                body: widget.navWidgets(context, index),
                padding: EdgeInsets.zero,
                bodyPadding: buttonBodyPadding,
                onPressed: enabled ? () => widget.onChanged(index) : null,
                //tooltip: navItem.title,
              ),
            ),
          ),
        ),
      );
    }

    final double renderIndicatorLength = navThemeData.indicatorWidth!;
    final double renderMainLength =
        itemLengths.reduce((value, elem) => value + elem);

    double renderHeight;
    double renderWidth;
    double crossLenth;
    BoxConstraints constraints;

    final height = navThemeData.height;
    crossLenth = height!;
    renderHeight = renderIndicatorLength;
    renderWidth = renderMainLength;
    constraints = BoxConstraints.tightFor(height: height);

    return Container(
      constraints: constraints,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: titleItems,
          ),
          _SideIconRenderObjectWidget(
            vsync: this,
            text: widget.navItems.map((e) => e.title).toList(),
            duration: navThemeData.animationDuration!,
            lengths: itemLengths,
            crossLength: crossLenth,
            sideLength: navThemeData.indicatorWidth!,
            additionalConstraints: BoxConstraints.tightFor(
              height: renderHeight,
              width: renderWidth,
            ),
            index: widget.index,
            foreground: enabled ? highlightColor : colorScheme.disabled,
          ),
        ],
      ),
    );
  }
}

class _NavButtonItem extends SingleChildRenderObjectWidget {
  const _NavButtonItem({
    required this.onLayout,
    required this.button,
  }) : super(child: button);

  final ValueChanged<Size> onLayout;
  final Widget button;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _NavButtonRenderItem(onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _NavButtonRenderItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _NavButtonRenderItem extends RenderProxyBox {
  _NavButtonRenderItem(this.onLayout);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}

class _SideIconRenderObjectWidget extends LeafRenderObjectWidget {
  const _SideIconRenderObjectWidget({
    required this.index,
    required this.vsync,
    required this.additionalConstraints,
    required this.foreground,
    required this.duration,
    required this.sideLength,
    required this.lengths,
    required this.crossLength,
    required this.text,
  });

  final int index;
  final TickerProvider vsync;
  final BoxConstraints additionalConstraints;
  final Color foreground;
  final Duration duration;
  final double sideLength;
  final double crossLength;
  final List<double> lengths;
  final List<String> text;

  @override
  _RenderIconSide createRenderObject(BuildContext context) => _RenderIconSide(
        index: index,
        vsync: vsync,
        additionalConstraints: additionalConstraints,
        lengths: lengths,
        sideLength: sideLength,
        crossLength: crossLength,
        duration: duration,
        foreground: foreground,
        text: text,
      );

  @override
  void updateRenderObject(BuildContext context, _RenderIconSide renderObject) {
    renderObject
      ..index = index
      ..additionalConstraints = additionalConstraints
      ..foreground = foreground
      ..sideLength = sideLength
      ..crossLength = crossLength
      ..lengths = lengths
      ..vsync = vsync
      ..text = text;
  }
}

class _RenderIconSide extends RenderConstrainedBox {
  _RenderIconSide({
    required int index,
    required TickerProvider vsync,
    required Duration duration,
    required List<String> text,
    required this.foreground,
    required this.sideLength,
    required this.crossLength,
    required this.lengths,
    required super.additionalConstraints,
  })  : _oldIndex = index,
        _index = index,
        _vsync = vsync,
        _text = text {
    _positionController = AnimationController(
      duration: duration,
      value: 0.0,
      vsync: vsync,
    );

    _position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.easeOutQuad,
    )..addListener(markNeedsPaint);
    //..addStatusListener(_handlePositionStateChanged);
  }

  List<String> _text;
  set text(List<String> value) {
    _text = value;
  }

  int get index => _index;
  int _index;
  set index(int value) {
    if (value == _index) {
      return;
    }
    _oldIndex = _index;
    _index = value;

    markNeedsSemanticsUpdate();

    _positionController.value = 0.0;

    _position.curve = Curves.easeOut;

    _positionController.forward();

    _textPainter.text = TextSpan(
      text: _text[index],
      style: const TextStyle(
        color: Color(0xffffffff),
      ),
    );
  }

  int _oldIndex;
  int get oldIndex => _oldIndex;

  Color foreground;

  List<double> lengths;

  double sideLength;

  double crossLength;

  TickerProvider get vsync => _vsync;
  TickerProvider _vsync;
  set vsync(TickerProvider value) {
    if (value == _vsync) {
      return;
    }
    _vsync = value;
    positionController.resync(vsync);
  }

  AnimationController get positionController => _positionController;
  late AnimationController _positionController;

  CurvedAnimation get position => _position;
  late CurvedAnimation _position;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);

    _positionController.forward();
  }

  @override
  void detach() {
    _positionController.stop();
    super.detach();
  }

  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    text: const TextSpan(text: ''),
  );

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(index < lengths.length);
    assert(oldIndex < lengths.length);

    final Canvas canvas = context.canvas;
    final Paint paint = Paint()..color = foreground;

    Rect rectLast;
    Rect rectNew;

    final double lOldOffset =
        lengths.sublist(0, oldIndex).fold(0.0, (value, elem) => value + elem);
    final double oldLength = lengths[oldIndex];

    final double lOffset =
        lengths.sublist(0, index).fold(0.0, (value, elem) => value + elem);
    final double length = lengths[index];

    final double dy = offset.dy + crossLength - sideLength;
    final double dx = offset.dx + lOffset;
    final double oldDx = offset.dx + lOldOffset;

    rectLast = Rect.fromLTWH(oldDx, dy, oldLength, sideLength);
    rectNew = Rect.fromLTWH(dx, dy, length, sideLength);

    final RectTween rectTween = RectTween(begin: rectLast, end: rectNew);

    canvas.drawRect(rectTween.lerp(position.value)!, paint);
    // _textPainter.layout();
    // _textPainter.paint(canvas,
    //     Offset(_rectTween.lerp(position.value)!.left + 8.0, offset.dy + 24));
  }
}

///
class BottomNavMenuButton extends StatelessWidget {
  ///
  const BottomNavMenuButton(
    this.icon, {
    super.key,
    this.tooltip,
    this.onPressed,
    required this.active,
    required this.height,
  });

  final String? tooltip;

  final VoidCallback? onPressed;

  final bool active;

  final double height;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonThemeData = ButtonTheme.of(context);
    final NavThemeData navThemeData = NavTheme.of(context);
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    final Color highlightColor = colorScheme.shade[100];

    final IconThemeData iconThemeData =
        navThemeData.iconThemeData!.copyWith(size: 24.0);
    final Color color = buttonThemeData.highlightColor!;

    return Container(
      height: height,
      alignment: Alignment.topRight,
      child: ButtonTheme.merge(
        data: ButtonThemeData(
          color: active ? highlightColor : color,
          highlightColor: highlightColor,
          hoverColor: active ? highlightColor : highlightColor,
          iconThemeData: iconThemeData,
          height: 0.0,
        ),
        child: Button.icon(
          icon,
          onPressed: onPressed,
          tooltip: tooltip,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
