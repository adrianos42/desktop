import 'package:desktop/desktop.dart';
import '../defaults.dart';
import 'dart:math' as math;

class LinearProgressIndicatorPage extends StatefulWidget {
  LinearProgressIndicatorPage({super.key});

  @override
  _LinearProgressIndicatorPageState createState() => _LinearProgressIndicatorPageState();
}

class _LinearProgressIndicatorPageState extends State<LinearProgressIndicatorPage>
    with TickerProviderStateMixin {
  double linearValue = 0.5;

  @override
  Widget build(BuildContext context) {
    const linearCodeExample = 'return LinearProgressIndicator(value: 0.4);';
    const linearIndeterminateCodeExample = 'return LinearProgressIndicator();';

    final LinearProgressIndicatorThemeData themeData =
        LinearProgressIndicatorTheme.of(context);

    return Defaults(
      header: 'Linear Progress Indicator',
      styleItems: Defaults.createStyle(themeData.toString()),
      items: [
        ItemTitle(
          body: (context) => Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: const LinearProgressIndicator(),
          ),
          codeText: linearIndeterminateCodeExample,
          title: 'Linear indeterminate',
        ),
        ItemTitle(
          options: [
            Button.icon(
              Icons.remove,
              onPressed: () => setState(
                () => linearValue = math.max(0.0, linearValue - 0.05),
              ),
            ),
            Button.icon(
              Icons.add,
              onPressed: () => setState(
                () => linearValue = math.min(1.0, linearValue + 0.05),
              ),
            ),
          ],
          body: (context) => Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: LinearProgressIndicator(value: linearValue),
                ),
              ],
            ),
          ),
          codeText: linearCodeExample,
          title: 'Linear',
        ),
      ],
    );
  }
}
