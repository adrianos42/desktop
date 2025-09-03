import 'package:desktop/desktop.dart';

import '../defaults.dart';
import 'content.dart';

class ButtonDropDownPage extends StatefulWidget {
  const ButtonDropDownPage({super.key});

  @override
  State<ButtonDropDownPage> createState() => _ButtonDropDownPageState();
}

class _ButtonDropDownPageState extends State<ButtonDropDownPage> {
  int? initialValue;
  int? initialCustomValue;

  bool _disabled = false;
  // bool _buttonContent = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = colorScheme.background[8];
    final hoverBackgroundColor = colorScheme.background[20];
    final waitingBackgroundColor = colorScheme.background[4];
    final highlightBackgroundColor = colorScheme.background[12];

    final codeText =
        '''
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
        child: Text('Item 1'),
        value: 0,
      ),
      ContextMenuItem(
        child: Text('Item 2'),
        value: 1,
      ),
      ContextMenuItem(
        child: Text('Item 3'),
        value: 2,
      ),
      ContextMenuItem(
        child: Text('Item 4'),
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
          title: 'Example',
          body: (context) => InputContent(
            enabled: false,
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 200.0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
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
                          child: Text(
                            'Item 1',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ContextMenuItem(
                          value: 1,
                          child: Text(
                            'Item 2',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ContextMenuItem(
                          value: 2,
                          child: Text(
                            'Item 3',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ContextMenuItem(
                          value: 3,
                          child: Text(
                            'Item 4',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          options: [
            // Button.icon(
            //   Icons.lightMode,
            //   active: _buttonContent,
            //   onPressed: () => setState(
            //     () => _buttonContent = !_buttonContent,
            //   ),
            // ),
            Button.icon(
              Icons.close,
              active: _disabled,
              onPressed: () => setState(() => _disabled = !_disabled),
            ),
          ],
          codeText: codeText,
        ),
        ItemTitle(
          title: 'Custom background',
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
                        child: Text('Item 1', overflow: TextOverflow.ellipsis),
                      ),
                      ContextMenuItem(
                        value: 1,
                        child: Text('Item 2', overflow: TextOverflow.ellipsis),
                      ),
                      ContextMenuItem(
                        value: 2,
                        child: Text('Item 3', overflow: TextOverflow.ellipsis),
                      ),
                      ContextMenuItem(
                        value: 3,
                        child: Text('Item 4', overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          codeText: codeText,
        ),
      ],
      header: 'Drop Down Menu',
    );
  }
}
