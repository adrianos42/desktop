import 'package:desktop/desktop.dart';
import '../defaults.dart';
import 'content.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  bool _verticalContent = false;
  bool _verticalMenuExpanded = false;
  bool _verticalSampleMenu = true;

  bool _horizontaContent = false;
  bool _compactContent = false;

  @override
  Widget build(BuildContext context) {
    const codeVerticalSample = '''
return Nav(
  trailingMenu: [
    NavItem(
      title: 'settings',
      builder: (context) => NavDialog(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32.0),
          width: 600.0,
          child: Text(
            'Settings page',
            style: textTheme.subtitle,
          ),
        ),
      ),
      icon: Icons.settings,
    ),
  ],
  items: [
    NavItem(
      builder: (context) => Center(
          child: Text(
        'page 0',
        style: textTheme.title,
      )),
      title: 'page 0',
      icon: Icons.today,
    ),
    NavItem(
      builder: (context) => Center(
          child: Text(
        'page 1',
        style: textTheme.title,
      )),
      title: 'page 1',
      icon: Icons.stars,
    ),
    NavItem(
      builder: (context) => Center(
          child: Text(
        'page 2',
        style: textTheme.title,
      )),
      title: 'page 2',
      icon: Icons.share,
    ),
  ],
);
''';

    const codeHorizontalSample = '''
return Nav(
  navAxis: Axis.horizontal,
  trailingMenu: [
    NavItem(
      title: 'settings',
      builder: (context) => NavDialog(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32.0),
          height: 100.0,
          child: Text(
            'Settings page',
            style: textTheme.subtitle,
          ),
        ),
      ),
      icon: Icons.settings,
    ),
  ],
  items: [
    NavItem(
      builder: (context) => Center(
          child: Text(
        'page 0',
        style: textTheme.title,
      )),
      title: 'page 0',
      icon: Icons.today,
    ),
    NavItem(
      builder: (context) => Center(
          child: Text(
        'page 1',
        style: textTheme.title,
      )),
      title: 'page 1',
      icon: Icons.stars,
    ),
    NavItem(
      builder: (context) => Center(
          child: Text(
        'page 2',
        style: textTheme.title,
      )),
      title: 'page 2',
      icon: Icons.share,
    ),
  ],
);
''';

    Widget floatingMenu(
      BuildContext context, {
      required String? title,
      required int? index,
      required bool visible,
      required bool expanded,
    }) =>
        FloatingMenuBar(
          visible: visible,
          expanded: expanded,
          items: [
            Button.icon(
              Icons.arrowUpward,
              onPressed: () {},
            ),
            Button.icon(
              Icons.arrowDownward,
              onPressed: () {},
            ),
            Button.icon(
              Icons.selectAll,
              onPressed: () async {
                await Drawer.showDrawer(
                  context,
                  title: const Text('Lorem Ipsum'),
                  body: const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                );
              },
            ),
            Button.icon(
              Icons.share,
              onPressed: () async {
                await Dialog.showDialog(
                  context,
                  title: const Text('Lorem Ipsum'),
                  body: const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                );
              },
            ),
          ].map((e) => FloatingMenuItem(icon: (context) => e)).toList(),
          trailingMenu: Text(title ?? 'Page ${index ?? 0}'),
        );

    return Defaults(
      styleItems: Defaults.createStyle(NavTheme.of(context).toString()),
      items: [
        ItemTitle(
          title: 'Vertical example',
          body: (context) {
            return Theme.withBrightness(
              context,
              brightness: _verticalContent ? Brightness.light : Brightness.dark,
              child: Nav.vertical(
                trailingMenu: [
                  NavMenuItem(
                    builder: (context) => TabDialog(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(32.0),
                        width: 400.0,
                        child: Text(
                          'Settings page',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                    ),
                    icon: (context) => const Icon(Icons.settings),
                    title: 'Settings',
                  ),
                ],
                contentMenu: (context) => floatingMenu(
                  context,
                  title: 'Page',
                  index: 0,
                  expanded: _verticalMenuExpanded,
                  visible: _verticalSampleMenu,
                ),
                items: [
                  NavItem(
                    title: 'First Page',
                    builder: (context, _) => const PageOne(index: 0),
                    iconBuilder: (context) => const Icon(Icons.barChart),
                  ),
                  NavItem(
                    title: 'Second Page',
                    builder: (context, _) => const PageOne(index: 1),
                    iconBuilder: (context) => const Icon(Icons.pieChart),
                  ),
                  NavItem(
                    title: 'Third Page',
                    builder: (context, _) => const PageOne(index: 2),
                    iconBuilder: (context) => const Icon(Icons.collections),
                  ),
                  NavItem(
                    title: 'Fourth Page',
                    builder: (context, _) => const PageOne(index: 3),
                    iconBuilder: (context) => const Icon(Icons.musicNote),
                  ),
                ],
              ),
            );
          },
          codeText: codeVerticalSample,
          options: [
            Button.icon(
              Icons.lightMode,
              tooltip: 'Toggle content mode',
              active: _verticalContent,
              onPressed: () => setState(
                () => _verticalContent = !_verticalContent,
              ),
            ),
            Button.icon(
              Icons.build,
              tooltip: 'Toggle floating menu bar',
              active: _verticalSampleMenu,
              onPressed: () => setState(
                () => _verticalSampleMenu = !_verticalSampleMenu,
              ),
            ),
            Button(
              trailing: const RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.expand),
              ),
              tooltip: 'Expand floating menu bar',
              active: _verticalMenuExpanded,
              onPressed: _verticalSampleMenu
                  ? () => setState(
                        () => _verticalMenuExpanded = !_verticalMenuExpanded,
                      )
                  : null,
            ),
          ],
        ),
        ItemTitle(
          title: 'Horizontal example',
          body: (context) {
            return Theme.withBrightness(
              context,
              brightness:
                  _horizontaContent ? Brightness.light : Brightness.dark,
              child: Nav.horizontal(
                infoItems: [
                  NavInfoItem(
                    builder: (context) => TabDialog(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(32.0),
                        height: 100.0,
                        child: Text(
                          'Maps page',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                    ),
                    icon: (context) => const Center(
                      child: Text('Maps'),
                    ),
                  ),
                  NavInfoItem(
                    builder: (context) => TabDialog(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(32.0),
                        height: 200.0,
                        child: Text(
                          'Info page',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                    ),
                    icon: (context) => const Center(
                      child: Text('Info'),
                    ),
                  ),
                ],
                trailingMenu: [
                  NavMenuItem(
                    builder: (context) => TabDialog(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(32.0),
                        width: 200.0,
                        child: Text(
                          'Settings page',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                    ),
                    axis: AxisDirection.right,
                    icon: (context) => const Icon(Icons.settings),
                  ),
                ],
                items: [
                  NavItem(
                    title: 'Page 0',
                    builder: (context, _) => const TabDialog(
                      child: PageOne(index: 5),
                    ),
                  ),
                  NavItem(
                    title: 'Page 1',
                    builder: (context, _) => const TabDialog(
                      child: PageOne(index: 4),
                    ),
                  ),
                  NavItem(
                    title: 'Page 2',
                    builder: (context, _) => const TabDialog(
                      child: PageOne(index: 3),
                    ),
                  ),
                ],
              ),
            );
          },
          codeText: codeHorizontalSample,
          options: [
            Button.icon(
              Icons.lightMode,
              active: _horizontaContent,
              onPressed: () => setState(
                () => _horizontaContent = !_horizontaContent,
              ),
            ),
          ],
        ),
        ItemTitle(
          title: 'Compact example',
          body: (context) {
            return Theme.withBrightness(
              context,
              brightness: _compactContent ? Brightness.light : Brightness.dark,
              child: Nav.compact(
                trailingMenu: [
                  NavMenuItem(
                    builder: (context) => TabDialog(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(32.0),
                        width: 400.0,
                        child: Text(
                          'Settings page',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                    ),
                    title: 'Settings',
                    icon: (context) => const Icon(Icons.settings),
                  ),
                ],
                items: [
                  NavItem(
                    title: 'First Page',
                    builder: (context, _) => const PageOne(index: 0),
                    iconBuilder: (context) => const Icon(Icons.barChart),
                  ),
                  NavItem(
                    title: 'Second Page',
                    builder: (context, _) => const PageOne(index: 1),
                    iconBuilder: (context) => const Icon(Icons.pieChart),
                  ),
                  NavItem(
                    title: 'Third Page',
                    builder: (context, _) => const PageOne(index: 2),
                    iconBuilder: (context) => const Icon(Icons.collections),
                  ),
                  NavItem(
                    title: 'Fourth Page',
                    builder: (context, _) => const PageOne(index: 3),
                    iconBuilder: (context) => const Icon(Icons.musicNote),
                  ),
                ],
              ),
            );
          },
          codeText: codeVerticalSample,
          options: [
            Button.icon(
              Icons.lightMode,
              active: _compactContent,
              onPressed: () => setState(
                () => _compactContent = !_compactContent,
              ),
            ),
          ],
        ),
      ],
      header: 'Nav',
    );
  }
}
