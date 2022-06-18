import 'package:desktop/desktop.dart';
import '../defaults.dart';

class BottomNavPage extends StatefulWidget {
  BottomNavPage({Key? key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  @override
  Widget build(BuildContext context) {
    const codeVerticalSample = '''
BottomNav(
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

    return BottomNav(
      trailingMenu: NavItem(
        title: 'settings',
        builder: (context, _) => TabDialog(
          child: Container(
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.primary[30],
            child: Text(
              'Settings page',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
        ),
        icon: Icons.settings,
      ),
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

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) {
            return BottomNav(
              trailingMenu: NavItem(
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
      ],
      header: 'Nav',
    );
  }
}
