import 'dart:collection';
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../icons.dart';
import '../input/button.dart';
import '../theme/theme.dart';
import 'tab_view.dart';

/// Class for building nodes in a [Tree].
@immutable
class TreeNode {
  /// Creates a tree node with the page title, and child or children.
  const TreeNode._(
    this.titleBuilder, {
    this.builder,
    this.nodes,
  }) : assert((builder == null || nodes == null) &&
            (builder != null || nodes != null));

  /// Creates a node with a default text and a [Navigator] history.
  static TreeNode child(
    WidgetBuilder title, {
    WidgetBuilder? builder,
  }) {
    return TreeNode._(
      title,
      builder: builder,
    );
  }

  /// Creates a node with children and default text.
  static TreeNode children<T, N>(
    WidgetBuilder title, {
    N? name,
    bool hideColumnCollapsedIcon = false,
    required List<TreeNode> children,
  }) {
    return TreeNode._(
      hideColumnCollapsedIcon
          ? title
          : (context) => _TreeNodeTextCollapse(title),
      nodes: children,
    );
  }

  /// The children in a node.
  final List<TreeNode>? nodes;

  /// The child in the node.
  final WidgetBuilder? builder;

  /// The widget used in the node tree.
  final WidgetBuilder titleBuilder;

  /// If this node is collapsed, given a [BuildContext].
  static bool isCollapsed(BuildContext context) {
    final _TreeNodeCollapse? result =
        context.dependOnInheritedWidgetOfExactType<_TreeNodeCollapse>();
    if (result == null) {
      throw Exception('Must have a node with children in the tree.');
    }
    return result._collapsed;
  }
}

/// Context to see if the node is collapsed or not.
class _TreeNodeCollapse extends InheritedWidget {
  /// Creates a context for the tree node.
  const _TreeNodeCollapse(this._collapsed, {required Widget child, Key? key})
      : super(key: key, child: child);

  final bool _collapsed;

  @override
  bool updateShouldNotify(_TreeNodeCollapse oldWidget) =>
      _collapsed != oldWidget._collapsed;
}

class _TreeNodeTextCollapse extends StatelessWidget {
  const _TreeNodeTextCollapse(this.widgetBuilder);

  final WidgetBuilder widgetBuilder;

  @override
  Widget build(BuildContext context) {
    final iconCollpased =
        TreeNode.isCollapsed(context) ? Icons.expand_more : Icons.expand_less;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widgetBuilder(context),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(iconCollpased),
        )
      ],
    );
  }
}

/// Tree
///
/// ```dart
/// Tree(
///   title: Builder(
///     builder: (context) => Text(
///       'Tree',
///       style: Theme.of(context).textTheme.body2,
///     ),
///   ),
///   nodes: [
///     TreeNode(
///       'Node0',
///       builder: (context) => Text('Node0'),
///     ),
///     TreeNode('Node1', children: [
///       TreeNode(
///         'Node0',
///         builder: (context) => Text('Node0'),
///       ),
///       TreeNode(
///         'Node1',
///         builder: (context) => Text('Node1'),
///       ),
///       TreeNode(
///         'Node2',
///         builder: (context) => Text('Node2'),
///       ),
///       TreeNode('Node3', children: [
///         TreeNode(
///           'Node0',
///           builder: (context) => Text('Node0'),
///         ),
///         TreeNode(
///           'Node1',
///           builder: (context) => Text('Node1'),
///         ),
///       ]),
///     ]),
///     TreeNode(
///       'Node2',
///       builder: (context) => Text('Node2'),
///     ),
///     TreeNode('Node3', children: [
///       TreeNode(
///         'Node0',
///         builder: (context) => Text('Node0'),
///       ),
///       TreeNode(
///         'Node1',
///         builder: (context) => Text('Node1'),
///       ),
///     ]),
///   ],
/// )```
class Tree extends StatefulWidget {
  ///
  const Tree({
    this.title,
    required this.nodes,
    this.pagePadding,
    this.focusNode,
    this.autofocus = false,
    this.isScrollbarAlwaysShown = true,
    this.collapsed = false,
    this.showDraggingIndicator = true,
    Key? key,
  }) : super(key: key);

  /// The title above the tree.
  final Widget? title;

  /// Nodes used to create the tree.
  final List<TreeNode> nodes;

  /// Padding for the the page used in a node.
  final EdgeInsets? pagePadding;

  /// If the widget receives focus automatically.
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final bool isScrollbarAlwaysShown;

  /// If the tree is collapsed.
  final bool collapsed;

  /// If an indicator is shown when the tree is collapsed.
  final bool showDraggingIndicator;

  @override
  _TreeState createState() => _TreeState();

  static _TreeState? _of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TreeScope>()?.treeState;
}

class _BuildTreePage {
  _BuildTreePage({
    required this.builder,
    required this.focusScopeNode,
  });

  final WidgetBuilder builder;
  final FocusScopeNode focusScopeNode;
  bool shouldBuild = false;
}

