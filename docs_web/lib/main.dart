import 'dart:ui';
import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defaults.dart';
import 'data/list_table.dart';
import 'navigation/tree.dart';
import 'dialogs/dialog.dart';
import 'input/button.dart';
import 'input/button_context_menu.dart';
import 'input/button_drop_down.dart';
import 'input/button_hyperlink.dart';
import 'input/button_icon.dart';
import 'input/button_radio.dart';
import 'input/button_text.dart';
import 'input/checkbox.dart';
import 'input/toggle_switch.dart';
import 'input/slider.dart';
import 'navigation/nav.dart';
import 'navigation/tab.dart';
import 'navigation/breadcrumb.dart';
import 'status/progress_indicator.dart';
import 'status/tooltip.dart';
import 'text/text_field.dart';
import 'scrolling.dart';
import 'typography.dart';
import 'colorscheme.dart';

void main() => runApp(DocApp());

class DocApp extends StatefulWidget {
  DocApp({Key? key}) : super(key: key);

  @override
  _DocAppState createState() => _DocAppState();
}

class _DocAppState extends State<DocApp> {
  ThemeData _themeData = ThemeData(brightness: Brightness.dark);
  ThemeData get themeData =>
      ThemeData(brightness: _themeData.brightness, primaryColor: primaryColor);

  static ContextMenuItem<PrimaryColor> _menuItemPrimaryColor(
      PrimaryColor color) {
    return ContextMenuItem(
      child: Text(color.toString()),
      value: color,
    );
  }

  PrimaryColor primaryColor = PrimaryColor.dodgerBlue;

  double backgroundColorLightness = 0.0;

