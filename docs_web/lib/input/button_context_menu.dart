import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonContextMenuPage extends StatefulWidget {
  ButtonContextMenuPage({Key? key}) : super(key: key);

  @override
  _ButtonContextMenuPageState createState() => _ButtonContextMenuPageState();
}

class _ButtonContextMenuPageState extends State<ButtonContextMenuPage> {
  String firstValue = 'Joinville';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Defaults.createHeader(context, 'Context menu'),
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
                  child: Row(
                    children: [
                      ContextMenuButton(
                        Icons.place,
                        value: firstValue,
                        onSelected: (String value) =>
                            setState(() => firstValue = value),
                        itemBuilder: (context) => [
                          ContextMenuItem(
                            child: Text('Florianópolis'),
                            value: 'Florianópolis',
                          ),
                          ContextMenuItem(
                            child: Text('Joinville'),
                            value: 'Joinville',
                          ),
                          ContextMenuItem(
                            child: Text('Blumenau'),
                            value: 'Blumenau',
                          ),
                          ContextMenuItem(
                            child: Text('São Paulo'),
                            value: 'São Paulo',
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        child: Text(firstValue),
                      ),
                    ],
                  ),
                ),
                Defaults.createCaption(context, 'Disabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  height: 50,
                  child: Row(
                    children: [
                      ContextMenuButton(
                        Icons.place,
                        value: firstValue,
                        enabled: false,
                        itemBuilder: (context) => [
                          ContextMenuItem(
                            child: Text('Florianópolis'),
                            value: 'Florianópolis',
                          ),
                          ContextMenuItem(
                            child: Text('Joinville'),
                            value: 'Joinville',
                          ),
                          ContextMenuItem(
                            child: Text('Blumenau'),
                            value: 'Blumenau',
                          ),
                          ContextMenuItem(
                            child: Text('São Paulo'),
                            value: 'São Paulo',
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        alignment: Alignment.center,
                        child: Text(
                          firstValue,
                          style: textTheme.body1.copyWith(
                            color: textTheme.textDisabled.toColor(),
                          ),
                        ),
                      ),
                    ],
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
