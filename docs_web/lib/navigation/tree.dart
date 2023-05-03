import 'package:desktop/desktop.dart';

import '../defaults.dart';

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  bool _isShowingTree = true;
  final TreeController _controller = TreeController();

  Widget _buildTreeControllerPage() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Button.text(
              'Node 0',
              onPressed: () => _controller.index = [0],
            ),
            Button.text(
              'Node 1 -> 0',
              onPressed: () => _controller.index = [1, 0],
            ),
            Button.text(
              'Node 1 -> 1',
              onPressed: () => _controller.index = [1, 1],
            ),
            Button.text(
              'Node 1 -> 2',
              onPressed: () => _controller.index = [1, 2],
            ),
            Button.text(
              'Node 1 -> 3 -> 0',
              onPressed: () => _controller.index = [1, 3, 0],
            ),
            Button.text(
              'Node 1 -> 3 -> 1',
              onPressed: () => _controller.index = [1, 3, 1],
            ),
            Button.text(
              'Node 2',
              onPressed: () => _controller.index = [2],
            ),
            Button.text(
              'Node 3 -> 0',
              onPressed: () => _controller.index = [3, 0],
            ),
            Button.text(
              'Node 3 -> 1',
              onPressed: () => _controller.index = [3, 1],
            ),
            Button.text(
              'Node 4 -> 0',
              onPressed: () => _controller.index = [4, 0],
            ),
            Button.text(
              'Node 4 -> 1',
              onPressed: () => _controller.index = [4, 1],
            ),
            Button.text(
              'Node 4 -> 2',
              onPressed: () => _controller.index = [4, 2],
            ),
            Button.text(
              'Node 4 -> 3',
              onPressed: () => _controller.index = [4, 3],
            ),
            Button.text(
              'Node 5 -> 0',
              onPressed: () => _controller.index = [5, 0],
            ),
            Button.text(
              'Node 5 -> 1',
              onPressed: () => _controller.index = [5, 1],
            ),
            Button.text(
              'Node 5 -> 2',
              onPressed: () => _controller.index = [5, 2],
            ),
            Button.text(
              'Node 5 -> 3',
              onPressed: () => _controller.index = [5, 3],
            ),
            Button.text(
              'Node 6 -> 0',
              onPressed: () => _controller.index = [6, 0],
            ),
            Button.text(
              'Node 6 -> 1',
              onPressed: () => _controller.index = [6, 1],
            ),
            Button.text(
              'Node 6 -> 2',
              onPressed: () => _controller.index = [6, 2],
            ),
            Button.text(
              'Node 6 -> 3',
              onPressed: () => _controller.index = [6, 3],
            ),
          ],
        ),
      ),
    );
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
          title: 'Controlled Tree',
          codeText: codeSample,
          body: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
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
                nodes: [
                  TreeNode.child(
                    titleBuilder: (context) => const Text('Node 0'),
                    builder: (context) => _buildTreeControllerPage(),
                  ),
                  TreeNode.children(
                    titleBuilder: (context) => const Text('Node 1'),
                    children: [
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 0'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 1'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 2'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.children(
                        titleBuilder: (context) => const Text('Node3'),
                        children: [
                          TreeNode.child(
                            titleBuilder: (context) => const Text('Node 0'),
                            builder: (context) => _buildTreeControllerPage(),
                          ),
                          TreeNode.child(
                            titleBuilder: (context) => const Text('Node 1'),
                            builder: (context) => _buildTreeControllerPage(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TreeNode.child(
                    titleBuilder: (context) => const Text('Node 2'),
                    builder: (context) => _buildTreeControllerPage(),
                  ),
                  TreeNode.children(
                    titleBuilder: (context) => const Text('Node 3'),
                    children: [
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 0'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 1'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                    ],
                  ),
                  TreeNode.children(
                    titleBuilder: (context) => const Text('Node 4'),
                    children: [
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 0'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 1'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 2'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 3'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 4'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                    ],
                  ),
                  TreeNode.children(
                    titleBuilder: (context) => const Text('Node 5'),
                    children: [
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 0'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 1'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 2'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 3'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 4'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                    ],
                  ),
                  TreeNode.children(
                    titleBuilder: (context) => const Text('Node 6'),
                    children: [
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 0'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 1'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 2'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 3'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                      TreeNode.child(
                        titleBuilder: (context) => const Text('Node 4'),
                        builder: (context) => _buildTreeControllerPage(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
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
