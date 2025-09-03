import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

const Duration _kToggleDuration = Duration(milliseconds: 120);
const Duration _kHoverDuration = Duration(milliseconds: 120);
const double _kStrokeWidth = 2.0;
const double _kOuterRadius = 7.0;
const double _kInnerRadius = 4.0;

const double _kContainerHeight = 32.0;
const double _kContainerWidth = 32.0;

///
class Radio<T> extends StatefulWidget {
  ///
  const Radio({
    super.key,
    this.mouseCursor,
    this.toggleable = false,
    this.focusNode,
    this.autofocus = false,
    this.enabled,
    this.groupRegistry,
    this.color,
    this.foregroundColor,
    required this.value,
  });

  final FocusNode? focusNode;

  final bool autofocus;

  final bool? enabled;

  final bool toggleable;

  final WidgetStateProperty<MouseCursor>? mouseCursor;

  final WidgetStateProperty<Color>? color;

  final WidgetStateProperty<Color>? foregroundColor;

  /// {@macro flutter.widget.RawRadio.value}
  final T value;

  /// {@macro flutter.widget.RawRadio.groupRegistry}
  ///
  /// Unless provided, the [BuildContext] will be used to look up the ancestor
  /// [RadioGroupRegistry].
  final RadioGroupRegistry<T>? groupRegistry;

  @override
  State<Radio<T>> createState() => _RadioState<T>();
}

