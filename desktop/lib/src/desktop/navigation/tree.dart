import 'dart:collection';
import 'dart:math' as math;
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart' show ListEquality;

import '../component.dart';
import '../icons.dart';
import '../input/button.dart';
import '../theme/theme.dart';

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
  TreeController({
    List<int>? initialIndex,
  }) : _index = initialIndex;

  bool _isDisposed = false;

  /// The index of the currently selected tab.
  List<int> get index => _index!;
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
    this.controller,
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

  /// Controls selected index.
  final TreeController? controller;

  @override
  _TreeState createState() => _TreeState();
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
  double get initialColumnWidth => _initialColumnWidth ??= 200.0;

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
    // TODO assert(_controller.index >= 0 && _controller.index < _length);
    setState(() => _updateCurrentIndex());
  }

  void _updateCurrentIndex() {
    _current = _controller._index!
        .fold('', (previousValue, element) => '$previousValue/$element');
    _forceCollapseIndex = List.of(_controller._index!);
    if (_forceCollapseIndex.isNotEmpty) {
      _forceCollapseIndex.removeLast();
    }
  }

  void _updateTreeController([TreeController? oldWidgetController]) {
    if (widget.controller == null && _internalController == null) {
      _internalController = TreeController();
      _internalController!._index = _firstIndex(widget.nodes[1]); // TODO
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
        _initialColumnWidth = math.max(
            math.min(_previoutColumnWidth + delta,
                (_totalWidth ?? double.infinity) - 200.0),
            200.0);
      });
    }
  }

  List<int> _firstIndex(TreeNode node) {
    final result = [1]; // TODO

    if (node.nodes != null && node.nodes!.isNotEmpty) {
      result.addAll(_firstIndex(node.nodes!.first));
    }

    return result;
  }

  final ScrollController _scrollController = ScrollController();

  Widget _createTree(BuildContext context) {
    final List<Widget> children = List.empty(growable: true);

    if (widget.title != null) {
      children.add(widget.title!);
    }

    for (var i = 0; i < widget.nodes.length; i += 1) {
      children.add(_TreeColumn(
        node: widget.nodes[i],
        parentName: const [],
        name: i,
        updatePage: () {
          setState(() => _forceCollapseIndex = []);
        },
        controller: _controller,
        forceCollapseIndex: _forceCollapseIndex,
      ));
    }

    return Container(
      alignment: Alignment.topLeft,
      width: initialColumnWidth,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SingleChildScrollView(
          controller: _scrollController,
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

    if (widget.controller != oldWidget.controller) {
      _updateTreeController(oldWidget.controller);
    } else {
      //final int _index = math.min(_controller.index, widget.items.length - 1);
      //if (_index != _controller.index) {
      //  _controller.index = _index;
      //}
    }
  }

  @override
  void dispose() {
    if (!_controller._isDisposed) {
      _controller.removeListener(_onCurrentIndexChange);
    }

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

      print(_forceCollapseIndex);

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

      return result;
    });
  }
}

class _TreeColumn extends StatefulWidget {
  const _TreeColumn({
    required this.node,
    required this.parentName,
    required this.name,
    required this.updatePage,
    required this.controller,
    required this.forceCollapseIndex,
  });

  final TreeNode node;
  final List<int> parentName;
  final int name;
  final VoidCallback updatePage;
  final TreeController controller;
  final List<int> forceCollapseIndex;

  @override
  _TreeColumnState createState() => _TreeColumnState();
}

class _TreeColumnState extends State<_TreeColumn> {
  bool _collapsed = true;

  late List<int> _name;

  @override
  void initState() {
    super.initState();

    _name = [...widget.parentName, widget.name];

    if (const ListEquality().equals(widget.forceCollapseIndex, _name)) {
      _collapsed = false;
    }
  }

  @override
  void didUpdateWidget(_TreeColumn oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.parentName != widget.parentName ||
        oldWidget.name != widget.name) {
      _name = [...widget.parentName, widget.name];
    }

    if (oldWidget.forceCollapseIndex != widget.forceCollapseIndex) {
      if (const ListEquality().equals(widget.forceCollapseIndex, _name)) {
        _collapsed = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final treeTheme = TreeTheme.of(context);

    if (widget.node.nodes != null) {
      final List<_TreeColumn> children = List.empty(growable: true);

      for (var i = 0; i < widget.node.nodes!.length; i += 1) {
        children.add(_TreeColumn(
          node: widget.node.nodes![i],
          parentName: _name,
          name: i,
          updatePage: widget.updatePage,
          controller: widget.controller,
          forceCollapseIndex: widget.forceCollapseIndex,
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
              // && !const ListEquality().equals(widget.forceCollapseIndex, name),
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
      final active =
          const ListEquality().equals(widget.controller._index, _name);
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
          onPressed: () => widget.controller.index = _name,
        ),
      );
    }
  }
}
