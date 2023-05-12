import 'package:desktop/desktop.dart';

import '../defaults.dart';

const _indexes = [
  [0],
  [1, 0],
  [1, 1],
  [1, 2],
  [1, 3, 0],
  [1, 3, 1],
  [2],
  [3, 0],
  [3, 1],
  [4, 0],
  [4, 1],
  [4, 2],
  [5, 0],
  [5, 1, 0],
  [5, 2, 0],
  [5, 2, 1],
  [5, 2, 2, 0],
  [5, 2, 2, 1, 0],
  [5, 2, 2, 1, 1],
  [5, 3],
  [6, 0],
  [6, 1],
  [6, 2, 0],
];

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  bool _isShowingTree = true;
  final TreeController _controller = TreeController();

  Widget _buildTreeControllerPage() {
    return Center(
      child: SingleChildScrollView(
        controller: ScrollController(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _indexes
                .map(
                  (e) => Button.text(
                    'Node ${e.fold('', (p, e) => '$p${p.isNotEmpty ? ' -> ' : ''} $e')}',
                    onPressed: () => _controller.index = e,
                  ),
                )
                .toList()),
      ),
    );
  }

  List<TreeNode> _generateTree(List<List<int>> indexes, String parentName) {
    final nodes = <int, List<List<int>>>{};
    final result = <TreeNode>[];

    for (int i = 0; i < indexes.length; i += 1) {
      if (indexes[i].isEmpty) {
        throw 'Cannot be empty.';
      }

      final nodeIndexes = List.of(indexes[i]);
      final index = nodeIndexes.removeAt(0);

      nodes[index] ??= [];

      if (nodeIndexes.isNotEmpty) {
        nodes[index]!.add(nodeIndexes);
      }
    }

    for (final i in nodes.keys) {
      final name = i.toString();
      final titleName =
          '$parentName${parentName.isNotEmpty ? ' -> ' : 'Node '}$name';

      if (nodes[i]!.isEmpty) {
        result.add(
          TreeNode.child(
            titleBuilder: (context) => Text('Node $name'),
            builder: (context) => Center(
              child: Text(titleName),
            ),
          ),
        );
      } else {
        result.add(
          TreeNode.children(
            titleBuilder: (context) => Text('Node $name'),
            children: _generateTree(
              nodes[i]!,
              titleName,
            ),
          ),
        );
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    const codeSample = '''
return Tree(
  title: Builder(
    builder: (context) => Text(
      'Tree',
      style: textTheme.body2,
    ),
  ),
  nodes: [
    TreeNode(
      'Node 0',
      builder: (context) => Center(
          child: Text(
        'Node 0',
        style: textTheme.title,
      )),
    ),
    TreeNode('Node 1', children: [
      TreeNode(
        'Node 0',
        builder: (context) => Center(
            child: Text(
          'Node 1 -> 0',
          style: textTheme.title,
        )),
      ),
      TreeNode(
        'Node 1',
        builder: (context) => Center(
            child: Text(
          'Node 1 -> 1',
          style: textTheme.title,
        )),
      ),
      TreeNode(
        'Node 2',
        builder: (context) => Center(
            child: Text(
          'Node 1 -> 2',
          style: textTheme.title,
        )),
      ),
      TreeNode('Node3', children: [
        TreeNode(
          'Node 0',
          builder: (context) => Center(
              child: Text(
            'Node 1 -> 3 -> 0',
            style: textTheme.title,
          )),
        ),
        TreeNode(
          'Node 1',
          builder: (context) => Center(
              child: Text(
            'Node 1 -> 3 -> 1',
            style: textTheme.title,
          )),
        ),
        // TreeNode('Breadcrumb',
        //     builder: (context) => BreadcrumbPage()),
      ]),
      // TreeNode('Breadcrumb',
      //     builder: (context) => BreadcrumbPage()),
    ]),
    TreeNode(
      'Node 2',
      builder: (context) => Center(
          child: Text(
        'Node 2 ',
        style: textTheme.title,
      )),
    ),
    TreeNode('Node 3', children: [
      TreeNode(
        'Node 0',
        builder: (context) => Center(
            child: Text(
          'Node 3 -> 0',
          style: textTheme.title,
        )),
      ),
      TreeNode(
        'Node 1',
        builder: (context) => Center(
            child: Text(
          'Node 3 -> 1',
          style: textTheme.title,
        )),
      ),
      // TreeNode('Breadcrumb',
      //     builder: (context) => BreadcrumbPage()),
    ]),
  ],
);
''';

    const codeSampleWidget = '''
return Tree(
  title: Builder(
    builder: (context) => Text(
      'Tree with widgets',
      style: Theme.of(context).textTheme.body2,
    ),
  ),
  nodes: [
    TreeNode.child(
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.camera_enhance),
          ),
          Text('Node 0'),
        ],
      ),
      name: 'node_0',
      builder: (context) => Center(
          child: Text(
        'Node 0',
        style: Theme.of(context).textTheme.title,
      )),
    ),
    TreeNode.children(
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.place),
          ),
          Text('Node 1'),
        ],
      ),
      name: 'node_1',
      children: [
        TreeNode.child(
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.location_city),
              ),
              Text('Node 0'),
            ],
          ),
          builder: (context) => Center(
            child: Text(
              'Node 1 -> 0',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          name: 'node_0',
        ),
        TreeNode.child(
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.map),
              ),
              Text('Node 1'),
            ],
          ),
          name: 'node_1',
          builder: (context) => Center(
              child: Text(
            'Node 1 -> 1',
            style: Theme.of(context).textTheme.title,
          )),
        ),
      ],
    ),
    TreeNode.child(
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.message),
          ),
          Text('Node 2'),
        ],
      ),
      name: 'node_2',
      builder: (context) => Center(
          child: Text(
        'Node 2 ',
        style: Theme.of(context).textTheme.title,
      )),
    ),
  ],
);
''';

    const codeSampleCollapse = '''
return Tree(
  collapsed: !_isShowingTree,
  title: Builder(
    builder: (context) => Text(
      'Tree with widgets',
      style: Theme.of(context).textTheme.body2,
    ),
  ),
  nodes: [
    TreeNode.child(
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.camera_enhance),
          ),
          Text('Node 0'),
        ],
      ),
      name: 'node_0',
      builder: (context) => Center(
          child: Text(
        'Node 0',
        style: Theme.of(context).textTheme.title,
      )),
    ),
    TreeNode.children(
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.place),
          ),
          Text('Node 1'),
        ],
      ),
      name: 'node_1',
      children: [
        TreeNode.child(
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.location_city),
              ),
              Text('Node 0'),
            ],
          ),
          builder: (context) => Center(
            child: Text(
              'Node 1 -> 0',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          name: 'node_0',
        ),
        TreeNode.child(
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.map),
              ),
              Text('Node 1'),
            ],
          ),
          name: 'node_1',
          builder: (context) => Center(
              child: Text(
            'Node 1 -> 1',
            style: Theme.of(context).textTheme.title,
          )),
        ),
      ],
    ),
    TreeNode.child(
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.message),
          ),
          Text('Node 2'),
        ],
      ),
      name: 'node_2',
      builder: (context) => Center(
          child: Text(
        'Node 2 ',
        style: Theme.of(context).textTheme.title,
      )),
    ),
  ],
);
''';

    return Defaults(
      styleItems: Defaults.createStyle(TreeTheme.of(context).toString()),
      items: [
        ItemTitle(
          title: 'Basic example',
          codeText: codeSample,
          body: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Tree(
                title: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Tree',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ),
                nodes: [
                  TreeNode.child(
                    titleBuilder: (context) => const Text('Node 0'),
                    builder: (context) => Center(
                      child: Text(
                        'Node 0',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                  TreeNode.children(
                    titleBuilder: (context) => const Text('Node 1'),
                    children: [
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 0'),
                        builder: (context) => Center(
                          child: Text(
                            'Node 1 -> 0',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 1'),
                        builder: (context) => Center(
                          child: Text(
                            'Node 1 -> 1',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 2'),
                        builder: (context) => Center(
                          child: Text(
                            'Node 1 -> 2',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                      TreeNode.children(
                        titleBuilder: (context) => const Text('Node3'),
                        children: [
                          TreeNode.child(
                            titleBuilder: (context) => const Text('Node 0'),
                            builder: (context) => Center(
                              child: Text(
                                'Node 1 -> 3 -> 0',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                          TreeNode.child(
                            titleBuilder: (context) => const Text('Node 1'),
                            builder: (context) => Center(
                              child: Text(
                                'Node 1 -> 3 -> 1',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TreeNode.child(
                    titleBuilder: (context) => const Text('Node 2'),
                    builder: (context) => Center(
                      child: Text(
                        'Node 2 ',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                  TreeNode.children(
                    titleBuilder: (context) => const Text('Node 3'),
                    children: [
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 0'),
                        builder: (context) => Center(
                          child: Text(
                            'Node 3 -> 0',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 1'),
                        builder: (context) => Center(
                          child: Text(
                            'Node 3 -> 1',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        ItemTitle(
          title: 'Controlled Tree',
          codeText: codeSample,
          body: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Tree(
                      controller: _controller,
                      title: Builder(
                        builder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            'Tree',
                            style: Theme.of(context).textTheme.body2,
                          ),
                        ),
                      ),
                      nodes: _generateTree(_indexes, ''),
                    ),
                  ),
                  _buildTreeControllerPage(),
                ],
              ),
            );
          },
        ),
        ItemTitle(
          title: 'Using widgets instead of text',
          codeText: codeSampleWidget,
          body: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Tree(
                title: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Tree with widgets',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ),
                nodes: [
                  TreeNode.child(
                    titleBuilder: (constext) => const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.camera_enhance),
                        ),
                        Text('Node 0'),
                      ],
                    ),
                    builder: (context) => Center(
                      child: Text(
                        'Node 0',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                  TreeNode.children(
                    titleBuilder: (context) => const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.place),
                        ),
                        Text('Node 1'),
                      ],
                    ),
                    children: [
                      TreeNode.child(
                        titleBuilder: (context) => const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.location_city),
                            ),
                            Text('Node 0'),
                          ],
                        ),
                        builder: (context) => Center(
                          child: Text(
                            'Node 1 -> 0',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.map),
                            ),
                            Text('Node 1'),
                          ],
                        ),
                        builder: (context) => Center(
                          child: Text(
                            'Node 1 -> 1',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TreeNode.child(
                    titleBuilder: (context) => const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.message),
                        ),
                        Text('Node 2'),
                      ],
                    ),
                    builder: (context) => Center(
                      child: Text(
                        'Node 2 ',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        ItemTitle(
          title: 'Collapsible tree',
          codeText: codeSampleCollapse,
          body: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Button.text(
                    'Collapse Tree',
                    onPressed: () =>
                        setState(() => _isShowingTree = !_isShowingTree),
                  ),
                ),
                Expanded(
                  child: Tree(
                    collapsed: !_isShowingTree,
                    title: Builder(
                      builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'Tree collapse',
                          style: Theme.of(context).textTheme.body2,
                        ),
                      ),
                    ),
                    nodes: [
                      TreeNode.child(
                        titleBuilder: (context) => const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.camera_enhance),
                            ),
                            Text('Node 0'),
                          ],
                        ),
                        builder: (context) => Center(
                          child: Text(
                            'Node 0',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                      TreeNode.children(
                        titleBuilder: (context) => const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.place),
                            ),
                            Text('Node 1'),
                          ],
                        ),
                        children: [
                          TreeNode.child(
                            titleBuilder: (context) => const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.location_city),
                                ),
                                Text('Node 0'),
                              ],
                            ),
                            builder: (context) => Center(
                              child: Text(
                                'Node 1 -> 0',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                          TreeNode.child(
                            titleBuilder: (context) => const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.map),
                                ),
                                Text('Node 1'),
                              ],
                            ),
                            builder: (context) => Center(
                              child: Text(
                                'Node 1 -> 1',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.message),
                            ),
                            Text('Node 2'),
                          ],
                        ),
                        builder: (context) => Center(
                          child: Text(
                            'Node 2 ',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
      header: 'Tree',
    );
  }
}
