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
    return Column(
      children: [
        Defaults.createHeader(context, 'Tree'),
        Expanded(
          child: Tree(
            title: Builder(
              builder: (context) => Text(
                'Tree',
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            nodes: [
              TreeNode(
                'Node0',
                builder: (context) => Text('Node0'),
              ),
              TreeNode('Node1', children: [
                TreeNode(
                  'Node0',
                  builder: (context) => Text('Node0'),
                ),
                TreeNode(
                  'Node1',
                  builder: (context) => Text('Node1'),
                ),
                TreeNode(
                  'Node2',
                  builder: (context) => Text('Node2'),
                ),
                TreeNode('Node3', children: [
                  TreeNode(
                    'Node0',
                    builder: (context) => Text('Node0'),
                  ),
                  TreeNode(
                    'Node1',
                    builder: (context) => Text('Node1'),
                  ),
                  // TreeNode('Breadcrumb',
                  //     builder: (context) => BreadcrumbPage()),
                ]),
                // TreeNode('Breadcrumb',
                //     builder: (context) => BreadcrumbPage()),
              ]),
              TreeNode(
                'Node2',
                builder: (context) => Text('Node2'),
              ),
              TreeNode('Node3', children: [
                TreeNode(
                  'Node0',
                  builder: (context) => Text('Node0'),
                ),
                TreeNode(
                  'Node1',
                  builder: (context) => Text('Node1'),
                ),
                // TreeNode('Breadcrumb',
                //     builder: (context) => BreadcrumbPage()),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
