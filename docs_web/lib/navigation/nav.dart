import 'package:desktop/desktop.dart';
import '../defaults.dart';

class NavPage extends StatefulWidget {
  NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  @override
  Widget build(BuildContext context) {
    const codeVerticalSample = '''
Nav(
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
  ),
  codeText: codeSample,
)
''';

    const codeHorizontalSample = '''
Nav(
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
)
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) {
            return Nav(
              trailingMenu: [
                NavItem(
                  title: 'settings',
                  builder: (context, _) => TabDialog(
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
                  icon: Icons.settings,
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
          height: 600.0,
        ),
        ItemTitle(
          body: (context) {
            return Nav(
              navAxis: Axis.horizontal,
              trailingMenu: [
                NavItem(
                  title: 'settings',
                  builder: (context, _) => TabDialog(
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
                  icon: Icons.settings,
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
          height: 600.0,
        )
      ],
      header: 'Nav',
    );
  }
}
