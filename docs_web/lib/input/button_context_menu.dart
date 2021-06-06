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
    final enabledText = ''' 
ContextMenuButton(
  Icon(Icons.place),
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
      child: Text('Palhoça'),
      value: 'Palhoça',
    ),
    ContextMenuItem(
      child: Text('São José'),
      value: 'São José',
    ),
  ],
),
''';

    final disabledText = '''
ContextMenuButton(
  Icon(Icons.place),
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
      child: Text('Palhoça'),
      value: 'Palhoça',
    ),
    ContextMenuItem(
      child: Text('São José'),
      value: 'São José',
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
                    Icon(Icons.place),
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
                        child: Text('Palhoça'),
                        value: 'Palhoça',
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
          body: (context) {
            final textTheme = Theme.of(context).textTheme;
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Row(
                  children: [
                    ContextMenuButton(
                      Icon(Icons.place),
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
                          child: Text('Palhoça'),
                          value: 'Palhoça',
                        ),
                        ContextMenuItem(
                          child: Text('São José'),
                          value: 'São José',
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
            );
          },
          codeText: disabledText,
          title: 'Disabled',
          height: 400.0,
        ),
      ],
      header: 'Context menu',
    );
  }
}
