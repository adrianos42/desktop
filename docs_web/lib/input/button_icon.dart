import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonIconPage extends StatefulWidget {
  ButtonIconPage({Key? key}) : super(key: key);

  @override
  _ButtonIconPageState createState() => _ButtonIconPageState();
}

class _ButtonIconPageState extends State<ButtonIconPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Icon button'),
        Expanded(
          child: Center(
            child: IconButton(
              Icons.place,
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
