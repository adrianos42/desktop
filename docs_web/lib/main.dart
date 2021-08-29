import 'dart:ui';
import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'defaults.dart';
import 'data/data.dart';
import 'navigation/navigation.dart';
import 'dialogs/dialogs.dart';
import 'input/input.dart';
import 'status/status.dart';
import 'text/text.dart';
import 'scrolling.dart';
import 'typography.dart';
import 'colorscheme.dart';
import 'overview.dart';

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

  bool isShowingTree = false;

  Widget _createColorButton() {
    final itemBuilder = (context) => [
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
        ];

    return Builder(
      builder: (context) => ButtonTheme.merge(
        data: ButtonThemeData(
          color: Theme.of(context).textTheme.textPrimaryHigh,
          highlightColor: ButtonTheme.of(context).color,
        ),
        child: ContextMenuButton(
          Icon(Icons.palette),
          itemBuilder: itemBuilder,
          value: primaryColor,
          onSelected: (PrimaryColor value) {
            setState(() => primaryColor = value);
          },
        ),
      ),
    );
  }

  Widget _createHome() {
    return Builder(builder: (context) {
      final orientation = MediaQuery.maybeOf(context)?.orientation;

      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (orientation == Orientation.portrait)
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Button.icon(
                      Icons.menu,
                      color: isShowingTree
                          ? ButtonTheme.of(context).highlightColor
                          : null,
                      hoverColor: isShowingTree
                          ? ButtonTheme.of(context).highlightColor
                          : null,
                      size: 22,
                      onPressed: () =>
                          setState(() => isShowingTree = !isShowingTree),
                    ),
                  ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Builder(
                    builder: (context) {
                      return Text(
                        'Desktop',
                        style: Theme.of(context).textTheme.title.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary[70]
                                  .toColor(),
                            ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Builder(
                    builder: (context) {
                      return Text(
                        'dev.9.3',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(overflow: TextOverflow.ellipsis),
                      );
                    },
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      _createColorButton(),
                      ThemeToggle(
                        onPressed: () => setState(
                            () => _themeData = Theme.invertedThemeOf(context)),
                      ),
                      Builder(builder: (context) {
                        final githubImage;
                        if (themeData.brightness == Brightness.dark) {
                          githubImage = Image.asset(
                            'assets/GitHub-Mark-Light-32px.png',
                            width: 18.0,
                            height: 18.0,
                          );
                        } else {
                          githubImage = Image.asset(
                            'assets/GitHub-Mark-32px.png',
                            width: 18.0,
                            height: 18.0,
                          );
                        }

                        return Button(
                          body: githubImage,
                          onPressed: () async {
                            final urlRepository =
                                'https://github.com/adrianos42/desktop';
                            if (await canLaunch(urlRepository)) {
                              await launch(urlRepository);
                            }
                          },
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Tree(
                collapsed: orientation == Orientation.portrait,
                visible: isShowingTree,
                title: Builder(
                  builder: (context) => Text(
                    'Documentation',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                nodes: [
                  TreeNode.child(
                    'Overview',
                    builder: (context) => OverviewPage(),
                    ////builder: (context) => TextFieldPage(),
                    /// builder: (context) => NavPage(),
                    //builder: (context) => ButtonGroupPage(),
                  ),
                  TreeNode.children('Navigation', children: [
                    TreeNode.child('Breadcrumb',
                        builder: (context) => BreadcrumbPage()),
                    TreeNode.child('Nav', builder: (context) => NavPage()),
                    TreeNode.child('Tab', builder: (context) => TabPage()),
                    TreeNode.child('Tree', builder: (context) => TreePage()),
                  ]),
                  TreeNode.children('Data', children: [
                    TreeNode.child('List table',
                        builder: (context) => ListTablePage()),
                  ]),
                  TreeNode.children('Dialogs', children: [
                    TreeNode.child('Dialog',
                        builder: (context) => DialogPage()),
                    TreeNode.child('Message',
                        builder: (context) => DialogMessagePage()),
                    TreeNode.child(
                      'Tooltip',
                      builder: (context) => TooltipPage(),
                    ),
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
                    'Color scheme',
                    builder: (context) => ColorschemePage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
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
        return Button.icon(
          Icons.dark_mode,
          onPressed: widget.onPressed,
          color: iconForeground,
        );
      case Brightness.light:
        return Button.icon(
          Icons.light_mode,
          onPressed: widget.onPressed,
          color: iconForeground,
        );
    }
  }
}
