import 'package:desktop/desktop.dart';

import '../defaults.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool _drawerDismissActive = false;

  @override
  Widget build(BuildContext context) {
    const dismissableDrawer = '''
return Button.text(
  'Open drawer',
  active: _drawerDismissActive,
  onPressed: () async {
    setState(() => _drawerDismissActive = true);

    final drawer = showDrawer(
      context,
      builder: (context) => const Drawer(
        title: Text('Lorem Ipsum'),
        body: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
      ),
    );

    final _ = await drawer.closed;

    setState(() => _drawerDismissActive = false);
  },
);
''';

    return Defaults(
      styleItems: Defaults.createStyle(DrawerTheme.of(context).toString()),
      items: [
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Open drawer',
              active: _drawerDismissActive,
              onPressed: () async {
                setState(() => _drawerDismissActive = true);

                await Drawer.showDrawer(
                  context,
                  title: const Text('Lorem Ipsum'),
                  actions: [
                    Button.filled('Login', onPressed: () {}),
                    Button.text(
                      'Cancel',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                  body: const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  ),
                );

                setState(() => _drawerDismissActive = false);
              },
            ),
          ),
          codeText: dismissableDrawer,
          title: 'Dismissible drawer',
        ),
      ],
      header: 'Drawer',
    );
  }
}