class _TreeState extends State<Tree>
    with ComponentStateMixin, TickerProviderStateMixin {
  final _pages = HashMap<String, _BuildTreePage>();
  final List<FocusScopeNode> _disposedFocusNodes = <FocusScopeNode>[];
  String? _current;

  // FocusNode? _focusNode;
  // FocusNode get _effectiveFocusNode =>
  //     widget.focusNode ?? (_focusNode ??= FocusNode(skipTraversal: true));

  bool _visible = false;

  void setPage(String name) {
    setState(() => _current = name);
    _focusView();
  }

  void _handleHoverEntered() {
    if (!hovered) {
      _indicatorSizecontroller.animateTo(1.0,
          duration: const Duration(milliseconds: 120));
      setState(() => hovered = true);
    }
  }

  void _handleHoverExited() {
    if (hovered) {
      _indicatorSizecontroller.animateBack(_indicatorSizeFactor,
          duration: const Duration(milliseconds: 120));
      setState(() => hovered = false);
    }
  }

  double get _indicatorSizeFactor => _visible ? 0.25 : 0.5;

  double _xOffset = 0.0;
  double? _offset;

  void _onDragStart(DragStartDetails details) {
    return; // TODO(as): Implement dragging.
    if (details.kind == PointerDeviceKind.mouse) {
      setState(() {
        _offset = details.globalPosition.dx;
      });
    }
  }

  void _onDragCancel() {
    setState(() {
      _offset = null;
      _xOffset = 0.0;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_offset != null) {
      if (details.primaryVelocity != null) {}

      setState(() {
        _offset = null;
        _xOffset = 0.0;
      });
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_offset != null) {
      setState(() {
        _xOffset = details.globalPosition.dx - _offset!;
      });
    }
  }

  final ScrollController _controller = ScrollController();

  Widget _createTree(BuildContext context) {
    final List<_TreeColumn> children = List.empty(growable: true);

    for (var i = 0; i < widget.nodes.length; i += 1) {
      children.add(_TreeColumn(
        node: widget.nodes[i],
        parentName: '',
        name: i.toString(),
        updatePage: () {
          setState(
              () {}); // TODO(as): See scroll notification without rebuilding.
          //controller.position.;
        },
      ));
    }

    return Container(
      alignment: Alignment.topLeft,
      width: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Transform(
          transform: Matrix4.translationValues(_xOffset, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: widget.title!,
                ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late AnimationController _indicatorSizecontroller;
  late AnimationController _columnController;

  late CurvedAnimation _columnAnimation;

  void _createEntries(String previousName, String name, TreeNode node) {
    final nameResult = '$previousName/$name';

    if (node.nodes != null) {
      for (var i = 0; i < node.nodes!.length; i += 1) {
        _createEntries(nameResult, i.toString(), node.nodes![i]);
      }
    } else if (node.builder != null) {
      _pages[nameResult] = _BuildTreePage(
        builder: node.builder!,
        focusScopeNode: FocusScopeNode(
          skipTraversal: true,
          debugLabel: 'Tree $nameResult',
        ),
      );
    }
  }

  void _focusView() {
    if (_pages.containsKey(_current)) {
      FocusScope.of(context).setFirstFocus(_pages[_current]!.focusScopeNode);
    }
  }

  @override
  void didUpdateWidget(Tree oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldPages = HashMap.of(_pages);

    if (widget.nodes.isEmpty) {
      throw Exception('Nodes cannot be empty');
    }

    for (var i = 0; i < widget.nodes.length; i += 1) {
      _createEntries('', i.toString(), widget.nodes[i]);
    }

    oldPages.removeWhere((key, value) => _pages.containsKey(key));
    _disposedFocusNodes
        .addAll(oldPages.values.map((value) => value.focusScopeNode));

    //_focusView();

    if (oldWidget.collapsed != widget.collapsed) {
      if (widget.collapsed) {
        _columnController.animateBack(0.0);
      } else {
        _columnController.animateTo(1.0);
      }
    }
  }

  @override
  void dispose() {
    for (final value in _pages.values) {
      //value.focusScopeNode.dispose();
    }
    // for (final focusScopeNode in _disposedFocusNodes) {
    //   focusScopeNode.dispose();
    // }

    _indicatorSizecontroller.dispose();
    _columnController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.nodes.isEmpty) {
      throw Exception('Nodes cannot be empty');
    }

    for (var i = 0; i < widget.nodes.length; i += 1) {
      _createEntries('', i.toString(), widget.nodes[i]);
    }

    _indicatorSizecontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _indicatorSizeFactor,
    );

    _columnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      value: widget.collapsed ? 0.0 : 1.0,
    );

    _columnAnimation = CurvedAnimation(
      parent: _columnController,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_focusView();
  }

  @override
  Widget build(BuildContext context) {
    final pagesResult = List<Widget>.empty(growable: true);

    _current ??= '/0';

    for (final entry in _pages.entries) {
      final active = entry.key == _current!;
      entry.value.shouldBuild = active || entry.value.shouldBuild;

      pagesResult.add(
        Offstage(
          offstage: !active,
          child: TickerMode(
            enabled: active,
            child: Builder(
              builder: (context) {
                return entry.value.shouldBuild
                    ? Padding(
                        padding: widget.pagePadding ?? EdgeInsets.zero,
                        child: entry.value.builder(context),
                      )
                    : Container();
              },
            ),
          ),
        ),
      );
    }

    // pagesResult.add(
    //   Offstage(
    //     offstage: !widget.collapsed, // TODO(as):
    //     child: FadeTransition(
    //       //opacity: CurvedAnimation(parent: _controller, curve: Curves.linear),
    //       opacity: const AlwaysStoppedAnimation(1.0),
    //       child: GestureDetector(
    //         onTap: () => setState(() {
    //           if (_visible) {
    //             _columnController.reverse();
    //           } else {
    //             _columnController.forward();0
    //           }
    //           _visible = !_visible;
    //         }),
    //         onHorizontalDragStart: _onDragStart,
    //         onHorizontalDragCancel: _onDragCancel,
    //         onHorizontalDragEnd: _onDragEnd,
    //         onHorizontalDragUpdate: _onDragUpdate,
    //         child: MouseRegion(
    //           cursor: SystemMouseCursors.click,
    //           onEnter: (_) => _handleHoverEntered(),
    //           onExit: (_) => _handleHoverExited(),
    //           child: Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Container(
    //                 alignment: Alignment.centerLeft,
    //                 //constraints: const BoxConstraints.tightForFinite(width: 4),
    //                 color: hovered
    //                     ? Theme.of(context).textTheme.textHigh.toColor()
    //                     : Theme.of(context).colorScheme.primary[50].toColor(),
    //                 margin: const EdgeInsets.only(right: 8),
    //                 child: SizeTransition(
    //                   axis: Axis.horizontal,
    //                   sizeFactor: _indicatorSizecontroller,
    //                   child: const SizedBox(width: 4),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    Widget result;

    result = Row(
      children: [
        Offstage(
          offstage: widget.collapsed && _columnController.isCompleted,
          child: SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: _columnAnimation,
            child: _createTree(context),
          ),
        ),
        Expanded(
          child: Stack(fit: StackFit.expand, children: pagesResult),
        )
      ],
    );

    result = _TreeScope(
      child: result,
      treeState: this,
    );

    return result;

    // return FocusableActionDetector(
    //   child: result,
    //   focusNode: _effectiveFocusNode,
    //   autofocus: widget.autofocus,
    // );
  }
}

class _TreeScope extends InheritedWidget {
  const _TreeScope({
    Key? key,
    required this.treeState,
    required Widget child,
  }) : super(key: key, child: child);

  final _TreeState treeState;

  @override
  bool updateShouldNotify(_TreeScope old) => old.treeState != treeState;
}

class _TreeColumn extends StatefulWidget {
  const _TreeColumn({
    required this.node,
    required this.parentName,
    required this.name,
    required this.updatePage,
    Key? key,
  }) : super(key: key);

  final TreeNode node;
  final String parentName;
  final String name;
  final VoidCallback updatePage;

  @override
  _TreeColumnState createState() => _TreeColumnState();
}

class _TreeColumnState extends State<_TreeColumn> {
  bool _collapsed = true;

  String get name => '${widget.parentName}/${widget.name}';

  @override
  Widget build(BuildContext context) {
    final treeTheme = TreeTheme.of(context);

    if (widget.node.nodes != null) {
      final List<_TreeColumn> children = List.empty(growable: true);

      for (var i = 0; i < widget.node.nodes!.length; i += 1) {
        children.add(_TreeColumn(
          node: widget.node.nodes![i],
          parentName: name,
          name: i.toString(),
          updatePage: widget.updatePage,
        ));
      }

      final chidrenWidget = Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonTheme.merge(
            data: ButtonThemeData(
              color: treeTheme.color,
              hoverColor: treeTheme.hoverColor,
              highlightColor: treeTheme.highlightColor,
            ),
            child: Button(
              bodyPadding: EdgeInsets.zero,
              padding: const EdgeInsets.only(right: 64.0), // TODO(as): Width.
              body: _TreeNodeCollapse(
                _collapsed,
                child: widget.node.titleBuilder(context),
              ),
              onPressed: () {
                widget.updatePage();
                setState(() => _collapsed = !_collapsed);
              },
            ),
          ),
          Offstage(
            child: chidrenWidget,
            offstage: _collapsed,
          ),
        ],
      );
    } else {
      final active = Tree._of(context)!._current == name;
      final highlightColor = treeTheme.highlightColor;

      return Align(
        alignment: Alignment.centerLeft,
        child: ButtonTheme.merge(
          data: ButtonThemeData(
            color: treeTheme.color,
            highlightColor: highlightColor,
            //hoverColor: hoverColor,
            //focusColor: hoverColor,
          ),
          child: Button(
            padding: EdgeInsets.zero,
            bodyPadding: EdgeInsets.zero,
            body: widget.node.titleBuilder(context),
            active: active,
            onPressed: () {
              Tree._of(context)!.setPage(name);
            },
          ),
        ),
      );
    }
  }
}
