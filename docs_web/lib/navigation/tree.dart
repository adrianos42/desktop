import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TreePage extends StatefulWidget {
  TreePage({Key? key}) : super(key: key);

  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  @override
  Widget build(BuildContext context) {
    final codeSample = '''
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

    return Column(
      children: [
        Defaults.createHeader(context, 'Tree'),
        Expanded(
          child: Defaults.createCodeSession(
            context,
            builder: (context) {
              return Tree(
                title: Builder(
                  builder: (context) => Text(
                    'Tree',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                nodes: [
                  TreeNode(
                    'Node 0',
                    builder: (context) => Center(
                        child: Text(
                      'Node 0',
                      style: Theme.of(context).textTheme.title,
                    )),
                  ),
                  TreeNode('Node 1', children: [
                    TreeNode(
                      'Node 0',
                      builder: (context) => Center(
                          child: Text(
                        'Node 1 -> 0',
                        style: Theme.of(context).textTheme.title,
                      )),
                    ),
                    TreeNode(
                      'Node 1',
                      builder: (context) => Center(
                          child: Text(
                        'Node 1 -> 1',
                        style: Theme.of(context).textTheme.title,
                      )),
                    ),
                    TreeNode(
                      'Node 2',
                      builder: (context) => Center(
                          child: Text(
                        'Node 1 -> 2',
                        style: Theme.of(context).textTheme.title,
                      )),
                    ),
                    TreeNode('Node3', children: [
                      TreeNode(
                        'Node 0',
                        builder: (context) => Center(
                            child: Text(
                          'Node 1 -> 3 -> 0',
                          style: Theme.of(context).textTheme.title,
                        )),
                      ),
                      TreeNode(
                        'Node 1',
                        builder: (context) => Center(
                            child: Text(
                          'Node 1 -> 3 -> 1',
                          style: Theme.of(context).textTheme.title,
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
                      style: Theme.of(context).textTheme.title,
                    )),
                  ),
                  TreeNode('Node 3', children: [
                    TreeNode(
                      'Node 0',
                      builder: (context) => Center(
                          child: Text(
                        'Node 3 -> 0',
                        style: Theme.of(context).textTheme.title,
                      )),
                    ),
                    TreeNode(
                      'Node 1',
                      builder: (context) => Center(
                          child: Text(
                        'Node 3 -> 1',
                        style: Theme.of(context).textTheme.title,
                      )),
                    ),
                    // TreeNode('Breadcrumb',
                    //     builder: (context) => BreadcrumbPage()),
                  ]),
                ],
              );
            },
            codeText: codeSample,
          ),
        ),
      ],
    );
  }
}
