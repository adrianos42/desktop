import 'package:desktop/desktop.dart';
import '../defaults.dart';

class CheckboxPage extends StatefulWidget {
  CheckboxPage({Key? key}) : super(key: key);

  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool first = false;
  bool second = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Checkbox'),
        Expanded(
          child: Container(
              width: 200.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                    value: first,
                    tristate: false,
                    onChanged: (fvalue) {
                      setState(() => first = fvalue!);
                    },
                  ),
                  Checkbox(
                    value: second,
                    tristate: false,
                    onChanged: (fvalue) {
                      setState(() => second = fvalue!);
                    },
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
