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

    final enabledText = ''' 
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
''';

    final disabledText = '''
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
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Container(
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
          ),
          codeText: enabledText,
          title: 'Enabled',
          height: 400.0,
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Container(
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
          ),
          codeText: disabledText,
          title: 'Disabled',
          height: 400.0,
        ),
      ],
      header: 'Context menu',
    );
  }
}
