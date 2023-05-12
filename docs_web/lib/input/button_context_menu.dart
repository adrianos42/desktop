import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonContextMenuPage extends StatefulWidget {
  const ButtonContextMenuPage({super.key});

  @override
  State<ButtonContextMenuPage> createState() => _ButtonContextMenuPageState();
}

class _ButtonContextMenuPageState extends State<ButtonContextMenuPage> {
  String _firstValue = 'Joinville';

  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    final codeText = ''' 
return ContextMenuButton(
  Icon(Icons.place),
  value: firstValue,
  enabled: $_disabled,
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
);
''';

    final themeData = ContextMenuTheme.of(context);

    return Defaults(
      styleItems: Defaults.createStyle(themeData.toString()),
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContextMenuButton(
                  const Icon(Icons.place),
                  value: _firstValue,
                  enabled: !_disabled,
                  onSelected: (String value) =>
                      setState(() => _firstValue = value),
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
                  child: Text(_firstValue),
                ),
              ],
            ),
          ),
          options: [
            Button.icon(
              Icons.close,
              active: _disabled,
              onPressed: () => setState(() => _disabled = !_disabled),
            ),
          ],
          codeText: codeText,
          title: 'Example',
        ),
      ],
      header: 'Context Menu',
    );
  }
}
