import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../input/button.dart';
import '../theme/theme.dart';
import 'nav.dart';

class NavGroupVertical extends StatefulWidget {
  const NavGroupVertical({
    super.key,
    required this.navItems,
    required this.enabled,
    required this.index,
    required this.onChanged,
    required this.compact,
  });

  final int index;

  final List<NavItem> navItems;

  final bool enabled;

  final bool compact;

  final ValueChanged<int> onChanged;

  @override
  State<NavGroupVertical> createState() => _NavGroupVerticalState();
}

class _NavGroupVerticalState extends State<NavGroupVertical>
    with TickerProviderStateMixin {
  late List<double> itemLengths;

  @override
  void initState() {
    super.initState();
    itemLengths = List<double>.filled(
      widget.navItems.length,
      0.0,
      growable: true,
    );
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

      final double buttonHeight = navThemeData.height!;
      final EdgeInsets buttonBodyPadding = EdgeInsets.symmetric(
        horizontal: navThemeData.verticalItemSpacing!,
      );

      final double buttonWidth = navThemeData.width!;
      void onLayout(Size value) => itemLengths[index] = value.height;

      final TextStyle textStyle = textTheme.body2.copyWith(fontSize: 14.0);
      final IconThemeData iconThemeData = navThemeData.iconThemeData!;
      final Color color = textTheme.textLow;
      final hoverColor = colorScheme.shade[100];

      titleItems.add(
        _NavButtonItem(
          onLayout: onLayout,
          child: Button(
            filled: false,
            leading: widget.navItems[index].iconBuilder!(context),
            padding: buttonBodyPadding,
            bodyPadding: EdgeInsets.only(left: navThemeData.itemSpacing!),
            body: !widget.compact
                ? widget.navItems[index].titleBuilder != null
                      ? widget.navItems[index].titleBuilder!(context)
                      : Text(widget.navItems[index].title)
                : null,
            leadingPadding: EdgeInsets.zero,
            onPressed: enabled ? () => widget.onChanged(index) : null,
            theme: ButtonThemeData(
              color: active ? highlightColor : color,
              highlightColor: highlightColor,
              hoverColor: active ? highlightColor : hoverColor,
              textStyle: textStyle,
              iconThemeData: iconThemeData,
              height: buttonHeight,
              minWidth: buttonWidth,
              axis: Axis.horizontal,
            ),
            mainAxisAlignment: MainAxisAlignment.start,
            tooltip: widget.compact ? widget.navItems[index].title : null,
          ),
        ),
      );
    }

    final double renderIndicatorLength = navThemeData.indicatorWidth!;
    final double renderMainLength = itemLengths.reduce(
      (value, elem) => value + elem,
    );

    final double width = navThemeData.width!;
    final double renderHeight = renderMainLength;
    final double renderWidth = renderIndicatorLength;
    final double crossLenth = width;

    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: titleItems,
        ),
        _SideIconRenderObjectWidget(
          vsync: this,
          duration: navThemeData.animationDuration!,
          lengths: itemLengths,
          axis: Axis.vertical,
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
    );
  }
}

class NavGroupHorizontal extends StatefulWidget {
  const NavGroupHorizontal({
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
  State<NavGroupHorizontal> createState() => _NavGroupHorizontalState();
}

class _NavGroupHorizontalState extends State<NavGroupHorizontal>
    with TickerProviderStateMixin {
  late List<double> itemLengths;

  @override
  void initState() {
    super.initState();
    itemLengths = List<double>.filled(
      widget.navItems.length,
      0.0,
      growable: true,
    );
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
      );
      final EdgeInsets buttonBodyPadding = EdgeInsets.symmetric(
        horizontal: navThemeData.itemSpacing!,
      );
      final double buttonHeight = navThemeData.height!;
      void onLayout(Size value) => itemLengths[index] = value.width;

      final TextStyle textStyle = textTheme.body2.copyWith(fontSize: 14.0);
      final IconThemeData iconThemeData = navThemeData.iconThemeData!;
      final color = textTheme.textLow;
      final hoverColor = colorScheme.shade[100];

      titleItems.add(
        _NavButtonItem(
          onLayout: onLayout,
          child: Container(
            constraints: constraints,
            alignment: Alignment.center,
            child: Button(
              body: widget.navWidgets(context, index),
              padding: EdgeInsets.zero,
              bodyPadding: buttonBodyPadding,
              onPressed: enabled ? () => widget.onChanged(index) : null,
              theme: ButtonThemeData(
                color: active ? highlightColor : color,
                highlightColor: highlightColor,
                hoverColor: active ? highlightColor : hoverColor,
                textStyle: textStyle,
                iconThemeData: iconThemeData,
                height: buttonHeight,
                axis: Axis.horizontal,
              ),
            ),
          ),
        ),
      );
    }

    final double renderIndicatorLength = navThemeData.indicatorWidth!;
    final double renderMainLength = itemLengths.reduce(
      (value, elem) => value + elem,
    );

    final double height = navThemeData.height!;
    final double renderHeight = renderIndicatorLength;
    final double renderWidth = renderMainLength;
    final double crossLenth = height;
    final BoxConstraints constraints = BoxConstraints.tightFor(height: height);

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
            duration: navThemeData.animationDuration!,
            lengths: itemLengths,
            axis: Axis.horizontal,
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
  const _NavButtonItem({required this.onLayout, required super.child});

  final ValueChanged<Size> onLayout;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _NavButtonRenderItem(onLayout);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _NavButtonRenderItem renderObject,
  ) {
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
    required this.axis,
    required this.sideLength,
    required this.lengths,
    required this.crossLength,
  });

  final int index;
  final TickerProvider vsync;
  final BoxConstraints additionalConstraints;
  final Color foreground;
  final Duration duration;
  final Axis axis;
  final double sideLength;
  final double crossLength;
  final List<double> lengths;

  @override
  _RenderIconSide createRenderObject(BuildContext context) => _RenderIconSide(
    index: index,
    vsync: vsync,
    additionalConstraints: additionalConstraints,
    axis: axis,
    lengths: lengths,
    sideLength: sideLength,
    crossLength: crossLength,
    duration: duration,
    foreground: foreground,
  );

  @override
  void updateRenderObject(BuildContext context, _RenderIconSide renderObject) {
    renderObject
      ..index = index
      ..additionalConstraints = additionalConstraints
      ..foreground = foreground
      ..sideLength = sideLength
      ..axis = axis
      ..crossLength = crossLength
      ..lengths = lengths
      ..vsync = vsync;
  }
}

