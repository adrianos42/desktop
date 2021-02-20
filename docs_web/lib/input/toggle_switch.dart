import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ToggleSwitchPage extends StatefulWidget {
  ToggleSwitchPage({Key? key}) : super(key: key);

  @override
  _ToggleSwitchPageState createState() => _ToggleSwitchPageState();
}

class _ToggleSwitchPageState extends State<ToggleSwitchPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Toggle switch'),
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
                  height: 50.0,
                  child: Container(
                    width: 100.0,
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
                      ],
                    ),
                  ),
                ),
                Defaults.createCaption(context, 'Disabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  height: 50.0,
                  child: Container(
                    width: 100.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ToggleSwitch(
                          autofocus: false,
                          value: false,
                        ),
                      ],
                    ),
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
