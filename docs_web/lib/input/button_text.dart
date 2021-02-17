import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonTextPage extends StatefulWidget {
  ButtonTextPage({Key? key}) : super(key: key);

  @override
  _ButtonTextPageState createState() => _ButtonTextPageState();
}

class _ButtonTextPageState extends State<ButtonTextPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Text button'),
        Expanded(
          child: Center(child: TextButton('Click me', onPressed: () {},),),
        ),
      ],
    );
  }
}
