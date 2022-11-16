import 'package:desktop/desktop.dart';
import 'package:flutter/foundation.dart';

///
class DocHome extends StatefulWidget {
  ///
  DocHome({
    super.key,
    required this.packageVersion,
    required this.packageName,
    this.allowThemeColorChange = false,
    this.allowThemeChange = true,
    this.allowDragging = true,
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
  _DocHomeState createState() => _DocHomeState();
}

class _DocHomeState extends State<DocHome> {
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
          _menuItemPrimaryColor(PrimaryColor.springGreen),
          _menuItemPrimaryColor(PrimaryColor.turquoise),
          _menuItemPrimaryColor(PrimaryColor.deepSkyBlue),
          _menuItemPrimaryColor(PrimaryColor.dodgerBlue),
          _menuItemPrimaryColor(PrimaryColor.cornflowerBlue),
          _menuItemPrimaryColor(PrimaryColor.royalBlue),
          _menuItemPrimaryColor(PrimaryColor.slateBlue),
          _menuItemPrimaryColor(PrimaryColor.purple),
          _menuItemPrimaryColor(PrimaryColor.violet),
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
                        Icons.menu_open,
                        style: ButtonThemeData(
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
  Widget build(BuildContext context) {
    // return BottomNavPage();
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
          style: ButtonThemeData(
            color: iconForeground,
          ),
        );
      case Brightness.light:
        return Button.icon(
          Icons.light_mode,
          onPressed: widget.onPressed,
          style: ButtonThemeData(color: iconForeground),
        );
    }
  }
}
