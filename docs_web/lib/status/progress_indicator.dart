import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ProgressIndicatorPage extends StatefulWidget {
  ProgressIndicatorPage({Key? key}) : super(key: key);

  @override
  _ProgressIndicatorPageState createState() => _ProgressIndicatorPageState();
}

class _ProgressIndicatorPageState extends State<ProgressIndicatorPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 0),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const linearCodeExample = 'return LinearProgressIndicator(value: 0.4);';
    const linearIndeterminateCodeExample = 'return LinearProgressIndicator();';
    const circurlarCodeExample = 'return CircularProgressIndicator();';

    return Defaults(
      header: 'Progress indicator',
      items: [
        ItemTitle(
          body: (context) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: const LinearProgressIndicator(),
          ),
          codeText: linearIndeterminateCodeExample,
          title: 'Linear indeterminate',
        ),
        ItemTitle(
          body: (context) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => LinearProgressIndicator(
                value: _controller.value,
              ),
            ),
          ),
          codeText: linearCodeExample,
          title: 'Linear',
        ),
        ItemTitle(
          body: (context) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: const CircularProgressIndicator(),
          ),
          codeText: circurlarCodeExample,
          title: 'Circular',
        ),
      ],
    );
  }
}
