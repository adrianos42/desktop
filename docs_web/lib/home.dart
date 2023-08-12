import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';
import 'data/data.dart';
import 'dialogs/dialogs.dart';
import 'input/input.dart';
import 'navigation/navigation.dart';
import 'scrolling.dart';
import 'status/status.dart';
import 'text/text.dart';
import 'theme/color_scheme.dart';
import 'theme/primary_color.dart';
import 'theme/typography.dart';
import 'theme/custom_theme.dart';
import 'overview.dart';

const String _version = '5.0.0-dev.3';

///
class DocHome extends StatefulWidget {
  ///
  DocHome({
    super.key,
    required this.packageVersion,
    required this.packageName,
    this.allowThemeColorChange = false,
    this.allowThemeChange = true,
    this.allowDragging = false,
    required this.treeNodes,
  }) : assert(treeNodes.isNotEmpty, 'Empty documentation.');

  ///
  final String packageVersion;

  ///
  final String packageName;

  ///
  final bool allowThemeColorChange;

  ///
  final bool allowThemeChange;

  ///
  final List<TreeNode> treeNodes;

  ///
  final bool allowDragging;

  @override
  State<DocHome> createState() => _DocHomeState();
}

class _DocHomeState extends State<DocHome> {
  static ContextMenuItem<PrimaryColors> _menuItemPrimaryColor(
    PrimaryColors color,
  ) {
    return ContextMenuItem(
      value: color,
      child: Text(color.toString()),
    );
  }

  PrimaryColors? _primaryColor;

  PrimaryColors get primaryColor =>
      _primaryColor ??
      PrimaryColors.fromPrimaryColor(Theme.of(context).colorScheme.primary)!;

  bool? _isShowingTree;

