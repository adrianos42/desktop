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
    const enabledText = ''' 
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
      child: Text('Pedra Branca'),
      value: 'Pedra Branca',
    ),
  ],
),
''';

    const disabledText = '''
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
      child: Text('Pedra Branca'),
      value: 'Pedra Branca',
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
            child: Row(
              children: [
                ContextMenuButton(
                  const Icon(Icons.place),
                  value: firstValue,
                  onSelected: (String value) =>
                      setState(() => firstValue = value),
                  itemBuilder: (context) => const [
                    ContextMenuItem(
                      value: 'Florianópolis',
                      child: Text('Florianópolis'),
                    ),
                    ContextMenuItem(
                      value: 'Joinville',
                      child: Text('Joinville'),
                    ),
                    ContextMenuItem(
                      value: 'Palhoça',
                      child: Text('Palhoça'),
                    ),
                    ContextMenuItem(
                      value: 'Pedra Branca',
                      child: Text('Pedra Branca'),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(firstValue),
                ),
              ],
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
              child: Row(
                children: [
                  ContextMenuButton(
                    const Icon(Icons.place),
                    value: firstValue,
                    enabled: false,
                    itemBuilder: (context) => const [
                      ContextMenuItem(
                        value: 'Florianópolis',
                        child: Text('Florianópolis'),
                      ),
                      ContextMenuItem(
                        value: 'Joinville',
                        child: Text('Joinville'),
                      ),
                      ContextMenuItem(
                        value: 'Palhoça',
                        child: Text('Palhoça'),
                      ),
                      ContextMenuItem(
                        value: 'Pedra Branca',
                        child: Text('Pedra Branca'),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      firstValue,
                      style: textTheme.body1.copyWith(
                        color: textTheme.textDisabled,
                      ),
                    ),
                  ),
                ],
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
