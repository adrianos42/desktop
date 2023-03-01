import 'package:desktop/desktop.dart';
import '../defaults.dart';

class SliderPage extends StatefulWidget {
  SliderPage({super.key});

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double first = 0.2;
  double second = 0.0;

  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
return Container(
  width: 200.0,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Slider(
        value: first,
        onChanged: (value) {
          setState(() => first = value);
        },
      ),
    ],
  ),
);
''';

    const disabledCode = '''
return Container(
  width: 200.0,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Slider(
        value: 0.3,
      ),
    ],
  ),
);
''';

    return Defaults(
      styleItems: Defaults.createStyle(SliderTheme.of(context).toString()),
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child:
                        Text('Slider value: ${first.toStringAsPrecision(1)}'),
                  ),
                  Slider(
                    value: first,
                    onChanged: (value) {
                      setState(() => first = value);
                    },
                  ),
                ],
              ),
            ),
          ),
          codeText: enabledCode,
          title: 'Enabled',
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Slider(
                    value: 0.3,
                  ),
                ],
              ),
            ),
          ),
          codeText: disabledCode,
          title: 'Disabled',
        ),
      ],
      header: 'Slider',
    );
  }
}
