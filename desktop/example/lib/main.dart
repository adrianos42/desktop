import 'package:desktop/desktop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: PrimaryColors.royalBlue.primaryColor,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Tree(
      title: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            'Tree with widgets',
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
          )),
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
              )),
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
          )),
        ),
      ],
    );
  }
}
