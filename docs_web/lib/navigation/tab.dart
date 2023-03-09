import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TabPage extends StatefulWidget {
  TabPage({super.key});

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final _controller = TabController();
  AxisDirection _positionAxis = AxisDirection.left;

  WidgetBuilder _createCustomTab({String? title, IconData? icon}) {
    return (context) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon),
            ),
          if (title != null) Text(title),
        ],
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final textTheme = themeData.textTheme;

    const codeSample = '''
return Tab(
  items: [
    TabItem.text('page 0',
      builder: (context) => Center(
        child: Text(
          'page 0',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
    TabItem.text('page 1',
      builder: (context) => Center(
        child: Text(
          'page 1',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
    TabItem.text('page 2',
      builder: (context) => Center(
        child: Text(
          'page 2',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
  ],
);
''';

    const customCodeSample = '''
return Tab(
  themeData: TabThemeData(
    backgroundColor: Theme.of(context).colorScheme.background[12],
    itemPadding: EdgeInsets.zero,
  ),
  items: [
    TabItem(
      itemBuilder: _createCustomTab('camera', Icons.camera),
      builder: (context) => Center(
        child: Text(
          'camera page',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: _createCustomTab('computer', Icons.computer),
      builder: (context) => Center(
        child: Text(
          'computer page',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: _createCustomTab('map', Icons.map),
      builder: (context) => Center(
        child: Text(
          'map page',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: _createCustomTab('cloud', Icons.cloud),
      builder: (context) => Center(
        child: Text(
          'cloud page',
          style: Theme.of(context).textTheme.title,
        ),
      ),
    ),
  ],
);
''';

    const controlledSample = '''
return Tab(
  controller: _controller,
  items: [
    TabItem.text(
      'camera',
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Button.text('computer',
              onPressed: () => _controller.index = 1),
          Button.text('map',
              onPressed: () => _controller.index = 2),
          Button.text('cloud',
              onPressed: () => _controller.index = 3),
        ],
      ),
    ),
    TabItem.text(
      'computer',
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Button.text('camera',
              onPressed: () => _controller.index = 0),
          Button.text('map',
              onPressed: () => _controller.index = 2),
          Button.text('cloud',
              onPressed: () => _controller.index = 3),
        ],
      ),
    ),
    TabItem.text(
      'map',
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Button.text('camera',
              onPressed: () => _controller.index = 0),
          Button.text('computer',
              onPressed: () => _controller.index = 1),
          Button.text('cloud',
              onPressed: () => _controller.index = 3),
        ],
      ),
    ),
    TabItem.text(
      'cloud',
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Button.text('camera',
              onPressed: () => _controller.index = 0),
          Button.text('computer',
              onPressed: () => _controller.index = 1),
          Button.text('map',
              onPressed: () => _controller.index = 2),
        ],
      ),
    ),
  ],
);
''';

const codeSamplePositioned = '''
return Tab(
  axis: _positionAxis,
  theme: const TabThemeData(
    padding: EdgeInsets.symmetric(
      vertical: 8.0,
    ),
  ),
  trailingMenu: [
    TabMenuItem.text(
      'menu',
      builder: (context) => Container(
        width: 120.0,
        height: 120.0,
        alignment: Alignment.center,
        child: const Text('menu 3'),
      ),
    ),
  ],
  items: [
    TabItem(
      itemBuilder: (context) => const Text('page 0'),
      builder: (context) => Center(
        child: Text(
          'page 0',
          style: textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: (context) => const Text('page 1'),
      builder: (context) => Center(
        child: Text(
          'page 1',
          style: textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: (context) => const Text('page 2'),
      builder: (context) => Center(
        child: Text(
          'page 2',
          style: textTheme.title,
        ),
      ),
    ),
  ],
);
''';

