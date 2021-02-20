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
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Defaults.createCaption(context, 'Enabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  height: 50,
                  child: TextButton(
                    'Click me',
                    onPressed: () {},
                  ),
                ),
                Defaults.createCaption(context, 'Disabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  height: 50,
                  child: TextButton('Click me'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
