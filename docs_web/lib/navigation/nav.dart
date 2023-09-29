import 'package:desktop/desktop.dart';
import '../defaults.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
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

    return Defaults(
      styleItems: Defaults.createStyle(NavTheme.of(context).toString()),
      items: [
        ItemTitle(
          body: (context) {
            return Nav(
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
                ),
              ],
              items: [
                NavItem(
                  builder: (context, _) => Center(
                      child: Text(
                    'page 0',
                    style: Theme.of(context).textTheme.title,
                  )),
                  title: 'page 0',
                  icon: Icons.today,
                ),
                NavItem(
                  builder: (context, _) => Center(
                      child: Text(
                    'page 1',
                    style: Theme.of(context).textTheme.title,
                  )),
                  title: 'page 1',
                  icon: Icons.stars,
                ),
                NavItem(
                  builder: (context, _) => Center(
                      child: Text(
                    'page 2',
                    style: Theme.of(context).textTheme.title,
                  )),
                  title: 'page 2',
                  icon: Icons.share,
                ),
              ],
            );
          },
          codeText: codeVerticalSample,
          title: 'Vertical example',
        ),
        ItemTitle(
          body: (context) {
            return Nav(
              navAxis: Axis.horizontal,
              trailingMenu: [
                NavMenuItem(
                  builder: (context) => TabDialog(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(32.0),
                      height: 100.0,
                      child: Text(
                        'Settings page',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                  ),
                  icon: (context) => const Icon(Icons.settings),
                ),
              ],
              items: [
                NavItem(
                  builder: (context, _) => Center(
                      child: Text(
                    'page 0',
                    style: Theme.of(context).textTheme.title,
                  )),
                  title: 'page 0',
                  icon: Icons.today,
                ),
                NavItem(
                  builder: (context, _) => Center(
                      child: Text(
                    'page 1',
                    style: Theme.of(context).textTheme.title,
                  )),
                  title: 'page 1',
                  icon: Icons.stars,
                ),
                NavItem(
                  builder: (context, _) => Center(
                      child: Text(
                    'page 2',
                    style: Theme.of(context).textTheme.title,
                  )),
                  title: 'page 2',
                  icon: Icons.share,
                ),
              ],
            );
          },
          codeText: codeHorizontalSample,
          title: 'Horizontal example',
        )
      ],
      header: 'Nav',
    );
  }
}
