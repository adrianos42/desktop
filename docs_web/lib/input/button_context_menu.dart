import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonContextMenuPage extends StatefulWidget {
  ButtonContextMenuPage({Key? key}) : super(key: key);

  @override
  _ButtonContextMenuPageState createState() => _ButtonContextMenuPageState();
}

class _ButtonContextMenuPageState extends State<ButtonContextMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Context menu button'),
        Expanded(
          child: ContextMenuButton(
            Icons.place,
            initialValue: 0,
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
