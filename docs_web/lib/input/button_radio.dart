import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonRadioPage extends StatefulWidget {
  ButtonRadioPage({Key? key}) : super(key: key);

  @override
  _ButtonRadioPageState createState() => _ButtonRadioPageState();
}

class _ButtonRadioPageState extends State<ButtonRadioPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Radio'),
        Expanded(
          child: Center(
            child: Container(
              width: 100.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Radio(
                      value: value,
                      onChanged: (fvalue) {
                        setState(() {
                          value = true;
                        });
                      },
                    ),
                    Radio(
                      value: !value,
                      onChanged: (fvalue) {
                        setState(() {
                          value = false;
                        });
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
