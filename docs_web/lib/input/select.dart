import 'package:desktop/desktop.dart';
import '../defaults.dart';

class SelectInputPage extends StatefulWidget {
  SelectInputPage({super.key});

  @override
  _SelectInputPageState createState() => _SelectInputPageState();
}

class _SelectInputPageState extends State<SelectInputPage> {
  bool first = false;
  bool second = false;
  bool? third;

  bool value = false;
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Defaults(
      items: [
        ItemTitle(
          body: (context) => Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToggleSwitch(
                      onChanged: (fvalue) {
                        setState(() => value = fvalue);
                      },
                      autofocus: false,
                      value: value,
                    ),
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
                    Checkbox(
                      value: third,
                      tristate: true,
                      onChanged: (fvalue) {
                        setState(() => third = fvalue);
                      },
                    ),
                    Radio(
                      value: _value,
                      onChanged: (fvalue) {
                        setState(() {
                          _value = true;
                        });
                      },
                    ),
                    Radio(
                      value: !_value,
                      onChanged: (fvalue) {
                        setState(() {
                          _value = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          codeText: '',
          title: 'Enabled',
        ),
      ],
      header: 'Checkbox',
    );
  }
}
