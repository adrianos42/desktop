import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonDropDownPage extends StatefulWidget {
  ButtonDropDownPage({Key? key}) : super(key: key);

  @override
  _ButtonDropDownPageState createState() => _ButtonDropDownPageState();
}

class _ButtonDropDownPageState extends State<ButtonDropDownPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Drop down menu'),
        Expanded(
          child: DropDownButton(
            initialValue: 1,
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
    );
  }
}
