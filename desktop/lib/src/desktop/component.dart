enum ComponentState {
  hovered,
  focused,
  pressed,
  dragged,
  selected,
  disabled,
  waiting,
  error,
}

mixin ComponentStateMixin {
  final Set<ComponentState> states = <ComponentState>{};

  void _updateState(ComponentState state, bool value) {
    value ? states.add(state) : states.remove(state);
  }

  bool get hovered => states.contains(ComponentState.hovered);
  set hovered(bool value) => _updateState(ComponentState.hovered, value);
  bool get focused => states.contains(ComponentState.focused);
  set focused(bool value) => _updateState(ComponentState.focused, value);
  bool get pressed => states.contains(ComponentState.pressed);    
  set pressed(bool value) => _updateState(ComponentState.pressed, value);
  bool get dragged => states.contains(ComponentState.dragged);    
  set dragged(bool value) => _updateState(ComponentState.dragged, value);
  bool get waiting => states.contains(ComponentState.waiting);
  set waiting(bool value) => _updateState(ComponentState.waiting, value);
}

