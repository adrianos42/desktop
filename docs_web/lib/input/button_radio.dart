import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonRadioPage extends StatefulWidget {
  ButtonRadioPage({Key? key}) : super(key: key);

  @override
  _ButtonRadioPageState createState() => _ButtonRadioPageState();
}

class _ButtonRadioPageState extends State<ButtonRadioPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Radio'),
        Expanded(
          child: Center(
            child: Radio(
              autofocus: true,
              value: true,
              onChanged: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