  Widget _createHome() {
    final githubImage;
    if (themeData.brightness == Brightness.dark) {
      githubImage = Image.asset(
        'assets/GitHub-Mark-Light-32px.png',
        width: 19.0,
        height: 19.0,
      );
    } else {
      githubImage = Image.asset(
        'assets/GitHub-Mark-32px.png',
        width: 19.0,
        height: 19.0,
      );
    }

    return Builder(
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Builder(
                    builder: (context) {
                      return Text(
                        'Desktop',
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .primary[70]
                                .toColor()),
                      );
                    },
                  ),
                ),
                Spacer(),
                Container(
                  width: 200.0,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropDownButtonTheme.merge(
                    data: DropDownButtonThemeData(
                      color: Theme.of(context).textTheme.textPrimaryLow,
                      hoverColor: Theme.of(context).textTheme.textPrimaryHigh,
                    ),
                    child: DropDownButton<PrimaryColor>(
                      value: primaryColor,
                      onSelected: (PrimaryColor value) {
                        setState(() => primaryColor = value);
                      },
                      itemBuilder: (context) => [
                        _menuItemPrimaryColor(PrimaryColor.coral),
                        _menuItemPrimaryColor(PrimaryColor.sandyBrown),
                        _menuItemPrimaryColor(PrimaryColor.orange),
                        _menuItemPrimaryColor(PrimaryColor.goldenrod),
                        _menuItemPrimaryColor(PrimaryColor.springGreen),
                        _menuItemPrimaryColor(PrimaryColor.turquoise),
                        _menuItemPrimaryColor(PrimaryColor.deepSkyBlue),
                        _menuItemPrimaryColor(PrimaryColor.dodgerBlue),
                        _menuItemPrimaryColor(PrimaryColor.cornflowerBlue),
                        _menuItemPrimaryColor(PrimaryColor.royalBlue),
                        _menuItemPrimaryColor(PrimaryColor.slateBlue),
                        _menuItemPrimaryColor(PrimaryColor.purple),
                        _menuItemPrimaryColor(PrimaryColor.violet),
                        _menuItemPrimaryColor(PrimaryColor.orchid),
                        _menuItemPrimaryColor(PrimaryColor.hotPink),
                        _menuItemPrimaryColor(PrimaryColor.red),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      ThemeToggle(
                        onPressed: () => setState(
                            () => _themeData = Theme.invertedThemeOf(context)),
                      ),
                      Button(
                        body: githubImage,
                        onPressed: () async {
                          final urlRepository =
                              'https://github.com/adrianos42/desktop';
                          if (await canLaunch(urlRepository)) {
                            await launch(urlRepository);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Tree(
                pagePadding: EdgeInsets.only(left: 8.0),
                title: Builder(
                  builder: (context) => Text(
                    'Documentation',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                nodes: [
                  TreeNode.child(
                    'Overview',
                    //builder: (context) => ScrollingPage(),
                    builder: (context) => OverviewPage(),
                  ),
                  TreeNode.children('Navigation', children: [
                    TreeNode.child('Breadcrumb',
                        builder: (context) => BreadcrumbPage()),
                    TreeNode.child('Nav', builder: (context) => NavPage()),
                    TreeNode.child('Tab', builder: (context) => TabPage()),
                    TreeNode.child('Tree', builder: (context) => TreePage()),
                  ]),
                  TreeNode.children('Data', children: [
                    TreeNode.child('List Table',
                        builder: (context) => ListTablePage()),
                  ]),
                  TreeNode.children('Dialogs', children: [
                    TreeNode.child('Dialog',
                        builder: (context) => DialogPage()),
                  ]),
                  TreeNode.children('Input', children: [
                    TreeNode.child(
                      'Button',
                      builder: (context) => ButtonPage(),
                    ),
                    TreeNode.child(
                      'Context menu',
                      builder: (context) => ButtonContextMenuPage(),
                    ),
                    TreeNode.child(
                      'Drop down menu',
                      builder: (context) => ButtonDropDownPage(),
                    ),
                    TreeNode.child(
                      'Icon button',
                      builder: (context) => ButtonIconPage(),
                    ),
                    TreeNode.child(
                      'Text button',
                      builder: (context) => ButtonTextPage(),
                    ),
                    // TreeNode(
                    //   'Toggle button',
                    //   builder: (context) => ButtonTogglePage(),
                    // ),
                    TreeNode.child(
                      'Hyperlink',
                      builder: (context) => ButtonHyperlinkPage(),
                    ),
                    TreeNode.child(
                      'Slider',
                      builder: (context) => SliderPage(),
                    ),
                    TreeNode.child(
                      'Checkbox',
                      builder: (context) => CheckboxPage(),
                    ),
                    TreeNode.child(
                      'Radio',
                      builder: (context) => ButtonRadioPage(),
                    ),
                    TreeNode.child(
                      'Toggle switch',
                      builder: (context) => ToggleSwitchPage(),
                    ),
                  ]),
                  TreeNode.children('Status', children: [
                    TreeNode.child(
                      'Progress indicator',
                      builder: (context) => ProgressIndicatorPage(),
                    ),
                    // TreeNode.view(
                    //   'Status bar',
                    //   builder: (context) => StatusBarPage(),
                    // ),
                    TreeNode.child(
                      'Tooltip',
                      builder: (context) => TooltipPage(),
                    ),
                  ]),
                  TreeNode.children('Text', children: [
                    TreeNode.child(
                      'Text field',
                      builder: (context) => TextFieldPage(),
                    ),
                  ]),
                  TreeNode.child(
                    'Scrolling',
                    builder: (context) => ScrollingPage(),
                  ),
                  TreeNode.child(
                    'Typography',
                    builder: (context) => TypographyPage(),
                  ),
                  TreeNode.child(
                    'Color Scheme',
                    builder: (context) => ColorschemePage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DesktopApp(
      home: FocusTraversalGroup(
        policy: ReadingOrderTraversalPolicy(), // TODO(as): Set default focus.
        child: _createHome(),
      ),
      theme: themeData,
    );
  }
}

class ThemeToggle extends StatefulWidget {
  ThemeToggle({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  _ThemeToggleState createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final iconForeground = themeData.textTheme.textHigh;
    switch (themeData.brightness) {
      case Brightness.dark:
        return Button(
          onPressed: widget.onPressed,
          body: Icon(
            IconData(0x61, fontFamily: 'mode'),
            color: iconForeground.toColor(),
          ),
        );
      case Brightness.light:
        return Button(
          onPressed: widget.onPressed,
          body: Icon(
            IconData(0x62, fontFamily: 'mode'),
            color: iconForeground.toColor(),
          ),
        );
    }
  }
}

// TODO(as): Move this class to its own file.
class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Defaults.createHeader(context, 'Overview'),
          // Text.rich(
          //   TextSpan(
          //     children: [
          //       TextSpan(
          //           style: Theme.of(context).textTheme.body1.copyWith(),
          //           text: 'Flutter wigdets for desktop usage'),
          //     ],
          //   ),
          // ),
          // Defaults.createTitle(context, 'Resources'),
          // HyperlinkButton(
          //   'Github',
          //   onPressed: (_) async {
          //     final link = 'https://github.com/adrianos42/desktop';
          //     if (await canLaunch(link)) {
          //       await launch(link);
          //     }
          //   },
          // ),
          // HyperlinkButton(
          //   'Figma',
          //   onPressed: (_) async {
          //     final link =
          //         'https://www.figma.com/file/WQCf5O9Jh7cLtOY4zRDL0U/Model?node-id=2%3A0';
          //     if (await canLaunch(link)) {
          //       await launch(link);
          //     }
          //   },
          // ),
          Defaults.createTitle(context, 'Flutter resources'),
          HyperlinkButton(
            'Desktop support for Flutter',
            onPressed: (_) async {
              final link = 'https://flutter.dev/desktop';
              if (await canLaunch(link)) {
                await launch(link);
              }
            },
          ),
          HyperlinkButton(
            'Build and release a Linux app',
            onPressed: (_) async {
              final link = 'https://flutter.dev/docs/deployment/linux';
              if (await canLaunch(link)) {
                await launch(link);
              }
            },
          ),
          HyperlinkButton(
            'Build and release a web app',
            onPressed: (_) async {
              final link = 'https://flutter.dev/docs/deployment/web';
              if (await canLaunch(link)) {
                await launch(link);
              }
            },
          ),
        ],
      ),
    );
  }
}