class _RadioState<T> extends State<Radio<T>>
    with TickerProviderStateMixin, RadioClient<T> {
  late Map<Type, Action<Intent>> _actionMap;

  late CurvedAnimation _position;
  late CurvedAnimation _hoverPosition;
  late AnimationController _positionController;
  late AnimationController _hoverPositionController;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());
  FocusNode? _internalFocusNode;

  bool get _enabled => widget.enabled ?? _effectiveRegistry != null;

  RadioGroupRegistry<T>? get _effectiveRegistry =>
      widget.groupRegistry ?? RadioGroup.maybeOf<T>(context);

  bool _hovering = false;
  void _handleHoverChanged(bool hovering) {
    if (hovering != _hovering) {
      if (hovering || _focused) {
        _hoverPositionController.forward();
      } else {
        _hoverPositionController.reverse();
      }
      setState(() => _hovering = hovering);
    }
  }

  bool _focused = false;
  void _handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      if (focused || _hovering) {
        _hoverPositionController.forward();
      } else {
        _hoverPositionController.reverse();
      }
      setState(() => _focused = focused);
    }
  }

  void _handleTap([Intent? _]) {
    if (_enabled) {
      switch (value) {
        case false:
          onChanged!(true);
        case true:
          onChanged!(tristate ? null : false);
        case null:
          onChanged!(false);
      }

      context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
    }
  }

  void _animateToValue() {
    if (tristate) {
      if (value == null) {
        _positionController.value = 0.0;
      }
      if (value ?? true) {
        _positionController.forward();
      } else {
        _positionController.reverse();
      }
    } else {
      if (value ?? false) {
        _positionController.forward();
      } else {
        _positionController.reverse();
      }
    }
  }

  void _handleChanged(bool? selected) {
    assert(registry != null);
    if (!(selected ?? true)) {
      return;
    }
    if (selected ?? false) {
      registry!.onChanged(widget.value);
    } else {
      registry!.onChanged(null);
    }
  }

  ValueChanged<bool?>? get onChanged =>
      registry != null ? _handleChanged : null;

  Set<WidgetState> get states => <WidgetState>{
    if (!_enabled) WidgetState.disabled,
    if (_hovering) WidgetState.hovered,
    if (_focused) WidgetState.focused,
    if (value ?? true) WidgetState.selected,
  };

  bool? get value => widget.value == registry?.groupValue;

  @override
  T get radioValue => widget.value;

  @override
  FocusNode get focusNode => _effectiveFocusNode;

  @override
  bool get tristate => widget.toggleable;

  @override
  void initState() {
    super.initState();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction(onInvoke: _handleTap),
    };

    _hoverPositionController = AnimationController(
      duration: _kHoverDuration,
      value: 0.0,
      vsync: this,
    );

    _hoverPosition = CurvedAnimation(
      parent: _hoverPositionController,
      curve: Curves.linear,
    );

    _positionController = AnimationController(
      duration: _kToggleDuration,
      value: value == false ? 0.0 : 1.0,
      vsync: this,
    );

    _position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _positionController.dispose();
    _hoverPositionController.dispose();
    _internalFocusNode?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Radio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.groupRegistry != widget.groupRegistry) {
      registry = _effectiveRegistry;
    }

    _animateToValue();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    registry = _effectiveRegistry;

    _animateToValue();
  }

  WidgetStateProperty<Color> get _color =>
      WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        final RadioThemeData theme = RadioTheme.of(context);

        if (states.contains(WidgetState.disabled)) {
          return theme.disabledColor!;
        } else if (states.containsAll({WidgetState.hovered})) {
          return theme.hoverColor!;
        } else if (states.contains(WidgetState.selected)) {
          return theme.activeColor!;
        }

        return theme.inactiveColor!;
      });

  WidgetStateProperty<Color> get _foregroundColor =>
      WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        final RadioThemeData theme = RadioTheme.of(context);

        if (states.contains(WidgetState.disabled)) {
          return theme.disabledColor!;
        }

        return theme.foreground!;
      });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = (widget.color ?? _color).resolve(
      states.union({WidgetState.selected}).difference({WidgetState.hovered}),
    );
    final Color inactiveColor = (widget.color ?? _color).resolve(
      states.difference({WidgetState.selected, WidgetState.hovered}),
    );
    final Color hoverColor = (widget.color ?? _color).resolve(
      states.union({WidgetState.hovered}),
    );
    final Color foregroundColor = (widget.foregroundColor ?? _foregroundColor)
        .resolve(states);

    const Size size = Size.square(_kOuterRadius * 2.0);

    final BoxConstraints additionalConstraints = BoxConstraints.tight(size);

    final WidgetStateProperty<MouseCursor> effectiveMouseCursor =
        widget.mouseCursor ??
        WidgetStateProperty.resolveWith<MouseCursor>((Set<WidgetState> states) {
          return !states.contains(WidgetState.disabled)
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic;
        });

    return FocusableActionDetector(
      actions: _actionMap,
      focusNode: _effectiveFocusNode,
      autofocus: widget.autofocus,
      enabled: _enabled,
      onShowHoverHighlight: _handleHoverChanged,
      onShowFocusHighlight: _handleFocusHighlightChanged,
      mouseCursor: effectiveMouseCursor.resolve(states),
      child: GestureDetector(
        onTap: () => _handleTap(),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: _kContainerWidth,
          height: _kContainerHeight,
          child: Center(
            child: _RadioRenderObjectWidget(
              value: value,
              state: this,
              activeColor: activeColor,
              hoverColor: hoverColor,
              hovering: _hovering || _focused,
              inactiveColor: inactiveColor,
              onChanged: _enabled ? _handleChanged : null,
              foregroundColor: foregroundColor,
              additionalConstraints: additionalConstraints,
            ),
          ),
        ),
      ),
    );
  }
}

class _RadioRenderObjectWidget extends LeafRenderObjectWidget {
  const _RadioRenderObjectWidget({
    this.onChanged,
    required this.value,
    required this.state,
    required this.activeColor,
    required this.foregroundColor,
    required this.inactiveColor,
    required this.hoverColor,
    required this.hovering,
    required this.additionalConstraints,
  });

  final bool? value;
  final _RadioState state;
  final Color activeColor;
  final Color foregroundColor;
  final Color inactiveColor;
  final ValueChanged<bool?>? onChanged;
  final Color hoverColor;
  final bool hovering;
  final BoxConstraints additionalConstraints;

