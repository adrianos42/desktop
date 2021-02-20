import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonPage extends StatefulWidget {
  ButtonPage({Key? key}) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Button'),
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
                  child: Button(
                    body: Text('Button'),
                    trailing: Icon(Icons.phone),
                    leading: Icon(Icons.control_camera),
                    onPressed: () {},
                  ),
                ),
                Defaults.createCaption(context, 'Disabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  height: 50,
                  child: Button(
                    body: Text('Button'),
                    trailing: Icon(Icons.phone),
                    leading: Icon(Icons.control_camera),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
