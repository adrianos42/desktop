import 'dart:ui';
import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/data.dart';
import 'navigation/navigation.dart';
import 'dialogs/dialogs.dart';
import 'input/input.dart';
import 'status/status.dart';
import 'text/text.dart';
import 'scrolling.dart';
import 'theme/typography.dart';
import 'theme/colorscheme.dart';
import 'theme/primaryColor.dart';
import 'overview.dart';

const String _version = 'dev.4.2';

class DocApp extends StatefulWidget {
  DocApp({Key? key}) : super(key: key);

  @override
  _DocAppState createState() => _DocAppState();
}

class _DocAppState extends State<DocApp> {
  static ContextMenuItem<PrimaryColor> _menuItemPrimaryColor(
    PrimaryColor color,
  ) {
    return ContextMenuItem(
      value: color,
      child: Text(
        color.toString(),
      ),
    );
  }

  PrimaryColor? _primaryColor;

  PrimaryColor get primaryColor =>
      _primaryColor ?? Theme.of(context).colorScheme.primary;

  bool? _isShowingTree;

  Widget _createColorButton() {
    List<ContextMenuItem<PrimaryColor>> itemBuilder(context) => [
          _menuItemPrimaryColor(PrimaryColor.coral),
          _menuItemPrimaryColor(PrimaryColor.sandyBrown),
          _menuItemPrimaryColor(PrimaryColor.orange),
          _menuItemPrimaryColor(PrimaryColor.goldenrod),
          _menuItemPrimaryColor(PrimaryColor.lightGoldenrod),
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
          const Icon(Icons.palette),
          itemBuilder: itemBuilder,
          value: Theme.of(context).colorScheme.primary,
          onSelected: (PrimaryColor value) {
            final themeData = Theme.of(context);
            final colorScheme = themeData.colorScheme;
            _primaryColor = value;

            Theme.updateThemeData(
              context,
              themeData.copyWith(
                colorScheme: ColorScheme(
                  colorScheme.brightness,
                  primary: value,
                ),
              ),
            );
            // setState(() => primaryColor = value);
          },
        ),
      ),
    );
  }

  Widget _createHome() {
    return Builder(builder: (context) {
      final orientation = MediaQuery.maybeOf(context)?.orientation;

      final isShowingTree =
          _isShowingTree ?? orientation == Orientation.landscape;

      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Button.icon(
                    Icons.menu_open,
                    color: isShowingTree
                        ? ButtonTheme.of(context).highlightColor
                        : null,
                    hoverColor: isShowingTree
                        ? ButtonTheme.of(context).highlightColor
                        : null,
                    size: 22,
                    onPressed: () =>
                        setState(() => _isShowingTree = !isShowingTree),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Builder(
                    builder: (context) {
                      return Text(
                        'Desktop',
                        style: Theme.of(context).textTheme.title.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context).colorScheme.primary[70],
                            ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Builder(
                    builder: (context) {
                      return Text(
                        _version,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(overflow: TextOverflow.ellipsis),
                      );
                    },
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      _createColorButton(),
                      _ThemeToggle(
                        onPressed: () => setState(() {
                          final invertedTheme = Theme.of(context).invertedTheme;
                          Theme.updateThemeData(context, invertedTheme);
                        }),
                      ),
                      Builder(builder: (context) {
                        final Image githubImage;
                        if (Theme.of(context).brightness == Brightness.dark) {
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
                            await launchUrl(Uri.parse(
                                'https://github.com/adrianos42/desktop'));
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
                collapsed: !isShowingTree,
                title: Builder(
                  builder: (context) => Text(
                    'Documentation',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                nodes: [
                  TreeNode.child(
                    titleBuilder: (context) => const Text('Overview'),
                    builder: (context) => OverviewPage(),
                    //builder: (context) => ButtonDropDownPage(),
                    //builder: (context) => ListTablePage()
                    /// builder: (context) => NavPage(),
                    //builder: (context) => ButtonGroupPage(),
                    //builder: (context) => ScrollingPage(),
                  ),
                  TreeNode.children(
                      titleBuilder: (context) => const Text('Navigation'),
                      children: [
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Breadcrumb'),
                          builder: (context) => BreadcrumbPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Nav'),
                          builder: (context) => NavPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Tab'),
                          builder: (context) => TabPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Tree'),
                          builder: (context) => TreePage(),
                        ),
                      ]),
                  TreeNode.children(
                      titleBuilder: (context) => const Text('Data'),
                      children: [
                        TreeNode.child(
                          titleBuilder: (context) => const Text('List Table'),
                          builder: (context) => ListTablePage(),
                        ),
                      ]),
                  TreeNode.children(
                      titleBuilder: (context) => const Text('Dialogs'),
                      children: [
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Dialog'),
                          builder: (context) => DialogPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Message'),
                          builder: (context) => DialogMessagePage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Tooltip'),
                          builder: (context) => TooltipPage(),
                        ),
                      ]),
                  TreeNode.children(
                      titleBuilder: (context) => const Text('Input'),
                      children: [
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Button'),
                          builder: (context) => ButtonPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Context Menu'),
                          builder: (context) => ButtonContextMenuPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Drop Down Menu'),
                          builder: (context) => ButtonDropDownPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Icon Button'),
                          builder: (context) => ButtonIconPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Text Button'),
                          builder: (context) => ButtonTextPage(),
                        ),
                        // TreeNode(
                        //   'Toggle button',
                        //   builder: (context) => ButtonTogglePage(),
                        // ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Hyperlink'),
                          builder: (context) => ButtonHyperlinkPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Slider'),
                          builder: (context) => SliderPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Checkbox'),
                          builder: (context) => CheckboxPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Radio'),
                          builder: (context) => ButtonRadioPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Toggle Switch'),
                          builder: (context) => ToggleSwitchPage(),
                        ),
                      ]),
                  TreeNode.children(
                      titleBuilder: (context) => const Text('Status'),
                      children: [
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Progress Indicator'),
                          builder: (context) => ProgressIndicatorPage(),
                        ),
                      ]),
                  TreeNode.children(
                      titleBuilder: (context) => const Text('Text'),
                      children: [
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Text Field'),
                          builder: (context) => TextFieldPage(),
                        ),
                      ]),
                  TreeNode.children(
                      titleBuilder: (context) => const Text('Theme'),
                      children: [
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Typography'),
                          builder: (context) => TypographyPage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Color Scheme'),
                          builder: (context) => ColorschemePage(),
                        ),
                        TreeNode.child(
                          titleBuilder: (context) => const Text('Primary Colors'),
                          builder: (context) => PrimaryColorPage(),
                        ),
                      ]),
                  TreeNode.child(
                    titleBuilder: (context) => const Text('Scrolling'),
                    builder: (context) => ScrollingPage(),
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
    return _createHome();
  }
}

class _ThemeToggle extends StatefulWidget {
  const _ThemeToggle({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  _ThemeToggleState createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
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