  Widget _createColorButton() {
    List<ContextMenuItem<PrimaryColors>> itemBuilder(context) => [
          _menuItemPrimaryColor(PrimaryColors.coral),
          _menuItemPrimaryColor(PrimaryColors.sandyBrown),
          _menuItemPrimaryColor(PrimaryColors.orange),
          _menuItemPrimaryColor(PrimaryColors.goldenrod),
          _menuItemPrimaryColor(PrimaryColors.springGreen),
          _menuItemPrimaryColor(PrimaryColors.turquoise),
          _menuItemPrimaryColor(PrimaryColors.deepSkyBlue),
          _menuItemPrimaryColor(PrimaryColors.dodgerBlue),
          _menuItemPrimaryColor(PrimaryColors.cornflowerBlue),
          _menuItemPrimaryColor(PrimaryColors.royalBlue),
          _menuItemPrimaryColor(PrimaryColors.slateBlue),
          _menuItemPrimaryColor(PrimaryColors.purple),
          _menuItemPrimaryColor(PrimaryColors.violet),
          _menuItemPrimaryColor(PrimaryColors.hotPink),
          _menuItemPrimaryColor(PrimaryColors.red),
        ];

    return Builder(
      builder: (context) => ButtonTheme.merge(
        data: ButtonThemeData(
          color: Theme.of(context).textTheme.textPrimaryHigh,
          highlightColor: ButtonTheme.of(context).color,
        ),
        child: ContextMenuButton.icon(
          Icons.palette,
          itemBuilder: itemBuilder,
          value: primaryColor,
          onSelected: (PrimaryColors value) {
            final themeData = Theme.of(context);
            final colorScheme = themeData.colorScheme;
            _primaryColor = value;

            Theme.updateThemeData(
              context,
              themeData.copyWith(
                colorScheme: ColorScheme(
                  colorScheme.brightness,
                  primary: value.primaryColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _createHome() {
    return Builder(builder: (context) {
      final orientation = MediaQuery.maybeOf(context)?.orientation;
      final textTheme = Theme.of(context).textTheme;

      final isShowingTree =
          _isShowingTree ?? orientation == Orientation.landscape;

      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Button.icon(
                        Icons.menuOpen,
                        theme: ButtonThemeData(
                          color: textTheme.textLow,
                          highlightColor: textTheme.textPrimaryHigh,
                        ),
                        active: isShowingTree,
                        size: 22.0,
                        onPressed: () =>
                            setState(() => _isShowingTree = !isShowingTree),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Builder(
                        builder: (context) {
                          return Tooltip(
                            message: widget.packageVersion,
                            child: Text(
                              widget.packageName,
                              style: Theme.of(context).textTheme.title.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary[70],
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                if (widget.allowThemeChange || widget.allowThemeColorChange)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.allowThemeColorChange) _createColorButton(),
                        if (widget.allowThemeChange)
                          _ThemeToggle(
                            onPressed: () => setState(() {
                              final invertedTheme =
                                  Theme.of(context).invertedTheme;
                              Theme.updateThemeData(context, invertedTheme);
                            }),
                          ),
                      ],
                    ),
                  )
              ],
            ),
            Expanded(
              child: Tree(
                collapsed: !isShowingTree,
                allowDragging: widget.allowDragging,
                title: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Documentation',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ),
                nodes: widget.treeNodes,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => _createHome();
}

class _ThemeToggle extends StatefulWidget {
  const _ThemeToggle({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final iconForeground = themeData.textTheme.textHigh;
    switch (themeData.brightness) {
      case Brightness.dark:
        return Button.icon(
          Icons.darkMode,
          onPressed: widget.onPressed,
          theme: ButtonThemeData(
            color: iconForeground,
          ),
        );
      case Brightness.light:
        return Button.icon(
          Icons.lightMode,
          onPressed: widget.onPressed,
          theme: ButtonThemeData(color: iconForeground),
        );
    }
  }
}

class DocApp extends StatelessWidget {
  const DocApp({super.key});

  static List<TreeNode> createItems(bool buildCustomThemeItem) {
    return [
      TreeNode.child(
        titleBuilder: (context) => const Text('Overview'),
        builder: (context) {
          if (kReleaseMode) {
            return const OverviewPage();
          } else {
            return const DialogPage();
          }
        },
      ),
      TreeNode.children(
        titleBuilder: (context) => const Text('Navigation'),
        children: [
          TreeNode.child(
            titleBuilder: (context) => const Text('Breadcrumb'),
            builder: (context) => const BreadcrumbPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Nav'),
            builder: (context) => const NavPage(),
          ),

          ///TreeNode.child(
          ///  titleBuilder: (context) => const Text('Bottom Nav'),
          ///  builder: (context) => BottomNavPage(),
          ///),
          TreeNode.child(
            titleBuilder: (context) => const Text('Tab'),
            builder: (context) => const TabPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Tree'),
            builder: (context) => const TreePage(),
          ),
        ],
      ),
      TreeNode.children(
        titleBuilder: (context) => const Text('Data'),
        children: [
          TreeNode.child(
            titleBuilder: (context) => const Text('List Table'),
            builder: (context) => const ListTablePage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Text Form Field'),
            builder: (context) => const TextFormFieldPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Date Form Field'),
            builder: (context) => const DateFormFieldPage(),
          ),
        ],
      ),
      TreeNode.children(
        titleBuilder: (context) => const Text('Dialogs'),
        children: [
          TreeNode.child(
            titleBuilder: (context) => const Text('Dialog'),
            builder: (context) => const DialogPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Message'),
            builder: (context) => const DialogMessagePage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Tooltip'),
            builder: (context) => const TooltipPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Date Picker'),
            builder: (context) => const DatePickerPage(),
          ),
        ],
      ),
      TreeNode.children(
        titleBuilder: (context) => const Text('Input'),
        children: [
          TreeNode.child(
            titleBuilder: (context) => const Text('Button'),
            builder: (context) => const ButtonPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Context Menu'),
            builder: (context) => const ButtonContextMenuPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Drop Down Menu'),
            builder: (context) => const ButtonDropDownPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Hyperlink'),
            builder: (context) => const ButtonHyperlinkPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Slider'),
            builder: (context) => const SliderPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Checkbox'),
            builder: (context) => const CheckboxPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Radio'),
            builder: (context) => const ButtonRadioPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Toggle Switch'),
            builder: (context) => const ToggleSwitchPage(),
          ),
        ],
      ),
      TreeNode.children(
        titleBuilder: (context) => const Text('Status'),
        children: [
          TreeNode.child(
            titleBuilder: (context) => const Text('Linear Progress Indicator'),
            builder: (context) => const LinearProgressIndicatorPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) =>
                const Text('Circular Progress Indicator'),
            builder: (context) => const CircularProgressIndicatorPage(),
          ),
        ],
      ),
      TreeNode.children(
        titleBuilder: (context) => const Text('Text'),
        children: [
          TreeNode.child(
            titleBuilder: (context) => const Text('Text Field'),
            builder: (context) => const TextFieldPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Search Text Field'),
            builder: (context) => const SearchTextFieldPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Selectable Text'),
            builder: (context) => const SelectableTextPage(),
          ),
        ],
      ),
      TreeNode.children(
        titleBuilder: (context) => const Text('Theme'),
        children: [
          TreeNode.child(
            titleBuilder: (context) => const Text('Typography'),
            builder: (context) => const TypographyPage(),
          ),
          TreeNode.child(
            titleBuilder: (context) => const Text('Color Scheme'),
            builder: (context) => const ColorschemePage(),
          ),
          if (buildCustomThemeItem)
            TreeNode.child(
              titleBuilder: (context) => const Text('Primary Colors'),
              builder: (context) => const PrimaryColorPage(),
            ),
          if (buildCustomThemeItem)
            TreeNode.child(
              titleBuilder: (context) => const Text('Custom Theme'),
              builder: (context) => const CustomTheme(),
            ),
        ],
      ),
      TreeNode.child(
        titleBuilder: (context) => const Text('Scrollbar'),
        builder: (context) => const ScrollingPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DocHome(
      packageName: 'Desktop',
      packageVersion: _version,
      allowThemeChange: true,
      allowThemeColorChange: true,
      allowDragging: false,
      treeNodes: createItems(true),
    );
  }
}
