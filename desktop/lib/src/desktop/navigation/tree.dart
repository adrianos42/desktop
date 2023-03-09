import 'dart:collection';
import 'dart:ui' show PointerDeviceKind;
import 'dart:math' as math;

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
  static TreeNode child({
    required WidgetBuilder titleBuilder,
    WidgetBuilder? builder,
  }) {
    return TreeNode._(
      titleBuilder,
      builder: builder,
    );
  }

  /// Creates a node with children and default text.
  static TreeNode children({
    required WidgetBuilder titleBuilder,
    bool hideColumnCollapsedIcon = false,
    required List<TreeNode> children,
  }) {
    return TreeNode._(
      hideColumnCollapsedIcon
          ? titleBuilder
          : (context) => _TreeNodeTextCollapse(titleBuilder),
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
  const _TreeNodeCollapse(this._collapsed, {super.key, required super.child});

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
    this.isScrollbarAlwaysShown = true,
    this.collapsed = false,
    this.showDraggingIndicator = true,
    this.allowDragging = false,
    super.key,
  });

  /// The title above the tree.
  final Widget? title;

  /// Nodes used to create the tree.
  final List<TreeNode> nodes;

  /// Padding for the the page used in a node.
  final EdgeInsets? pagePadding;

  ///
  final bool isScrollbarAlwaysShown;

  /// If the tree is collapsed.
  final bool collapsed;

  /// If an indicator is shown when the tree is collapsed.
  final bool showDraggingIndicator;

  /// If the tree can be resized.
  final bool allowDragging;

  @override
  _TreeState createState() => _TreeState();

  static _TreeState? _of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TreeScope>()?.treeState;
}

class _BuildTreePage {
  _BuildTreePage({
    required this.builder,
  });

  final WidgetBuilder builder;
  bool shouldBuild = false;
}