const codeSampleWithMenu = '''
return Tab(
  leadingMenu: [
    TabMenuItem.text(
      'menu 0',
      builder: (context) => Container(
        height: 200.0,
        alignment: Alignment.center,
        child: const Text('menu 0'),
      ),
    ),
    TabMenuItem.text(
      'menu 1',
      builder: (context) => Container(
        height: 400.0,
        alignment: Alignment.center,
        child: const Text('menu 1'),
      ),
    ),
    TabMenuItem.text(
      'menu 2',
      builder: (context) => Container(
        height: 80.0,
        alignment: Alignment.center,
        child: const Text('menu 2'),
      ),
    ),
  ],
  trailingMenu: [
    TabMenuItem.text(
      'menu 3',
      builder: (context) => Container(
        height: 120.0,
        alignment: Alignment.center,
        child: const Text('menu 3'),
      ),
    ),
  ],
  items: [
    TabItem(
      itemBuilder: (context) => const Text('page 0'),
      builder: (context) => Center(
        child: Text(
          'page 0',
          style: textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: (context) => const Text('page 1'),
      builder: (context) => Center(
        child: Text(
          'page 1',
          style: textTheme.title,
        ),
      ),
    ),
    TabItem(
      itemBuilder: (context) => const Text('page 2'),
      builder: (context) => Center(
        child: Text(
          'page 2',
          style: textTheme.title,
        ),
      ),
    ),
  ],
);
''';

    return Defaults(
      styleItems: Defaults.createStyle(TabTheme.of(context).toString()),
      items: [
        ItemTitle(
          title: 'Basic example',
          codeText: codeSample,
          body: (context) {
            return Tab(
              items: [
                TabItem(
                  itemBuilder: (context) => const Text('page 0'),
                  builder: (context) => Center(
                    child: Text(
                      'page 0',
                      style: textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: (context) => const Text('page 1'),
                  builder: (context) => Center(
                    child: Text(
                      'page 1',
                      style: textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: (context) => const Text('page 2'),
                  builder: (context) => Center(
                    child: Text(
                      'page 2',
                      style: textTheme.title,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        ItemTitle(
          title: 'Custom tabs',
          codeText: customCodeSample,
          body: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Tab(
                theme: TabThemeData(
                    itemBackgroundColor: colorScheme.background[12],
                    itemHoverBackgroundColor: colorScheme.shade[30],
                    itemHighlightBackgroundColor: colorScheme.background[0],
                    itemColor: colorScheme.shade[100],
                    tabBarBackgroundColor: colorScheme.background[12],
                    itemFilled: true,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 12.0)),
                trailingMenu: [
                  TabMenuItem(
                    builder: (context) => Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: Text(
                        'settings',
                        style: textTheme.title,
                      ),
                    ),
                    itemBuilder: (context) => Padding(
                      padding: TabTheme.of(context).itemPadding!,
                      child: const Icon(Icons.camera),
                    ),
                  ),
                ],
                items: [
                  TabItem(
                    itemBuilder:
                        _createCustomTab(title: 'camera', icon: Icons.camera),
                    builder: (context) => Center(
                      child: Text(
                        'camera page',
                        style: textTheme.title,
                      ),
                    ),
                  ),
                  TabItem(
                    itemBuilder: _createCustomTab(
                        title: 'computer', icon: Icons.computer),
                    builder: (context) => Center(
                      child: Text(
                        'computer page',
                        style: textTheme.title,
                      ),
                    ),
                  ),
                  TabItem(
                    itemBuilder:
                        _createCustomTab(title: 'map', icon: Icons.map),
                    builder: (context) => Center(
                      child: Text(
                        'map page',
                        style: textTheme.title,
                      ),
                    ),
                  ),
                  TabItem(
                    itemBuilder:
                        _createCustomTab(title: 'cloud', icon: Icons.cloud),
                    builder: (context) => Center(
                      child: Text(
                        'cloud page',
                        style: textTheme.title,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        ItemTitle(
          title: 'Controlled tabs',
          codeText: controlledSample,
          body: (context) {
            return Tab(
              controller: _controller,
              items: [
                TabItem.text(
                  'camera',
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Button.text('computer',
                          onPressed: () => _controller.index = 1),
                      Button.text('map',
                          onPressed: () => _controller.index = 2),
                      Button.text('cloud',
                          onPressed: () => _controller.index = 3),
                    ],
                  ),
                ),
                TabItem.text(
                  'computer',
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Button.text('camera',
                          onPressed: () => _controller.index = 0),
                      Button.text('map',
                          onPressed: () => _controller.index = 2),
                      Button.text('cloud',
                          onPressed: () => _controller.index = 3),
                    ],
                  ),
                ),
                TabItem.text(
                  'map',
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Button.text('camera',
                          onPressed: () => _controller.index = 0),
                      Button.text('computer',
                          onPressed: () => _controller.index = 1),
                      Button.text('cloud',
                          onPressed: () => _controller.index = 3),
                    ],
                  ),
                ),
                TabItem.text(
                  'cloud',
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Button.text('camera',
                          onPressed: () => _controller.index = 0),
                      Button.text('computer',
                          onPressed: () => _controller.index = 1),
                      Button.text('map',
                          onPressed: () => _controller.index = 2),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        ItemTitle(
          title: 'Tab with menu',
          codeText: codeSampleWithMenu,
          body: (context) {
            return Tab(
              leadingMenu: [
                TabMenuItem.text(
                  'menu 0',
                  builder: (context) => Container(
                    height: 200.0,
                    alignment: Alignment.center,
                    child: const Text('menu 0'),
                  ),
                ),
                TabMenuItem.text(
                  'menu 1',
                  builder: (context) => Container(
                    height: 400.0,
                    alignment: Alignment.center,
                    child: const Text('menu 1'),
                  ),
                ),
                TabMenuItem.text(
                  'menu 2',
                  builder: (context) => Container(
                    height: 80.0,
                    alignment: Alignment.center,
                    child: const Text('menu 2'),
                  ),
                ),
              ],
              trailingMenu: [
                TabMenuItem.text(
                  'menu 3',
                  builder: (context) => Container(
                    height: 120.0,
                    alignment: Alignment.center,
                    child: const Text('menu 3'),
                  ),
                ),
              ],
              items: [
                TabItem(
                  itemBuilder: (context) => const Text('page 0'),
                  builder: (context) => Center(
                    child: Text(
                      'page 0',
                      style: textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: (context) => const Text('page 1'),
                  builder: (context) => Center(
                    child: Text(
                      'page 1',
                      style: textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: (context) => const Text('page 2'),
                  builder: (context) => Center(
                    child: Text(
                      'page 2',
                      style: textTheme.title,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        ItemTitle(
          title: 'Positioned tab',
          codeText: codeSamplePositioned,
          options: [
            Button.icon(
              Icons.keyboard_arrow_left,
              onPressed: () => setState(
                () => _positionAxis = AxisDirection.left,
              ),
              active: _positionAxis == AxisDirection.left,
              tooltip: 'left',
            ),
            Button.icon(
              Icons.keyboard_arrow_up,
              onPressed: () => setState(
                () => _positionAxis = AxisDirection.up,
              ),
              active: _positionAxis == AxisDirection.up,
              tooltip: 'up',
            ),
            Button.icon(
              Icons.keyboard_arrow_right,
              onPressed: () => setState(
                () => _positionAxis = AxisDirection.right,
              ),
              active: _positionAxis == AxisDirection.right,
              tooltip: 'right',
            ),
            Button.icon(
              Icons.keyboard_arrow_down,
              onPressed: () => setState(
                () => _positionAxis = AxisDirection.down,
              ),
              active: _positionAxis == AxisDirection.down,
              tooltip: 'down',
            ),
          ],
          body: (context) {
            return Tab(
              axis: _positionAxis,
              theme: const TabThemeData(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
              ),
              trailingMenu: [
                TabMenuItem.text(
                  'menu',
                  builder: (context) => Container(
                    width: 120.0,
                    height: 120.0,
                    alignment: Alignment.center,
                    child: const Text('menu 3'),
                  ),
                ),
              ],
              items: [
                TabItem(
                  itemBuilder: (context) => const Text('page 0'),
                  builder: (context) => Center(
                    child: Text(
                      'page 0',
                      style: textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: (context) => const Text('page 1'),
                  builder: (context) => Center(
                    child: Text(
                      'page 1',
                      style: textTheme.title,
                    ),
                  ),
                ),
                TabItem(
                  itemBuilder: (context) => const Text('page 2'),
                  builder: (context) => Center(
                    child: Text(
                      'page 2',
                      style: textTheme.title,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
      header: 'Tab',
    );
  }
}
