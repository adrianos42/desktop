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
    const linearCodeExample = 'LinearProgressIndicator(value: 0.4)';
    const linearIndeterminateCodeExample = 'LinearProgressIndicator()';
    const circurlarCodeExample = 'CircularProgressIndicator()';

    return Defaults.createItemsWithTitle(
      context,
      header: 'Progress indicator',
      items: [
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
          height: 200.0,
        ),
        ItemTitle(
          body: (context) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: const LinearProgressIndicator(),
          ),
          codeText: linearIndeterminateCodeExample,
          title: 'Linear indeterminate',
          height: 200.0,
        ),
        ItemTitle(
          body: (context) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: const CircularProgressIndicator(),
          ),
          codeText: circurlarCodeExample,
          title: 'Circular',
          height: 200.0,
        ),
      ],
    );
  }
}
