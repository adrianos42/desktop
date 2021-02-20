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
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: 50.0,
                  child: Container(
                    width: 200.0,
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
                ),
                Defaults.createCaption(context, 'Disabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: 50.0,
                  child: Container(
                    width: 200.0,
                    child: DropDownButton(
                      enabled: false,
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
