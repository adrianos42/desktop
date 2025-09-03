import 'package:flutter/widgets.dart';

import '../theme/dialogs/context_menu.dart';

const double _kMenubarScreenPadding = 8.0;

class DesktopTextSelectionMenubarLayoutDelegate
    extends SingleChildLayoutDelegate {
  DesktopTextSelectionMenubarLayoutDelegate({required this.anchor});

  final Offset anchor;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final Offset overhang = Offset(
      anchor.dx + childSize.width - size.width,
      anchor.dy + childSize.height - size.height,
    );
    return Offset(
      overhang.dx > 0.0 ? anchor.dx - overhang.dx : anchor.dx,
      overhang.dy > 0.0 ? anchor.dy - overhang.dy : anchor.dy,
    );
  }

  @override
  bool shouldRelayout(DesktopTextSelectionMenubarLayoutDelegate oldDelegate) {
    return anchor != oldDelegate.anchor;
  }
}

class TextSelectionMenubar extends StatelessWidget {
  const TextSelectionMenubar({
    super.key,
    required this.anchor,
    required this.children,
  }) : assert(children.length > 0);

  final Offset anchor;

  final List<Widget> children;

  Widget _defaultMenubarBuilder(BuildContext context) {
    final ContextMenuThemeData contextMenuThemeData = ContextMenuTheme.of(
      context,
    );

    final contextView = SingleChildScrollView(
      // controller: scrollController,
      child: ListBody(children: children),
    );

    // return Container(width: 100, height: 50, color: Colors.red, child: SingleChildScrollView(child: contextView,) ,);

    final Widget child = Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      child: IntrinsicWidth(child: contextView),
    );

    return DecoratedBox(
      decoration: BoxDecoration(color: contextMenuThemeData.background!),
      position: DecorationPosition.background,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double paddingAbove =
        MediaQuery.paddingOf(context).top + _kMenubarScreenPadding;
    final Offset localAdjustment = Offset(_kMenubarScreenPadding, paddingAbove);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        _kMenubarScreenPadding,
        paddingAbove,
        _kMenubarScreenPadding,
        _kMenubarScreenPadding,
      ),
      child: CustomSingleChildLayout(
        delegate: DesktopTextSelectionMenubarLayoutDelegate(
          anchor: anchor - localAdjustment,
        ),
        child: _defaultMenubarBuilder(context),
      ),
    );
  }
}
