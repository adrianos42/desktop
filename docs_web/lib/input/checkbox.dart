import 'package:desktop/desktop.dart';
import '../defaults.dart';

class CheckboxPage extends StatefulWidget {
  CheckboxPage({Key? key}) : super(key: key);

  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Checkbox'),
        Expanded(
          child: Center(
            child: Checkbox(
              value: true,
              onChanged: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
