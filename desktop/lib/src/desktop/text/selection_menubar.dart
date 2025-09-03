import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/rendering.dart';

import '../icons.dart';
import '../localizations.dart';
import '../theme/dialogs/context_menu.dart';
import 'text_selection_menubar.dart';
import 'text_selection_menubar_button.dart';

/// The default context menu for text selection for the current platform.
class AdaptiveTextSelectionMenubar extends StatelessWidget {
  const AdaptiveTextSelectionMenubar({
    super.key,
    required this.children,
    required this.anchors,
  }) : buttonItems = null;

  /// Create an instance of [AdaptiveTextSelectionMenubar] whose children will
  const AdaptiveTextSelectionMenubar.buttonItems({
    super.key,
    required this.buttonItems,
    required this.anchors,
  }) : children = null;

  AdaptiveTextSelectionMenubar.editable({
    super.key,
    required ClipboardStatus clipboardStatus,
    required VoidCallback? onCopy,
    required VoidCallback? onCut,
    required VoidCallback? onPaste,
    required VoidCallback? onSelectAll,
    required VoidCallback? onLookUp,
    required VoidCallback? onSearchWeb,
    required VoidCallback? onShare,
    required VoidCallback? onLiveTextInput,
    required this.anchors,
  }) : children = null,
       buttonItems = EditableText.getEditableButtonItems(
         clipboardStatus: clipboardStatus,
         onCopy: onCopy,
         onCut: onCut,
         onPaste: onPaste,
         onSelectAll: onSelectAll,
         onLookUp: onLookUp,
         onSearchWeb: onSearchWeb,
         onShare: onShare,
         onLiveTextInput: onLiveTextInput,
       );

  AdaptiveTextSelectionMenubar.editableText({
    super.key,
    required EditableTextState editableTextState,
  }) : children = null,
       buttonItems = editableTextState.contextMenuButtonItems,
       anchors = editableTextState.contextMenuAnchors;

  AdaptiveTextSelectionMenubar.selectable({
    super.key,
    required VoidCallback onCopy,
    required VoidCallback onSelectAll,
    required VoidCallback? onShare,
    required SelectionGeometry selectionGeometry,
    required this.anchors,
  }) : children = null,
       buttonItems = SelectableRegion.getSelectableButtonItems(
         selectionGeometry: selectionGeometry,
         onCopy: onCopy,
         onSelectAll: onSelectAll,
         onShare: onShare,
       );

  AdaptiveTextSelectionMenubar.selectableRegion({
    super.key,
    required SelectableRegionState selectableRegionState,
  }) : children = null,
       buttonItems = selectableRegionState.contextMenuButtonItems,
       anchors = selectableRegionState.contextMenuAnchors;

  final List<ContextMenuButtonItem>? buttonItems;

  /// The children of the toolbar, typically buttons.
  final List<Widget>? children;

  final TextSelectionToolbarAnchors anchors;

  static (String, IconData?) getButtonLabel(
    BuildContext context,
    ContextMenuButtonItem buttonItem,
  ) {
    if (buttonItem.label != null) {
      return (buttonItem.label!, null);
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return (
          CupertinoTextSelectionToolbarButton.getButtonLabel(
            context,
            buttonItem,
          ),
          null,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        final DesktopLocalizations localizations = DesktopLocalizations.of(
          context,
        );
        return switch (buttonItem.type) {
          ContextMenuButtonType.cut => (
            localizations.cutButtonLabel,
            Icons.cut,
          ),
          ContextMenuButtonType.copy => (
            localizations.copyButtonLabel,
            Icons.copy,
          ),
          ContextMenuButtonType.paste => (
            localizations.pasteButtonLabel,
            Icons.paste,
          ),
          ContextMenuButtonType.selectAll => (
            localizations.selectAllButtonLabel,
            Icons.selectAll,
          ),
          ContextMenuButtonType.delete => (
            localizations.deleteButtonTooltip.toUpperCase(),
            Icons.delete,
          ),
          ContextMenuButtonType.lookUp => (
            localizations.lookUpButtonLabel,
            Icons.searchOff,
          ),
          ContextMenuButtonType.searchWeb => (
            localizations.searchWebButtonLabel,
            Icons.web,
          ),
          ContextMenuButtonType.share => (
            localizations.shareButtonLabel,
            Icons.share,
          ),
          ContextMenuButtonType.liveTextInput => (
            localizations.scanTextButtonLabel,
            Icons.scanner,
          ),
          ContextMenuButtonType.custom => ('', null),
        };
    }
  }

  static Widget _createIconLabel(
    BuildContext context,
    ContextMenuButtonItem buttonItem,
  ) {
    final ContextMenuThemeData contextMenuThemeData = ContextMenuTheme.of(
      context,
    );

    return Builder(
      builder: (context) {
        final (label, icon) = getButtonLabel(context, buttonItem);
        return IconTheme(
          data: contextMenuThemeData.iconThemeData!,
          child: DefaultTextStyle(
            style: contextMenuThemeData.textStyle!,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: contextMenuThemeData.menuHorizontalPadding!,
                  ),
                  child: Icon(icon),
                ),
                Text(label),
              ],
            ),
          ),
        );
      },
    );
  }

  static Iterable<Widget> getAdaptiveButtons(
    BuildContext context,
    List<ContextMenuButtonItem> buttonItems,
  ) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return buttonItems.map((ContextMenuButtonItem buttonItem) {
          return CupertinoTextSelectionToolbarButton.buttonItem(
            buttonItem: buttonItem,
          );
        });
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buttonItems.map((ContextMenuButtonItem buttonItem) {
          return TextSelectionMenubarButton(
            onPressed: buttonItem.onPressed,
            child: _createIconLabel(context, buttonItem),
          );
        });
      case TargetPlatform.macOS:
        return buttonItems.map((ContextMenuButtonItem buttonItem) {
          return CupertinoDesktopTextSelectionToolbarButton(
            child: _createIconLabel(context, buttonItem),
            onPressed: buttonItem.onPressed,
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((children != null && children!.isEmpty) ||
        (buttonItems != null && buttonItems!.isEmpty)) {
      return const SizedBox.shrink();
    }

    final List<Widget> resultChildren = children != null
        ? children!
        : getAdaptiveButtons(context, buttonItems!).toList();

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return CupertinoTextSelectionToolbar(
          anchorAbove: anchors.primaryAnchor,
          anchorBelow: anchors.secondaryAnchor == null
              ? anchors.primaryAnchor
              : anchors.secondaryAnchor!,
          children: resultChildren,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextSelectionMenubar(
          anchor: anchors.primaryAnchor,
          children: resultChildren,
        );
      case TargetPlatform.macOS:
        return CupertinoDesktopTextSelectionToolbar(
          anchor: anchors.primaryAnchor,
          children: resultChildren,
        );
    }
  }
}
