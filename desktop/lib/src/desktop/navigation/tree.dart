import 'dart:collection';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../icons.dart';
import '../input/button.dart';
import '../scrolling/scrollbar.dart';
import '../theme/theme.dart';
import 'tab_view.dart';

/// Class for building nodes in a [Tree].
@immutable
class TreeNode {
  /// Creates a tree node with the page title, and child or children.
  const TreeNode(this.title, {this.builder, this.nodes})
      : assert((builder == null || nodes == null) &&
            (builder != null || nodes != null));

  /// Creates a node with a default text and a [Navigator] history.
  /// See also:
  ///   * [TabView] for the arguments.
  ///   * [Navigator]
  factory TreeNode.child(
    String text, {
    WidgetBuilder? builder,
    GlobalKey<NavigatorState>? navigatorKey,
    String? defaultTitle,
    Map<String, WidgetBuilder>? routes,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
  }) {
    return TreeNode(
      text,
      builder: (BuildContext context) => TabView(
        builder: builder,
        navigatorKey: navigatorKey,
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        defaultTitle: defaultTitle,
        navigatorObservers: navigatorObservers,
      ),
    );
  }

  // /// Creates a custom node with a [Navigator] history.
  // /// /// See also:
  // ///   * [TabView] for the arguments.
  // ///   * [Navigator]
  // factory TreeNode.customNode(
  //   String title, {
  //   WidgetBuilder? builder,
  //   GlobalKey<NavigatorState>? navigatorKey,
  //   String? defaultTitle,
  //   Map<String, WidgetBuilder>? routes,
  //   RouteFactory? onGenerateRoute,
  //   RouteFactory? onUnknownRoute,
  //   List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
  // }) {
  //   return TreeNode(
  //     title,
  //     builder: (BuildContext context) => TabView(
  //       builder: builder,
  //       navigatorKey: navigatorKey,
  //       routes: routes,
  //       onGenerateRoute: onGenerateRoute,
  //       onUnknownRoute: onUnknownRoute,
  //       defaultTitle: defaultTitle,
  //       navigatorObservers: navigatorObservers,
  //     ),
  //   );
  // }

  /// Creates a node with children and default text.
  factory TreeNode.children(
    String text, {
    required List<TreeNode> children,
  }) {
    return TreeNode(
      text,
      nodes: children,
    );
  }

  // Creates a custom node with children and default text.
  // factory TreeNode.customNodes(
  //   String child, {
  //   required List<TreeNode> children,
  // }) {
  //   return TreeNode(
  //     child,
  //     children: children,
  //   );
  // }

  /// The children in a node.
  final List<TreeNode>? nodes;

  /// The child in the node.
  final WidgetBuilder? builder;

  ///
  final String title;
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
    this.visible = false,
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

  /// If the tree is on top of the page. Ignored if `collapsed` is false.
  final bool visible;

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

class _TreeState extends State<Tree> {
  final _pages = HashMap<String, _BuildTreePage>();
  final List<FocusScopeNode> _disposedFocusNodes = <FocusScopeNode>[];
  String? _current;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode(skipTraversal: true));

  void setPage(String name) {
    setState(() => _current = name);
    _focusView();
  }

