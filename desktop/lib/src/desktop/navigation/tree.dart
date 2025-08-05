import 'dart:collection';
import 'dart:math' show min, max;

import 'package:collection/collection.dart' show ListEquality;
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../component.dart';
import '../icons.dart';
import '../input/button.dart';
import '../theme/theme.dart';

const double _kTreeWidth = 220.0;
const double _kMinDragWidth = 120.0;

/// Class for building nodes in a [Tree].
@immutable
class TreeNode {
  /// Creates a tree node with the page title, and child or children.
  const TreeNode._(this.titleBuilder, {this.builder, this.nodes})
    : assert(
        (builder == null || nodes == null) &&
            (builder != null || nodes != null),
      );

  /// Creates a node.
  static TreeNode child({
    required WidgetBuilder titleBuilder,
    required WidgetBuilder builder,
  }) {
    return TreeNode._(titleBuilder, builder: builder);
  }

  /// Creates a node with children.
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
    final _TreeNodeCollapse? result = context
        .dependOnInheritedWidgetOfExactType<_TreeNodeCollapse>();
    if (result == null) {
      throw Exception('Must have a node with children in the tree.');
    }
    return result._collapsed;
  }
}

/// Controls the tree index.
/// It uses a list of indexes, so that it can set the node index.
/// The first indexes are for the parent nodes, and last index is for the child node.
/// For example, the tree:
///
/// Page
/// Menus
///     Home
///     Profile
///         User
///     Search
/// Settings
///
/// the list [1, 1, 0] would set the User page.
class TreeController extends ChangeNotifier {
  /// Creates a [TreeController].
  TreeController({List<int>? initialIndex}) : _index = initialIndex;

  bool _isDisposed = false;

  /// The index of the currently selected tab.
  List<int> get index => _index ?? [];
  List<int>? _index;
  set index(List<int> value) {
    if (!const ListEquality<int>().equals(_index, value)) {
      _index = value;
      notifyListeners();
    }
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}

/// Context to see if the node is collapsed or not.
class _TreeNodeCollapse extends InheritedWidget {
  /// Creates a context for the tree node.
  const _TreeNodeCollapse(this._collapsed, {required super.child});

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
    final iconCollpased = TreeNode.isCollapsed(context)
        ? Icons.expandMore
        : Icons.expandLess;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widgetBuilder(context),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(iconCollpased),
        ),
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
    this.allowResizing = false,
    this.showAsDialog = false,
    this.dismissWhenSelected = false,
    this.onTreeCollapsed,
    this.controller,
    this.minWidth,
    super.key,
  }) : assert(
         !showAsDialog || !allowResizing,
         'Tree cannot be resized when shown as a dialog',
       ),
       assert(
         !showAsDialog || onTreeCollapsed != null,
         'Visibity callback mut not be null',
       );

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
  final bool allowResizing;

  // The initial tree width.
  final double? minWidth;

  /// If, when not collapsed, to be shown as a dialog.
  final bool showAsDialog;

  /// Controls selected index.
  final TreeController? controller;

  // Called when the dialog is dismissed.
  final VoidCallback? onTreeCollapsed;

  // Dismiss the dialog when an item is selected.
  final bool dismissWhenSelected;

  @override
  State<Tree> createState() => _TreeState();
}

class _BuildTreePage {
  _BuildTreePage({required this.builder, required this.shouldBuild});

  final WidgetBuilder builder;
  bool shouldBuild;
}

