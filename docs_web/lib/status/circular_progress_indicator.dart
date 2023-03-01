import 'package:desktop/desktop.dart';
import '../defaults.dart';
import 'dart:math' as math;

class CircularProgressIndicatorPage extends StatefulWidget {
  CircularProgressIndicatorPage({super.key});

  @override
  _CircularProgressIndicatorPageState createState() => _CircularProgressIndicatorPageState();
}

class _CircularProgressIndicatorPageState extends State<CircularProgressIndicatorPage>
    with TickerProviderStateMixin {
  double circularValue = 0.5;

  @override
  Widget build(BuildContext context) {
    const circularCodeExample = 'return CircularProgressIndicator(value: 0.4);';
    const circularIndeterminateCodeExample =
        'return CircularProgressIndicator();';

    final CircularProgressIndicatorThemeData themeData =
        CircularProgressIndicatorTheme.of(context);

    return Defaults(
      header: 'Circular Progress Indicator',
      styleItems: Defaults.createStyle(themeData.toString()),
      items: [
        ItemTitle(
          body: (context) => Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: const CircularProgressIndicator(),
          ),
          codeText: circularIndeterminateCodeExample,
          title: 'Circular indeterminate',
        ),
        ItemTitle(
          options: [
            Button.icon(
              Icons.remove,
              onPressed: () => setState(
                () => circularValue = math.max(0.0, circularValue - 0.05),
              ),
            ),
            Button.icon(
              Icons.add,
              onPressed: () => setState(
                () => circularValue = math.min(1.0, circularValue + 0.05),
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
                  child: CircularProgressIndicator(value: circularValue),
                ),
              ],
            ),
          ),
          codeText: circularCodeExample,
          title: 'Circular',
        ),
      ],
    );
  }
}