  void _createEntries(String name, TreeNode node) {
    final nameResult = '''$name${node.title}''';

    if (node.nodes != null) {
      for (final child in node.nodes!) {
        _createEntries(nameResult, child);
      }
    } else if (node.builder != null) {
      if (!_pages.containsKey(nameResult)) {
        _pages[nameResult] = _BuildTreePage(
          builder: node.builder!,
          focusScopeNode: FocusScopeNode(
            skipTraversal: true,
            debugLabel: 'Tree $nameResult',
          ),
        );
      }
    } else {
      throw Exception('Either builder or children must be not null');
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

    if (_verifyDuplicates(widget.nodes)) {
      throw Exception('Cannot have duplicate routes');
    }

    for (final node in widget.nodes) {
      _createEntries('', node);
    }

    oldPages.removeWhere((key, value) => _pages.containsKey(key));
    _disposedFocusNodes
        .addAll(oldPages.values.map((value) => value.focusScopeNode));

    _focusView();
  }

  @override
  void dispose() {
    for (final value in _pages.values) {
      value.focusScopeNode.dispose();
    }
    for (final focusScopeNode in _disposedFocusNodes) {
      focusScopeNode.dispose();
    }

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusView();
  }

  // Returns true if any route is a duplicate.
  bool _verifyDuplicates(List<TreeNode> nodes) {
    for (final node in nodes) {
      if (node.nodes != null) {
        if (_verifyDuplicates(node.nodes!)) {
          return true;
        }

        if (nodes.where((element) => node.title == element.title).length != 1) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  void initState() {
    super.initState();

    if (widget.nodes.isEmpty) {
      throw Exception('Nodes cannot be empty');
    }

    if (_verifyDuplicates(widget.nodes)) {
      throw Exception('Cannot have duplicate routes');
    }

    for (final node in widget.nodes) {
      _createEntries('', node);
    }
  }

  Widget _createTree(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 200.0, // TODO(as): Use step width.
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.nodes
                      .map(
                        (e) => _TreeColumn(
                          node: e,
                          parentName: '',
                          updatePage: () {
                            setState(
                                () {}); // TODO(as): See scroll notification without rebuilding.
                            //controller.position.;
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pagesResult = List<Widget>.empty(growable: true);

    _current ??= widget.nodes.first.title;

    for (final entry in _pages.entries) {
      final active = entry.key == _current!;
      entry.value.shouldBuild = active || entry.value.shouldBuild;

      pagesResult.add(
        Offstage(
          offstage: !active,
          child: TickerMode(
            enabled: active,
            child: FocusScope(
              node: entry.value.focusScopeNode,
              canRequestFocus: active,
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
        ),
      );
    }

    Widget result;

    if (widget.collapsed) {
      if (widget.visible) {
        result = Row(
          children: [
            _createTree(context),
            Expanded(
              child: Stack(children: pagesResult),
            )
          ],
        );
      } else {
        result = Stack(children: pagesResult);
      }
    } else {
      result = Row(
        children: [
          _createTree(context),
          Expanded(
            child: Stack(children: pagesResult),
          )
        ],
      );
    }

    result = _TreeScope(
      child: result,
      treeState: this,
    );

    return FocusableActionDetector(
      child: result,
      focusNode: _effectiveFocusNode,
      autofocus: widget.autofocus,
    );
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
    required this.updatePage,
    Key? key,
  }) : super(key: key);

  final TreeNode node;
  final String parentName;
  final VoidCallback updatePage;

  @override
  _TreeColumnState createState() => _TreeColumnState();
}

class _TreeColumnState extends State<_TreeColumn> {
  bool _collapsed = true;

  String get name => '${widget.parentName}${widget.node.title}';

  @override
  Widget build(BuildContext context) {
    final treeTheme = TreeTheme.of(context);

    if (widget.node.title.isEmpty) {
      throw Exception('Title in tree cannot be empty');
    }

    if (widget.node.nodes != null) {
      final iconCollpased = _collapsed ? Icons.expand_more : Icons.expand_less;
      final chidrenWidget = Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.node.nodes!
              .map((e) => _TreeColumn(
                    node: e,
                    parentName: name,
                    updatePage: widget.updatePage,
                  ))
              .toList(),
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
              trailingPadding: const EdgeInsets.only(left: 8.0),
              padding: EdgeInsets.zero,
              body: Text(widget.node.title),
              trailing: Icon(iconCollpased),
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
      final hoverColor = active ? highlightColor : treeTheme.hoverColor;
      final activeColor = active ? highlightColor : treeTheme.color;

      return Align(
        alignment: Alignment.centerLeft,
        child: ButtonTheme.merge(
          data: ButtonThemeData(
            color: activeColor,
            highlightColor: highlightColor,
            hoverColor: hoverColor,
            focusColor: hoverColor,
          ),
          child: Button(
            padding: EdgeInsets.zero,
            bodyPadding: EdgeInsets.zero,
            body: Text(
              widget.node.title,
            ),
            onPressed: () {
              Tree._of(context)!.setPage(name);
            },
          ),
        ),
      );
    }
  }
}
