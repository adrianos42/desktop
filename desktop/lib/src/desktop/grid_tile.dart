import 'package:flutter/widgets.dart';

class GridTile extends StatelessWidget {
  const GridTile({
    Key? key,
    this.header,
    this.footer,
    required this.child,
  }) : super(key: key);

  final Widget? header;

  final Widget? footer;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (header == null && footer == null) return child;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: child,
        ),
        if (header != null)
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: header!, // FIXME
          ),
        if (footer != null)
          Positioned(
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: footer!, // FIXME
          ),
      ],
    );
  }
}