  @override
  _RenderRadio createRenderObject(BuildContext context) => _RenderRadio(
    value: value,
    state: state,
    activeColor: activeColor,
    foregroundColor: foregroundColor,
    inactiveColor: inactiveColor,
    onChanged: onChanged,
    hoverColor: hoverColor,
    hovering: hovering,
    additionalConstraints: additionalConstraints,
  );

  @override
  void updateRenderObject(BuildContext context, _RenderRadio renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..foregroundColor = foregroundColor
      ..inactiveColor = inactiveColor
      ..onChanged = onChanged
      ..hoverColor = hoverColor
      ..hovering = hovering
      ..additionalConstraints = additionalConstraints;
  }
}

class _RenderRadio extends RenderConstrainedBox {
  _RenderRadio({
    required bool? value,
    required _RadioState state,
    required Color activeColor,
    required Color foregroundColor,
    required Color inactiveColor,
    required Color hoverColor,
    required bool hovering,
    required super.additionalConstraints,
    ValueChanged<bool>? onChanged,
  }) : _state = state,
       _value = value,
       _activeColor = activeColor,
       _foregroundColor = foregroundColor,
       _inactiveColor = inactiveColor,
       _hoverColor = hoverColor,
       _hovering = hovering,
       _onChanged = onChanged;

  final _RadioState _state;

  bool? _value;
  bool? get value => _value;
  set value(bool? value) {
    if (value == _value) {
      return;
    }
    _value = value;
    markNeedsSemanticsUpdate();
  }

  Color _activeColor;
  Color get activeColor => _activeColor;
  set activeColor(Color value) {
    if (value == _activeColor) {
      return;
    }
    _activeColor = value;
    markNeedsPaint();
  }

  Color _foregroundColor;
  Color get foregroundColor => _foregroundColor;
  set foregroundColor(Color value) {
    if (value == _foregroundColor) {
      return;
    }
    _foregroundColor = value;
    markNeedsPaint();
  }

  Color _inactiveColor;
  Color get inactiveColor => _inactiveColor;
  set inactiveColor(Color value) {
    if (value == _inactiveColor) {
      return;
    }
    _inactiveColor = value;
    markNeedsPaint();
  }

  Color _hoverColor;
  Color get hoverColor => _hoverColor;
  set hoverColor(Color value) {
    if (value == _hoverColor) {
      return;
    }
    _hoverColor = value;
    markNeedsPaint();
  }

  // Color get focusColor => _focusColor;
  // Color _focusColor;
  // set focusColor(Color value) {
  //   if (value == _focusColor) {
  //     return;
  //   }
  //   _focusColor = value;
  //   markNeedsPaint();
  // }

  bool _hovering;
  bool get hovering => _hovering;
  set hovering(bool value) {
    if (value == _hovering) {
      return;
    }
    _hovering = value;
    markNeedsPaint();
  }

  ValueChanged<bool>? _onChanged;
  ValueChanged<bool>? get onChanged => _onChanged;
  set onChanged(ValueChanged<bool>? value) {
    if (value == _onChanged) {
      return;
    }
    final bool wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  bool get isInteractive => onChanged != null;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _state._hoverPositionController.addListener(markNeedsPaint);
    _state._positionController.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _state._hoverPositionController.removeListener(markNeedsPaint);
    _state._positionController.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  bool hitTestSelf(Offset position) => false;

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    if (isInteractive) {
      config.onTap = _state._handleTap;
    }

    config.isChecked = value == true;
    config.isEnabled = isInteractive;
  }

  Color _colorAt(double t) {
    final color = Color.lerp(inactiveColor, activeColor, t)!;

    if (hovering || _state._hoverPositionController.isAnimating) {
      return Color.lerp(color, hoverColor, _state._hoverPosition.value)!;
    }

    return color;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final Offset center = (offset & size).center;

    final Paint borderPaint = Paint()
      ..color = _colorAt(_state._position.value)
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kStrokeWidth;

    final Paint strokePaint = Paint()..color = foregroundColor;

    canvas.drawCircle(center, _kOuterRadius, borderPaint);

    if (!_state._position.isDismissed) {
      canvas.drawCircle(center, _kInnerRadius, strokePaint);
    }
  }
}
