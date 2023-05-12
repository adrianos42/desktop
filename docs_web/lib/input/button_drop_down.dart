import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonDropDownPage extends StatefulWidget {
  const ButtonDropDownPage({super.key});

  @override
  State<ButtonDropDownPage> createState() => _ButtonDropDownPageState();
}

class _ButtonDropDownPageState extends State<ButtonDropDownPage> {
  int? initialValue;
  int? initialCustomValue;

  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = colorScheme.background[8];
    final hoverBackgroundColor = colorScheme.background[20];
    final waitingBackgroundColor = colorScheme.background[4];
    final highlightBackgroundColor = colorScheme.background[12];

    final codeText = '''
return SizedBox(
  width: 200.0,
  enabled: $_disabled,
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
        child: Text('Palhoça'),
        value: 2,
      ),
      ContextMenuItem(
        child: Text('Pedra Branca'),
        value: 3,
      ),
    ],
  ),
);
''';

    return Defaults(
      styleItems: Defaults.createStyle(DropDownTheme.of(context).toString()),
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 200.0,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(24.0),
              child: ContextMenuTheme.copyWith(
                child: DropDownButton(
                  enabled: !_disabled,
                  onSelected: (int value) {
                    setState(() => initialValue = value);
                  },
                  value: initialValue,
                  itemBuilder: (context) => const [
                    ContextMenuItem(
                      value: 0,
                      child: Text('Florianópolis'),
                    ),
                    ContextMenuItem(
                      value: 1,
                      child: Text('Joinville'),
                    ),
                    ContextMenuItem(
                      value: 2,
                      child: Text('Palhoça'),
                    ),
                    ContextMenuItem(
                      value: 3,
                      child: Text('Pedra Branca'),
                    ),
                  ],
                ),
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
          title: 'Example',
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 200.0,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(24.0),
              child: ContextMenuTheme.copyWith(
                color: backgroundColor,
                background: backgroundColor,
                highlightColor: highlightBackgroundColor,
                child: DropDownTheme.copyWith(
                  backgroundColor: backgroundColor,
                  hoverBackgroundColor: hoverBackgroundColor,
                  waitingBackgroundColor: waitingBackgroundColor,
                  color: backgroundColor,
                  hoverColor: hoverBackgroundColor,
                  waitingColor: waitingBackgroundColor,
                  child: DropDownButton(
                    onSelected: (int value) {
                      setState(() => initialCustomValue = value);
                    },
                    value: initialCustomValue,
                    itemBuilder: (context) => const [
                      ContextMenuItem(
                        value: 0,
                        child: Text('Florianópolis'),
                      ),
                      ContextMenuItem(
                        value: 1,
                        child: Text('Joinville'),
                      ),
                      ContextMenuItem(
                        value: 2,
                        child: Text('Palhoça'),
                      ),
                      ContextMenuItem(
                        value: 3,
                        child: Text('Pedra Branca'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          codeText: codeText,
          title: 'Custom background',
        ),
      ],
      header: 'Drop Down Menu',
    );
  }
}
