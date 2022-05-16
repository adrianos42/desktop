import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TreePage extends StatefulWidget {
  TreePage({Key? key}) : super(key: key);

  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  bool _isShowingTree = true;

  @override
  Widget build(BuildContext context) {
    const codeSample = '''
Tree(
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
)
''';

    const codeSampleWidget = '''
Tree(
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
)''';

    const codeSampleCollapse = '''
Tree(
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
)''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) {
            return Tree(
              title: Builder(
                builder: (context) => Text(
                  'Tree',
                  style: Theme.of(context).textTheme.body2,
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
                            // TreeNode('Breadcrumb',
                            //     builder: (context) => BreadcrumbPage()),
                          ]),
                      // TreeNode('Breadcrumb',
                      //     builder: (context) => BreadcrumbPage()),
                    ]),
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
                      // TreeNode('Breadcrumb',
                      //     builder: (context) => BreadcrumbPage()),
                    ]),
              ],
            );
          },
          codeText: codeSample,
          height: 600.0,
          title: 'Basic example',
        ),
        ItemTitle(
          body: (context) {
            return Tree(
              title: Builder(
                builder: (context) => Text(
                  'Tree with widgets',
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
              nodes: [
                TreeNode.child(
                  titleBuilder: (constext) => Row(
                    children: const [
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
                  titleBuilder: (context) => Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.place),
                      ),
                      Text('Node 1'),
                    ],
                  ),
                  children: [
                    TreeNode.child(
                      titleBuilder: (context) => Row(
                        children: const [
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
                      titleBuilder: (context) => Row(
                        children: const [
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
                  titleBuilder: (context) => Row(
                    children: const [
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
            );
          },
          codeText: codeSampleWidget,
          height: 600.0,
          title: 'Using widgets instead of text',
        ),
        ItemTitle(
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
                      builder: (context) => Text(
                        'Tree collapse',
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                    nodes: [
                      TreeNode.child(
                        titleBuilder: (context) => Row(
                          children: const [
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
                        titleBuilder: (context) => Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.place),
                            ),
                            Text('Node 1'),
                          ],
                        ),
                        children: [
                          TreeNode.child(
                            titleBuilder: (context) => Row(
                              children: const [
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
                            titleBuilder: (context) => Row(
                              children: const [
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
                        titleBuilder: (context) => Row(
                          children: const [
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
          codeText: codeSampleCollapse,
          height: 600.0,
          title: 'Collapsible tree',
        ),
      ],
      header: 'Tree',
    );
  }
}
