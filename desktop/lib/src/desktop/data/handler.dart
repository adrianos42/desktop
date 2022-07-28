
// class _TableColHandler extends StatefulWidget {
//   const _TableColHandler({
//     //required this.tableDragUpdate,
//     required this.col,
//     required this.hasIndicator,
//     required this.draggingColumn,
//     this.border,
//     Key? key,
//   }) : super(key: key);

//   final bool hasIndicator;
//   //final _TableDragUpdate tableDragUpdate;
//   final int col;
//   final BorderSide? border;
//   final bool draggingColumn;

//   @override
//   _TableColHandlerState createState() => _TableColHandlerState();
// }

// class _TableColHandlerState extends State<_TableColHandler>
//     with ComponentStateMixin {
//   Map<Type, GestureRecognizerFactory> get _gestures {
//     final gestures = <Type, GestureRecognizerFactory>{};

//     return gestures;
//   }

//   double? currentPosition;

//   ///_TableDragUpdate get tableUpdateColFactor => widget.tableDragUpdate;
//   int get col => widget.col;

//   void _handleMouseEnter(PointerEnterEvent event) =>
//       setState(() => hovered = true);

//   void _handleMouseExit(PointerExitEvent event) =>
//       setState(() => hovered = false);

//   @override
//   Widget build(BuildContext context) {
//     final ListTableThemeData listTableTheme = ListTableTheme.of(context);

//     BorderSide? border = widget.border;
//     final bool expanded = hovered || dragged || widget.hasIndicator;

//     if (border != null && border != BorderSide.none) {
//       final Color borderColor = widget.draggingColumn
//           ? const Color(0x00000000)
//           : dragged
//               ? listTableTheme.borderHighlightColor!
//               : widget.draggingColumn
//                   ? listTableTheme.borderColor!
//                   : hovered
//                       ? listTableTheme.borderHoverColor!
//                       : widget.hasIndicator
//                           ? listTableTheme.borderIndicatorColor!
//                           : border.color;

//       border = border.copyWith(
//           color: borderColor,
//           width: expanded
//               ? border.width + (border.width / 2.0).roundToDouble()
//               : border.width);
//     } else {
//       final width = expanded ? 2.0 : 1.0;
//       final borderColor = dragged
//           ? listTableTheme.borderHighlightColor!
//           : widget.draggingColumn
//               ? listTableTheme.borderColor!
//               : hovered
//                   ? listTableTheme.borderHoverColor!
//                   : widget.hasIndicator
//                       ? listTableTheme.borderIndicatorColor!
//                       : listTableTheme.borderColor!;
//       border = BorderSide(width: width, color: borderColor);
//     }

//     final Widget result = Container(
//       margin: const EdgeInsets.only(left: _kHandlerWidth),
//       decoration: BoxDecoration(border: Border(right: border)),
//     );

//     if (widget.draggingColumn) {
//       return result;
//     }

//     return RawGestureDetector(
//       gestures: _gestures,
//       behavior: HitTestBehavior.translucent,
//       child: MouseRegion(
//         opaque: false,
//         cursor: SystemMouseCursors.click,
//         onEnter: _handleMouseEnter,
//         onExit: _handleMouseExit,
//         child: result,
//       ),
//     );
//   }
// }