class _RenderIconSide extends RenderConstrainedBox {
  _RenderIconSide({
    required int index,
    required TickerProvider vsync,
    required Duration duration,
    required this.foreground,
    required this.sideLength,
    required this.axis,
    required this.crossLength,
    required this.lengths,
    required super.additionalConstraints,
  }) : _oldIndex = index,
       _index = index,
       _vsync = vsync {
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
  }

  int _oldIndex;
  int get oldIndex => _oldIndex;

  Color foreground;

  List<double> lengths;

  Axis axis;

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

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(index < lengths.length);
    assert(oldIndex < lengths.length);

    final Canvas canvas = context.canvas;
    final Paint paint = Paint()..color = foreground;

    Rect rectLast;
    Rect rectNew;

    final double lOldOffset = lengths
        .sublist(0, oldIndex)
        .fold(0.0, (value, elem) => value + elem);
    final double oldLength = lengths[oldIndex];

    final double lOffset = lengths
        .sublist(0, index)
        .fold(0.0, (value, elem) => value + elem);
    final double length = lengths[index];

    if (axis == Axis.horizontal) {
      final double dy = offset.dy + crossLength - sideLength;
      final double dx = offset.dx + lOffset;
      final double oldDx = offset.dx + lOldOffset;

      rectLast = Rect.fromLTWH(oldDx, dy, oldLength, sideLength);
      rectNew = Rect.fromLTWH(dx, dy, length, sideLength);
    } else {
      final double dx = offset.dx;
      final double dy = offset.dy + lOffset;
      final double oldDy = offset.dy + lOldOffset;

      rectLast = Rect.fromLTWH(dx, oldDy, sideLength, oldLength);
      rectNew = Rect.fromLTWH(dx, dy, sideLength, length);
    }

    final RectTween rectTween = RectTween(begin: rectLast, end: rectNew);

    canvas.drawRect(rectTween.lerp(position.value)!, paint);
  }
}

///
class NavMenuButton extends StatelessWidget {
  ///
  const NavMenuButton(
    this.child, {
    super.key,
    this.onPressed,
    required this.axis,
    required this.active,
    this.titleBuilder,
    this.title,
    this.onHover,
    this.onHoverEnd,
    this.compact = true,
    required this.enabled,
  });

  final Widget child;

  final String? title;

  final WidgetBuilder? titleBuilder;

  final VoidCallback? onPressed;

  final VoidCallback? onHover;

  final VoidCallback? onHoverEnd;

  final bool active;

  final bool compact;

  final Axis axis;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final NavThemeData navThemeData = NavTheme.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    final highlightColor = colorScheme.shade[100];

    final TextStyle textStyle = textTheme.body2.copyWith(fontSize: 14.0);
    final IconThemeData iconThemeData = navThemeData.iconThemeData!;
    final color = textTheme.textLow;
    final hoverColor = colorScheme.shade[100];

    final EdgeInsets buttonBodyPadding;
    final double buttonHeight;
    double? buttonWidth;

    if (axis == Axis.horizontal) {
      buttonBodyPadding = EdgeInsets.symmetric(
        horizontal: navThemeData.itemSpacing!,
      );
      buttonHeight = navThemeData.height!;
    } else {
      buttonBodyPadding = EdgeInsets.symmetric(
        horizontal: navThemeData.verticalItemSpacing!,
      );
      buttonHeight = navThemeData.width!;
      buttonWidth = navThemeData.width;
    }

