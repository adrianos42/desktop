import 'package:desktop/desktop.dart';

import '../defaults.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double first = 0.2;
  double second = 0.0;
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    const expampleCode = '''
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

    return Defaults(
      header: 'Slider',
      styleItems: Defaults.createStyle(SliderTheme.of(context).toString()),
      items: [
        ItemTitle(
          title: 'Example',
          body: (context) => Center(
            child: SizedBox(
              width: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      'Slider value: ${first.toStringAsPrecision(1)}',
                    ),
                  ),
                  Slider(
                    value: first,
                    onChanged: !_disabled
                        ? (value) {
                            setState(() => first = value);
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ),
          options: [
            Button.icon(
              Icons.close,
              active: _disabled,
              onPressed: () => setState(() => _disabled = !_disabled),
            ),
          ],
          codeText: expampleCode,
        ),
      ],
    );
  }
}