class _TreeState extends State<Tree>
    with ComponentStateMixin, TickerProviderStateMixin {
  final _pages = HashMap<String, _BuildTreePage>();
  String? _current;

  final GlobalKey _stackKey = GlobalKey();

  void setPage(String name) {
    setState(() => _current = name);
  }

  void _handleHoverMoved() {
    if (!hovered && !_globalPointerDown) {
      _indicatorSizecontroller.animateTo(1.0);
      setState(() => hovered = true);
    }
  }

  void _handleHoverExited() {
    if (hovered) {
      if (!dragged) {
        _indicatorSizecontroller.animateBack(_indicatorSizeFactor);
      }

      setState(() => hovered = false);
    }
  }

  double get _indicatorSizeFactor => 0.5;

  double? _initialColumnWidth;
  double _previoutColumnWidth = 0.0;
  double get initialColumnWidth => _initialColumnWidth ??= 200.0;

  double? _offset;
  double? _totalWidth;

  void _onDragStart(DragStartDetails details) {
    if (!widget.collapsed) {
      setState(() {
        dragged = true;
        _previoutColumnWidth = initialColumnWidth;

        if (details.kind == PointerDeviceKind.mouse) {
          _offset = details.globalPosition.dx;
        }
      });
    }
  }

  void _onDragCancel() {
    setState(() {
      dragged = false;
      _offset = null;

      if (!hovered) {
        _indicatorSizecontroller.animateBack(_indicatorSizeFactor);
      }
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_offset != null) {
      if (details.primaryVelocity != null) {}

      setState(() {
        _offset = null;
      });
    }

    setState(() {
      dragged = false;

      if (!hovered) {
        _indicatorSizecontroller.animateBack(_indicatorSizeFactor);
      }
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_offset != null) {
      setState(() {
        final double delta = details.globalPosition.dx - _offset!;
        _initialColumnWidth = math.max(
            math.min(_previoutColumnWidth + delta,
                (_totalWidth ?? double.infinity) - 200.0),
            200.0);
      });
    }
  }

  final ScrollController _controller = ScrollController();

  Widget _createTree(BuildContext context) {
    final List<Widget> children = List.empty(growable: true);

    if (widget.title != null) {
      children.add(widget.title!);
    }

    for (var i = 0; i < widget.nodes.length; i += 1) {
      children.add(_TreeColumn(
        node: widget.nodes[i],
        parentName: '',
        name: '$i',
        updatePage: () {
          setState(() {});
        },
      ));
    }

    return Container(
      alignment: Alignment.topLeft,
      width: initialColumnWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
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
        _createEntries(nameResult, '$i', node.nodes![i]);
      }
    } else if (node.builder != null) {
      _pages[nameResult] = _BuildTreePage(builder: node.builder!);
    }
  }

  bool _globalPointerDown = false;

  void _mouseRoute(PointerEvent event) {
    _globalPointerDown = event.down;
  }

  @override
  void didUpdateWidget(Tree oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.nodes.isEmpty) {
      throw Exception('Nodes cannot be empty');
    }

    if (oldWidget.nodes != widget.nodes) {
      for (var i = 0; i < widget.nodes.length; i += 1) {
        _createEntries('', '$i', widget.nodes[i]);
      }
    }

    if (oldWidget.collapsed != widget.collapsed) {
      if (widget.collapsed) {
        _columnController.animateBack(0.0);
      } else {
        _columnController.animateTo(1.0);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.nodes.isEmpty) {
      throw Exception('Nodes cannot be empty');
    }

    for (var i = 0; i < widget.nodes.length; i += 1) {
      _createEntries('', '$i', widget.nodes[i]);
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

    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void dispose() {
    _indicatorSizecontroller.dispose();
    _columnController.dispose();
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(_mouseRoute);

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final pagesResult = List<Widget>.empty(growable: true);

      _current ??= '/0';
      _totalWidth = constraints.maxWidth;

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

      if (widget.allowDragging) {
        pagesResult.add(
          Offstage(
            offstage: widget.collapsed,
            child: Align(
              alignment: Alignment.topLeft,
              child: FadeTransition(
                //opacity: CurvedAnimation(parent: _controller, curve: Curves.linear),
                opacity: const AlwaysStoppedAnimation(1.0),
                child: GestureDetector(
                  onHorizontalDragStart: _onDragStart,
                  onHorizontalDragCancel: _onDragCancel,
                  onHorizontalDragEnd: _onDragEnd,
                  onHorizontalDragUpdate: _onDragUpdate,
                  child: MouseRegion(
                    cursor: !hovered && !dragged
                        ? MouseCursor.defer
                        : SystemMouseCursors.resizeColumn,
                    onEnter: (_) => _handleHoverMoved(),
                    onHover: (_) => _handleHoverMoved(),
                    onExit: (_) => _handleHoverExited(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      constraints: const BoxConstraints(maxWidth: 2.0),
                      margin: const EdgeInsets.only(right: 4.0),
                      child: SizeTransition(
                        axis: Axis.horizontal,
                        sizeFactor: _indicatorSizecontroller,
                        child: Container(
                          width: 2.0,
                          color: widget.collapsed || dragged
                              ? Theme.of(context).colorScheme.primary[50]
                              : hovered
                                  ? Theme.of(context).textTheme.textHigh
                                  : Theme.of(context)
                                      .colorScheme
                                      .background[20],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }

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
            child: Stack(
              key: _stackKey,
              fit: StackFit.expand,
              children: pagesResult,
            ),
          )
        ],
      );

      result = _TreeScope(
        child: result,
        treeState: this,
      );

      return result;
    });
  }
}

class _TreeScope extends InheritedWidget {
  const _TreeScope({
    required this.treeState,
    required super.child,
    super.key,
  });

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
    super.key,
  });

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
          name: '$i',
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
          Button(
            bodyPadding: EdgeInsets.zero,
            theme: ButtonThemeData(
              color: treeTheme.color,
              hoverColor: treeTheme.hoverColor,
              highlightColor: treeTheme.highlightColor,
            ),
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
        child: Button(
          theme: ButtonThemeData(
            color: highlightColor,
            highlightColor: treeTheme.color,
          ),
          padding: EdgeInsets.zero,
          bodyPadding: EdgeInsets.zero,
          body: widget.node.titleBuilder(context),
          active: active,
          onPressed: () {
            Tree._of(context)!.setPage(name);
          },
        ),
      );
    }
  }
}
