import 'package:desktop/desktop.dart';

class InputContent extends StatelessWidget {
  const InputContent({
    required this.enabled,
    required this.child,
    super.key,
  });

  final Widget child;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Theme.withBrightness(context,
        brightness: enabled ? Brightness.light : Brightness.dark,
        child: Builder(
      builder: (context) {
        final Color background =
            Theme.of(context).contentColorScheme.background[0];
        return ColoredBox(
          color: background,
          child: Padding(
            padding: const EdgeInsetsGeometry.all(32.0),
            child: Center(child: child),
          ),
        );
      },
    ));
  }
}
