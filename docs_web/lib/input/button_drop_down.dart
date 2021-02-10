import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonDropDownPage extends StatefulWidget {
  ButtonDropDownPage({Key? key}) : super(key: key);

  @override
  _ButtonDropDownPageState createState() => _ButtonDropDownPageState();
}

class _ButtonDropDownPageState extends State<ButtonDropDownPage> {
  int? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Drop down menu'),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Defaults.createTitle(context, 'Basic context menu'),
                Text('Enabled:'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  padding: EdgeInsets.all(16.0),
                  child: DropDownButton(
                    onSelected: (int value) {
                      setState(() => initialValue = value);
                    },
                    value: initialValue,
                    isField: true,
                    itemBuilder: (context) => [
                      ContextMenuItem(
                        child: Text('Florianópolis'),
                        value: 0,
                      ),
                      ContextMenuItem(
                        child: Text('Joinville'),
                        value: 1,
                      ),
                      ContextMenuItem(
                        child: Text('Blumenau'),
                        value: 2,
                      ),
                      ContextMenuItem(
                        child: Text('São Paulo'),
                        value: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
