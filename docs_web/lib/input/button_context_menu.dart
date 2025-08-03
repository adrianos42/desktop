import 'package:desktop/desktop.dart';

import '../defaults.dart';

class ButtonContextMenuPage extends StatefulWidget {
  const ButtonContextMenuPage({super.key});

  @override
  State<ButtonContextMenuPage> createState() => _ButtonContextMenuPageState();
}

class _ButtonContextMenuPageState extends State<ButtonContextMenuPage> {
  String _firstValue = 'Item 1';

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
      value: 'Item 1',
      child: Text('Item 1'),
    ),
    ContextMenuItem(
      value: 'Item 2',
      child: Text('Item 2'),
    ),
    ContextMenuItem(
      value: 'Item 3',
      child: Text('Item 3'),
    ),
    ContextMenuItem(
      value: 'Item 4',
      child: Text('Item 4'),
    ),
  ],
);
''';

    final themeData = ContextMenuTheme.of(context);

    return Defaults(
      styleItems: Defaults.createStyle(themeData.toString()),
      items: [
        ItemTitle(
          title: 'Example',
          body: (context) => Center(
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContextMenuButton.icon(
                    Icons.place,
                    value: _firstValue,
                    onSelected: !_disabled
                        ? (String value) => setState(() => _firstValue = value)
                        : null,
                    itemBuilder: (context) => const [
                      ContextMenuItem(
                        value: 'Item 1',
                        child: Text('Item 1'),
                      ),
                      ContextMenuItem(
                        value: 'Item 2',
                        child: Text('Item 2'),
                      ),
                      ContextMenuItem(
                        value: 'Item 3',
                        child: Text('Item 3'),
                      ),
                      ContextMenuItem(
                        value: 'Item 4',
                        child: Text('Item 4'),
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
          ),
          options: [
            Button.icon(
              Icons.close,
              active: _disabled,
              onPressed: () => setState(() => _disabled = !_disabled),
            ),
          ],
          codeText: codeText,
        ),
      ],
      header: 'Context Menu',
    );
  }
}
