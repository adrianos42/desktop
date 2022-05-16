import 'package:desktop/desktop.dart';
import '../defaults.dart';

class SliderPage extends StatefulWidget {
  SliderPage({Key? key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double first = 0.2;
  double second = 0.0;

  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
Container(
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
)
''';

    const disabledCode = '''
Container(
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
)
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Slider value: ${first.toStringAsPrecision(1)}'),
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
          height: 400.0,
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
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
          height: 400.0,
        ),
      ],
      header: 'Slider',
    );
  }
}
