import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ProgressIndicatorPage extends StatefulWidget {
  ProgressIndicatorPage({Key? key}) : super(key: key);

  @override
  _ProgressIndicatorPageState createState() => _ProgressIndicatorPageState();
}

class _ProgressIndicatorPageState extends State<ProgressIndicatorPage> {
  final linearCodeExample = 'LinearProgressIndicator(value: 0.4)';
  final circurlarCodeExample = 'CircularProgressIndicator()';

  double progressValue = 0.4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Progress indicator'),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Defaults.createTitle(context, 'Linear'),
              Container(
                height: 200.0,
                child: Defaults.createCodeSession(
                  context,
                  builder: (context) => Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Button.icon(
                              Icons.minus,
                              onPressed: () => setState(() => progressValue =
                                  (progressValue - 0.05).clamp(0.0, 1.0)),
                            ),
                            Button.icon(
                              Icons.plus,
                              onPressed: () => setState(() => progressValue =
                                  (progressValue + 0.05).clamp(0.0, 1.0)),
                            ),
                            Text(
                              'value: ${(progressValue * 100).round()}%',
                              style: Theme.of(context).textTheme.body1.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .shade4
                                        .toColor(),
                                  ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: progressValue,
                        ),
                      ],
                    ),
                  ),
                  codeText: linearCodeExample,
                ),
              ),
              Defaults.createTitle(context, 'Circular'),
              Container(
                height: 200.0,
                child: Defaults.createCodeSession(
                  context,
                  builder: (context) => Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                  codeText: circurlarCodeExample,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
