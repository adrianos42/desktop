import 'package:flutter/widgets.dart';

mixin ComponentStateMixin {
  final Set<WidgetState> states = <WidgetState>{};

  void _updateState(WidgetState state, bool value) {
    value ? states.add(state) : states.remove(state);
  }

  bool get hovered => states.contains(WidgetState.hovered);
  set hovered(bool value) => _updateState(WidgetState.hovered, value);
  
  bool get focused => states.contains(WidgetState.focused);
  set focused(bool value) => _updateState(WidgetState.focused, value);
  
  bool get pressed => states.contains(WidgetState.pressed);
  set pressed(bool value) => _updateState(WidgetState.pressed, value);
  
  bool get dragged => states.contains(WidgetState.dragged);
  set dragged(bool value) => _updateState(WidgetState.dragged, value);
  
  bool get selected => states.contains(WidgetState.selected);
  set selected(bool value) => _updateState(WidgetState.selected, value);

  bool get error => states.contains(WidgetState.error);
  set error(bool value) => _updateState(WidgetState.error, value);
}