class _TreeState extends State<Tree>
    with ComponentStateMixin, TickerProviderStateMixin {
  final _pages = HashMap<String, _BuildTreePage>();
  final GlobalKey _stackKey = GlobalKey();

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
  double get initialColumnWidth =>
      _initialColumnWidth ??= widget.minWidth ?? _kTreeWidth;

  TreeController? _internalController;
  TreeController get _controller => widget.controller ?? _internalController!;

  double? _offset;
  double? _totalWidth;

  late String _current;
  List<int> _forceCollapseIndex = [];

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

  void _onCurrentIndexChange() {
    if (widget.showAsDialog && widget.dismissWhenSelected) {
      widget.onTreeCollapsed!();
    }
    setState(_updateCurrentIndex);
  }

  void _updateCurrentIndex() {
    _current = _controller._index!.fold(
      '',
      (previousValue, element) => '$previousValue/$element',
    );

    _forceCollapseIndex = List.of(_controller._index!);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      final nodeOffset = _nodesOffset[_current];
      if (nodeOffset != null) {
        final position = _scrollController.position;

        final offsetToScroll =
            nodeOffset.height > position.viewportDimension + position.pixels
            ? nodeOffset.height - position.viewportDimension
            : nodeOffset.offset < position.pixels
            ? nodeOffset.offset
            : null;

        if (offsetToScroll != null) {
          position.animateTo(
            offsetToScroll,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
        }
      }
    });
  }

  void _updateTreeController([TreeController? oldWidgetController]) {
    if (widget.controller == null && _internalController == null) {
      _internalController = TreeController();
      _internalController!._index = _firstIndex(widget.nodes.first);
      _updateCurrentIndex();
      _internalController!.addListener(_onCurrentIndexChange);
    }
    if (widget.controller != null && _internalController != null) {
      _internalController!.dispose();
      _internalController = null;
    }
    if (oldWidgetController != widget.controller) {
      if (oldWidgetController?._isDisposed == false) {
        oldWidgetController!.removeListener(_onCurrentIndexChange);
      }
      widget.controller?.addListener(_onCurrentIndexChange);
      if (widget.controller?._index == null) {
        widget.controller!._index = _firstIndex(widget.nodes.first);
        _updateCurrentIndex();
      }
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
        _initialColumnWidth = max(
          min(
            _previoutColumnWidth + delta,
            (_totalWidth ?? double.infinity) -
                (widget.minWidth ?? _kMinDragWidth),
          ),
          widget.minWidth ?? _kMinDragWidth,
        );
      });
    }
  }

  List<int> _firstIndex(TreeNode node) {
    final result = [0];

    if (node.nodes != null && node.nodes!.isNotEmpty) {
      result.addAll(_firstIndex(node.nodes!.first));
    }

    return result;
  }

  List<int> _lastIndex(List<TreeNode> nodes) {
    return nodes.last.nodes != null
        ? [nodes.length - 1, ..._lastIndex(nodes.last.nodes!)]
        : [nodes.length - 1];
  }

  final ScrollController _scrollController = ScrollController();
  final Map<String, _TreeNodeOffset> _nodesOffset = {};

  Widget _createTree(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      constraints: BoxConstraints(
        minWidth: initialColumnWidth,
        maxWidth: widget.allowResizing || widget.minWidth != null
            ? initialColumnWidth
            : double.infinity,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0),
        controller: _scrollController,
        child: _TreeColumn(
          title: widget.title,
          nodes: widget.nodes,
          updatePage: () {
            setState(() => _forceCollapseIndex = []);
          },
          controller: _controller,
          forceExpandIndex: _forceCollapseIndex,
          parentForceExpand: true,
          sizeChanged: (name, offset) => _nodesOffset[name] = offset,
        ),
      ),
    );
  }

  late AnimationController _indicatorSizecontroller;
  late AnimationController _columnController;

  AnimationController? _treeController;
  CurvedAnimation? _treeAnimation;

  late CurvedAnimation _columnAnimation;

  void _createEntries(List<TreeNode> nodes, String previousName) {
    for (int i = 0; i < nodes.length; i += 1) {
      final name = i.toString();
      final nameResult = '$previousName/$name';

      if (nodes[i].nodes != null) {
        if (nodes[i].nodes!.isEmpty) {
          throw 'Nodes children cannot be empty.';
        }
        _createEntries(nodes[i].nodes!, nameResult);
      } else if (nodes[i].builder != null) {
        _pages[nameResult] = _BuildTreePage(
          builder: nodes[i].builder!,
          shouldBuild: _pages[nameResult]?.shouldBuild ?? false,
        );
      }
    }
  }

  bool _globalPointerDown = false;

  void _mouseRoute(PointerEvent event) {
    _globalPointerDown = event.down;
  }

  static String _indexName(List<int> index) =>
      index.fold('', (p, e) => '$p/$e');

  @override
  void initState() {
    super.initState();

    if (widget.nodes.isEmpty) {
      throw Exception('Nodes cannot be empty');
    }

    for (var i = 0; i < widget.nodes.length; i += 1) {
      _createEntries(widget.nodes, '');
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

    if (widget.showAsDialog) {
      _treeController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        value: widget.collapsed ? 0.0 : 1.0,
      );

      _treeAnimation = CurvedAnimation(
        parent: _treeController!,
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }

    _updateTreeController();

    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_mouseRoute);
  }

  @override
  void didUpdateWidget(Tree oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.nodes.isEmpty) {
      throw Exception('Nodes cannot be empty');
    }

    if (oldWidget.nodes != widget.nodes) {
      for (var i = 0; i < widget.nodes.length; i += 1) {
        _createEntries(widget.nodes, '');
      }
    }

    if (oldWidget.collapsed != widget.collapsed) {
      if (widget.showAsDialog) {
        if (widget.collapsed) {
          _treeController!.animateBack(0.0);
        } else {
          _treeController!.animateTo(1.0);
        }
      } else {
        if (widget.collapsed) {
          _columnController.animateBack(0.0);
        } else {
          _columnController.animateTo(1.0);
        }
      }
    }

    if (widget.controller != oldWidget.controller) {
      _updateTreeController(oldWidget.controller);
    } else {
      if (!_pages.containsKey(_indexName(_controller.index))) {
        _controller.index = _lastIndex(widget.nodes);
      }
    }

    if (widget.minWidth != oldWidget.minWidth) {
      if (widget.minWidth != null) {
        _initialColumnWidth = widget.minWidth;
      }
    }

    if (!widget.showAsDialog && oldWidget.showAsDialog) {
      if (widget.showAsDialog) {
        _treeController = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 400),
          value: widget.collapsed ? 0.0 : 1.0,
        );

        _treeAnimation = CurvedAnimation(
          parent: _treeController!,
          curve: Curves.fastEaseInToSlowEaseOut,
        );
      } else {
        _treeController?.dispose();
        _treeController = null;
        _treeAnimation = null;
      }
    }
  }

  @override
  void dispose() {
    if (!_controller._isDisposed) {
      _controller.removeListener(_onCurrentIndexChange);
    }

    _indicatorSizecontroller.dispose();
    _columnController.dispose();
    _treeController?.dispose();
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(_mouseRoute);

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pagesResult = List<Widget>.empty(growable: true);
        final children = List<Widget>.empty(growable: true);

        _totalWidth = constraints.maxWidth;

        for (final entry in _pages.entries) {
          final active = entry.key == _current;
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

        if (!widget.showAsDialog) {
          children.add(
            Offstage(
              offstage: widget.collapsed && _columnController.isCompleted,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: _columnAnimation,
                child: _createTree(context),
              ),
            ),
          );
        }

        if (widget.allowResizing) {
          final treeTheme = TreeTheme.of(context);

          children.add(
            Offstage(
              offstage: widget.collapsed,
              child: Align(
                alignment: Alignment.topLeft,
                child: FadeTransition(
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
                        child: SizeTransition(
                          axis: Axis.horizontal,
                          sizeFactor: _indicatorSizecontroller,
                          child: Container(
                            width: 2.0,
                            color: widget.collapsed || dragged
                                ? treeTheme.indicatorHighlightColor!
                                : hovered
                                ? treeTheme.indicatorHoverColor
                                : treeTheme.indicatorColor,
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

        if (widget.showAsDialog) {
          final dialogTheme = DialogTheme.of(context);
          final barrierColor = dialogTheme.barrierColor!;

          final menuColorTween = ColorTween(
            begin: barrierColor.withValues(alpha: 0.0),
            end: barrierColor.withValues(alpha: 0.8),
          );

          pagesResult.add(
            Offstage(
              offstage: widget.collapsed && !_treeAnimation!.isAnimating,
              child: IgnorePointer(
                ignoring: widget.collapsed,
                child: AnimatedBuilder(
                  animation: _treeAnimation!,
                  builder: (context, _) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => widget.onTreeCollapsed!(),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        color: menuColorTween.evaluate(_treeAnimation!),
                        child: GestureDetector(
                          behavior: HitTestBehavior.deferToChild,
                          onTap: () {},
                          child: ClipRect(
                            child: FractionalTranslation(
                              translation: Tween<Offset>(
                                begin: const Offset(-1.0, 0.0),
                                end: const Offset(0.0, 0.0),
                              ).evaluate(_treeAnimation!),
                              child: Container(
                                height: double.infinity,
                                width: initialColumnWidth,
                                color: Theme.of(
                                  context,
                                ).colorScheme.background[0],
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.fastEaseInToSlowEaseOut,
                                  child: _createTree(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }

        children.add(
          Expanded(
            child: Stack(
              key: _stackKey,
              fit: StackFit.expand,
              children: pagesResult,
            ),
          ),
        );

        return Row(children: children);
      },
    );
  }
}

typedef _SizeTreeCallback = void Function(String name, _TreeNodeOffset offset);
typedef _SizeCallback = void Function(int index, _TreeNodeOffset offset);

class _NodeBuild {
  const _NodeBuild(this.name, this.child);

  final String name;
  final Widget child;
}

@immutable
class _TreeNodeOffset {
  const _TreeNodeOffset(this.offset, this.height);

  final double offset;
  final double height;

  @override
  int get hashCode => Object.hash(offset, height);

  @override
  bool operator ==(covariant _TreeNodeOffset other) {
    if (identical(this, other)) {
      return true;
    }
    return other.offset == offset && other.height == other.height;
  }
}

class _TreeColumn extends StatefulWidget {
  const _TreeColumn({
    this.title,
    required this.nodes,
    required this.updatePage,
    required this.controller,
    required this.forceExpandIndex,
    required this.parentForceExpand,
    required this.sizeChanged,
  });

  final Widget? title;
  final List<TreeNode> nodes;
  final VoidCallback updatePage;
  final TreeController controller;
  final bool parentForceExpand;
  final List<int> forceExpandIndex;
  final _SizeTreeCallback sizeChanged;

  @override
  State<_TreeColumn> createState() => _TreeColumnState();
}

class _TreeColumnState extends State<_TreeColumn> {
  final Map<String, bool> _nodesCollapsed = {};

  void _createNodeState(List<TreeNode> nodes, List<int> parentIndex) {
    for (int i = 0; i < nodes.length; i += 1) {
      if (nodes[i].nodes != null) {
        final index = [...parentIndex, i];
        final name = _TreeState._indexName(index);
        if (!_nodesCollapsed.containsKey(name)) {
          _nodesCollapsed[name] = true;
        }

        _createNodeState(nodes[i].nodes!, index);
      }
    }
  }

  void _updateCollapseIndex(
    List<TreeNode> nodes,
    List<int> parentIndex, {
    required List<int> forceExpandIndex,
    required bool parentForceExpand,
  }) {
    for (int i = 0; i < nodes.length; i += 1) {
      if (nodes[i].nodes != null) {
        int expand = -1;
        final expandIndex = List.of(forceExpandIndex);

        if (forceExpandIndex.isNotEmpty) {
          expand = expandIndex.removeAt(0);
        }

        final index = [...parentIndex, i];
        final name = _TreeState._indexName(index);

        final forcesExpand = expand == i && parentForceExpand;

        if (forcesExpand) {
          _nodesCollapsed[name] = false;
        }

        _updateCollapseIndex(
          nodes[i].nodes!,
          index,
          forceExpandIndex: expandIndex,
          parentForceExpand: forcesExpand,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _createNodeState(widget.nodes, []);
    _updateCollapseIndex(
      widget.nodes,
      [],
      forceExpandIndex: widget.forceExpandIndex,
      parentForceExpand: widget.parentForceExpand,
    );
  }

  @override
  void didUpdateWidget(_TreeColumn oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.nodes != oldWidget.nodes) {
      _createNodeState(widget.nodes, []);
    }

    if (!(const ListEquality<int>().equals(
      oldWidget.forceExpandIndex,
      widget.forceExpandIndex,
    ))) {
      _updateCollapseIndex(
        widget.nodes,
        [],
        forceExpandIndex: widget.forceExpandIndex,
        parentForceExpand: widget.parentForceExpand,
      );
    }
  }

  List<_NodeBuild> _buildNodes(
    List<TreeNode> nodes,
    List<int> parentIndex,
    bool parentCollapsed,
  ) {
    final treeTheme = TreeTheme.of(context);
    final List<_NodeBuild> children = List.empty(growable: true);

    for (int i = 0; i < nodes.length; i += 1) {
      final index = [...parentIndex, i];
      final name = _TreeState._indexName(index);

      if (nodes[i].nodes != null) {
        final collapsed = _nodesCollapsed[name]!;

        children.add(
          _NodeBuild(
            name,
            Offstage(
              offstage: parentCollapsed,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0 * parentIndex.length),
                  child: Button(
                    bodyPadding: EdgeInsets.zero,
                    theme: ButtonThemeData(
                      color: treeTheme.color,
                      hoverColor: treeTheme.hoverColor,
                      highlightColor: treeTheme.highlightColor,
                    ),
                    padding: EdgeInsets.zero,
                    body: _TreeNodeCollapse(
                      collapsed,
                      child: nodes[i].titleBuilder(context),
                    ),
                    onPressed: () {
                      widget.updatePage();
                      setState(() => _nodesCollapsed[name] = !collapsed);
                    },
                  ),
                ),
              ),
            ),
          ),
        );

        children.addAll(
          _buildNodes(nodes[i].nodes!, index, parentCollapsed || collapsed),
        );
      } else {
        final active = const ListEquality<int>().equals(
          widget.controller._index,
          index,
        );
        final highlightColor = treeTheme.highlightColor;

        children.add(
          _NodeBuild(
            name,
            Offstage(
              offstage: parentCollapsed,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0 * parentIndex.length),
                  child: Button(
                    theme: ButtonThemeData(
                      color: highlightColor,
                      highlightColor: treeTheme.color,
                    ),
                    padding: EdgeInsets.zero,
                    bodyPadding: EdgeInsets.zero,
                    body: nodes[i].titleBuilder(context),
                    active: active,
                    onPressed: () => widget.controller.index = index,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    final result = _buildNodes(widget.nodes, [], false);
    final nodeNames = result.map((e) => e.name).toList();

    return _ListTableRows(
      children: [
        if (widget.title != null) widget.title!,
        ...result.map((e) => e.child),
      ],
      hasTitle: widget.title != null,
      sizeChanged: (int i, _TreeNodeOffset offset) =>
          widget.sizeChanged(nodeNames[i], offset),
    );
  }
}

class _ListTableRows extends MultiChildRenderObjectWidget {
  const _ListTableRows({
    required super.children,
    required this.sizeChanged,
    required this.hasTitle,
  });

  final _SizeCallback sizeChanged;
  final bool hasTitle;

  @override
  _TreeColumnRender createRenderObject(BuildContext context) =>
      _TreeColumnRender(sizeChanged: sizeChanged, hasTitle: hasTitle);

  @override
  void updateRenderObject(
    BuildContext context,
    _TreeColumnRender renderObject,
  ) {
    renderObject.hasTitle = hasTitle;
  }
}

class _TreeColumnParentData extends ContainerBoxParentData<RenderBox> {}

class _TreeColumnRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _TreeColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _TreeColumnParentData> {
  _TreeColumnRender({
    List<RenderBox>? children,
    required this.sizeChanged,
    required bool hasTitle,
  }) : _hasTitle = hasTitle {
    addAll(children);
  }

  final _SizeCallback sizeChanged;

  bool _hasTitle;
  set hasTitle(bool value) {
    if (value != _hasTitle) {
      _hasTitle = value;
      markNeedsLayout();
    }
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _TreeColumnParentData) {
      child.parentData = _TreeColumnParentData();
    }
  }

  @override
  bool get sizedByParent => false;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    double height = 0.0;

    RenderBox? child = firstChild;

    while (child != null) {
      height += child
          .getDryLayout(BoxConstraints.tightFor(width: constraints.maxWidth))
          .height;

      child = childAfter(child);
    }

    return constraints.constrain(Size(constraints.maxWidth, height));
  }

  @override
  void performLayout() {
    RenderBox? child = firstChild;
    double height = 0.0;
    double width = 0.0;

    if (_hasTitle && child != null) {
      child.layout(
        BoxConstraints(
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
        ),
        parentUsesSize: true,
      );

      width = max(width, child.size.width);

      (child.parentData! as _TreeColumnParentData).offset = Offset(0.0, height);

      height += child.size.height;

      child = childAfter(child);
    }

    int x = 0;

    while (child != null) {
      child.layout(
        BoxConstraints(
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
        ),
        parentUsesSize: true,
      );

      (child.parentData! as _TreeColumnParentData).offset = Offset(0.0, height);

      final childOffset = height;

      height += child.size.height;
      width = max(width, child.size.width);

      sizeChanged(x, _TreeNodeOffset(childOffset, height));

      child = childAfter(child);
      x += 1;
    }

    size = Size(width, height);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox? child = firstChild;

    while (child != null) {
      final childParentData = child.parentData! as _TreeColumnParentData;

      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child!.hitTest(result, position: transformed);
        },
      );

      if (isHit) {
        return true;
      }

      child = childAfter(child);
    }

    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;

    while (child != null) {
      final childParentData = child.parentData! as _TreeColumnParentData;
      context.paintChild(child, childParentData.offset + offset);

      child = childAfter(child);
    }
  }
}
