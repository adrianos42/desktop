import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TabPage extends StatefulWidget {
  TabPage({Key? key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  IndexedWidgetBuilder _createCustomTab(String title, IconData icon) {
    return (context, _) {
      final textTheme = Theme.of(context).textTheme;
      final colorScheme = Theme.of(context).colorScheme;
      final buttonScope = ButtonScope.of(context)!;

      final foreground = colorScheme.shade[100];
      final Color background = buttonScope.active
          ? colorScheme.background[0]
          : buttonScope.pressed
              ? colorScheme.background[0]
              : buttonScope.hovered
                  ? colorScheme.shade[30]
                  : colorScheme.background[10];

      return Container(
        alignment: Alignment.center,
        color: background,
        padding: EdgeInsets.symmetric(
          horizontal: TabTheme.of(context).itemSpacing!,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: textTheme.body2.copyWith(color: foreground),
              ),
            ),
            Icon(
              icon,
              color: foreground,
            ),
          ],
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    const codeSample = '''
Tab(
  items: [
    TabItem.text('page 0',
      builder: (context, _) => TabView(
        builder: (context) => Center(
          child: Text(
            'page 0',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    ),
    TabItem.text('page 1',
      builder: (context, _) => TabView(
        builder: (context) => Center(
          child: Text(
            'page 1',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    ),
    TabItem.text('page 2',
      builder: (context, _) => TabView(
        builder: (context) => Center(
          child: Text(
            'page 2',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    ),
  ],
)
''';

    const customCodeSample = '''
Tab(
  itemPadding: EdgeInsets.zero,
  backgroundColor: Theme.of(context).colorScheme.background[10],
  items: [
    TabItem(
      itemBuilder: _createCustomTab('camera', Icons.camera),
      builder: (context, _) => Center(
        child: Text(
          'camera page',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: _createCustomTab('computer', Icons.computer),
      builder: (context, _) => Center(
        child: Text(
          'computer page',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: _createCustomTab('map', Icons.map),
      builder: (context, _) => Center(
        child: Text(
          'map page',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: _createCustomTab('cloud', Icons.cloud),
      builder: (context, _) => Center(
        child: Text(
          'cloud page',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
  ],
);''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) {
            return Tab(
              items: [
                TabItem(
                  itemBuilder: (context, _) => const Text('page 0'),
                  builder: (context, _) => Center(
                    child: Text(
                      'page 0',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: (context, _) => const Text('page 1'),
                  builder: (context, _) => Center(
                    child: Text(
                      'page 1',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: (context, _) => const Text('page 2'),
                  builder: (context, _) => Center(
                    child: Text(
                      'page 2',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ],
            );
          },
          codeText: codeSample,
          title: 'Basic example',
          height: 600.0,
        ),
        ItemTitle(
          body: (context) {
            return Tab(
              itemPadding: EdgeInsets.zero,
              backgroundColor: Theme.of(context).colorScheme.background[10],
              items: [
                TabItem(
                  itemBuilder: _createCustomTab('camera', Icons.camera),
                  builder: (context, _) => Center(
                    child: Text(
                      'camera page',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: _createCustomTab('computer', Icons.computer),
                  builder: (context, _) => Center(
                    child: Text(
                      'computer page',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: _createCustomTab('map', Icons.map),
                  builder: (context, _) => Center(
                    child: Text(
                      'map page',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: _createCustomTab('cloud', Icons.cloud),
                  builder: (context, _) => Center(
                    child: Text(
                      'cloud page',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ],
            );
          },
          codeText: customCodeSample,
          title: 'Custom tabs',
          height: 600.0,
        ),
      ],
      header: 'Tab',
    );
  }
}
