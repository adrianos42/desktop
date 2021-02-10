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
    return Column(
      children: [
        Defaults.createHeader(context, 'Slider'),
        Expanded(
          child: Container(
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
                  Slider(
                    value: second,
                    onChanged: (value) {
                      setState(() => second = value);
                    },
                  ),

                  Slider(
                    value: 0.3,
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