    if (onHover != null) {
      final ButtonThemeData buttonTheme = ButtonTheme.of(context);
      final Color foreground = enabled
          ? (active ? highlightColor : color)
          : buttonTheme.disabledColor!;
      final TextStyle style = buttonTheme.textStyle!.copyWith(
        color: foreground,
      );

      return MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: enabled ? (_) => onHover!() : null,
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: () {},
          onLongPress: enabled ? () => onHover!() : null,
          onLongPressUp: enabled ? () => onHoverEnd!() : null,
          child: SizedBox(
            height: buttonHeight,
            child: Padding(
              padding: buttonBodyPadding,
              child: IconTheme(
                data: iconThemeData.copyWith(color: foreground),
                child: DefaultTextStyle(style: style, child: child),
              ),
            ),
          ),
        ),
      );
    } else {
      return Button(
        onPressed: enabled ? onPressed : null,
        filled: false,
        leading: child,
        padding: buttonBodyPadding,
        bodyPadding: EdgeInsets.only(left: navThemeData.itemSpacing!),
        body: !compact
            ? titleBuilder != null
                  ? titleBuilder!(context)
                  : title != null
                  ? Text(title!)
                  : null
            : null,
        tooltip: compact ? title : null,
        leadingPadding: EdgeInsets.zero,
        mainAxisAlignment: Axis.vertical == axis
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        theme: ButtonThemeData(
          color: active ? highlightColor : color,
          highlightColor: highlightColor,
          hoverColor: active ? highlightColor : hoverColor,
          textStyle: textStyle,
          iconThemeData: iconThemeData,
          height: buttonHeight,
          minWidth: buttonWidth,
          axis: flipAxis(axis),
        ),
      );
    }
  }
}

mixin NavMenuMixin {
  int menuIndex = -1;
  bool menuShown = false;
  OverlayEntry? menuOverlay;

  Animation<double>? menuAnimation;
  AnimationController? menuController;
  late Tween<Offset> menuOffsetTween;
  final ColorTween menuColorTween = ColorTween();

  void hideMenu() {
    if (menuIndex != -1) {
      menuController!.reverse();
      menuShown = false;
    }
  }

  Duration get menuTransitionDuration;
  Curve get menuTransitionCurve;
  Color get navBarBackgroundColor;
  Color get barrierColor;
  OverlayState get overlay;

  void showMenu(
    int index, {
    required AxisDirection axis,
    required List<WidgetBuilder> builders,
    required bool isInfoMenu,
  }) {
    if (menuController!.isAnimating && isInfoMenu) {
      menuIndex = index;

      if (menuController!.status == AnimationStatus.reverse) {
        menuController!.forward();
        menuShown = true;
      }

      return;
    }

    if (menuIndex == -1) {
      menuIndex = index;

      menuColorTween.begin = barrierColor.withValues(alpha: 0.0);
      menuColorTween.end = barrierColor.withValues(alpha: 0.8);

      final (Alignment alignment, Offset begin, Offset end) = switch (axis) {
        AxisDirection.left => (
          Alignment.centerLeft,
          const Offset(-1.0, 0.0),
          const Offset(0.0, 0.0),
        ),
        AxisDirection.right => (
          Alignment.centerRight,
          const Offset(1.0, 0.0),
          const Offset(0.0, 0.0),
        ),
        AxisDirection.up => (
          Alignment.topCenter,
          const Offset(0.0, -1.0),
          const Offset(0.0, 0.0),
        ),
        AxisDirection.down => (
          Alignment.bottomCenter,
          const Offset(0.0, 1.0),
          const Offset(0.0, 0.0),
        ),
      };

      menuOffsetTween = Tween<Offset>(begin: begin, end: end);

      menuOverlay = OverlayEntry(
        maintainState: false,
        builder: (context) => AnimatedBuilder(
          animation: menuAnimation!,
          builder: (context, _) {
            final Axis direction =
                axis == AxisDirection.up || axis == AxisDirection.down
                ? Axis.horizontal
                : Axis.vertical;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: hideMenu,
              child: Container(
                alignment: alignment,
                color: menuColorTween.evaluate(menuAnimation!),
                child: MouseRegion(
                  onExit: isInfoMenu ? (event) => hideMenu() : null,
                  child: GestureDetector(
                    behavior: HitTestBehavior.deferToChild,
                    onTap: () {},
                    child: ClipRect(
                      child: FractionalTranslation(
                        translation: menuOffsetTween.evaluate(menuAnimation!),
                        child: Container(
                          width: direction == Axis.vertical
                              ? null
                              : double.infinity,
                          height: direction == Axis.horizontal
                              ? null
                              : double.infinity,
                          color: navBarBackgroundColor,
                          child: AnimatedSize(
                            duration: menuTransitionDuration,
                            curve: menuTransitionCurve,
                            child: builders[menuIndex](context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

      menuController!.forward(from: 0.0);
      overlay.insert(menuOverlay!);
      menuShown = true;
    } else if (menuIndex == index) {
      hideMenu();
    } else {
      menuIndex = index;
    }
  }
}
