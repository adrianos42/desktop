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

    final colorScheme = Theme.of(context).colorScheme;
    final wColor = colorScheme.background[0];

    return BottomNav(
      trailingMenu: NavItem(
        title: 'settings',
        builder: (context, _) => TabDialog(
          child: Container(
            alignment: Alignment.topCenter,
            color: Theme.of(context).colorScheme.primary[30],
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Menu',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: wColor,
                          height: 80,
                          margin: const EdgeInsets.only(
                              top: 24.0, left: 12.0, right: 12.0),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Icon(
                                  Icons.nights_stay,
                                  color:
                                      Theme.of(context).colorScheme.shade[100],
                                ),
                              ),
                              const Text('Weather'),
                            ],
                          ),
                        ),
                        Container(
                          color: wColor,
                          margin: const EdgeInsets.only(
                              top: 12.0, left: 12.0, right: 12.0),
                          height: 80,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Icon(
                                  Icons.account_balance,
                                  color:
                                      Theme.of(context).colorScheme.shade[100],
                                ),
                              ),
                              const Text('Money'),
                            ],
                          ),
                        ),
                        Container(
                          color: wColor,
                          margin: const EdgeInsets.only(
                              top: 12.0, left: 12.0, right: 12.0),
                          height: 160,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Icon(
                                  Icons.skip_previous,
                                  color:
                                      Theme.of(context).colorScheme.shade[100],
                                  size: 32.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Icon(
                                  Icons.play_arrow,
                                  color:
                                      Theme.of(context).colorScheme.shade[100],
                                  size: 48.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Icon(
                                  Icons.skip_next,
                                  color:
                                      Theme.of(context).colorScheme.shade[100],
                                  size: 32.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ButtonTheme.copyWith(
                    color: colorScheme.shade[100],
                    highlightColor: colorScheme.primary[70],
                    hoverColor: colorScheme.shade[60],
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, bottom: 8.0),
                          child: Button(
                            leading: const Icon(Icons.help),
                            body: const Text('Frequently asked...'),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, bottom: 8.0),
                          child: Button(
                            leading: const Icon(Icons.message),
                            body: const Text('Feedback'),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, bottom: 8.0),
                          child: Button(
                            leading: const Icon(Icons.exit_to_app),
                            body: const Text('Exit App'),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        icon: Icons.settings,
      ),
      items: [
        NavItem(
          builder: (context, _) => Center(
              child: Text(
            'calendar',
            style: Theme.of(context).textTheme.title,
          )),
          title: 'Schedule',
          icon: Icons.today,
        ),
        NavItem(
          builder: (context, _) => Center(
              child: Text(
            'page 1',
            style: Theme.of(context).textTheme.title,
          )),
          title: 'Travel',
          icon: Icons.wallet_travel,
        ),
        NavItem(
          builder: (context, _) => Center(
              child: Text(
            'page 2',
            style: Theme.of(context).textTheme.title,
          )),
          title: 'Article',
          icon: Icons.article,
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
