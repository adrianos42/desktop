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
                  child: IconButton(
                    Icons.place,
                    onPressed: () {},
                  ),
                ),
                Defaults.createCaption(context, 'Disabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  height: 50,
                  child: IconButton(Icons.place),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
