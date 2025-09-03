import 'package:desktop/desktop.dart';

import '../defaults.dart';
import 'content.dart';

class ButtonHyperlinkPage extends StatefulWidget {
  const ButtonHyperlinkPage({super.key});

  @override
  State<ButtonHyperlinkPage> createState() => _ButtonHyperlinkPageState();
}

class _ButtonHyperlinkPageState extends State<ButtonHyperlinkPage> {
  bool _disabled = false;
  bool _buttonContent = false;

  @override
  Widget build(BuildContext context) {
    final codeText =
        '''
return HyperlinkButton(
  'https://github.com/adrianos42/desktop',
  onPressed: ${_disabled ? '(value) {}' : 'null'},
);
''';

    return Defaults(
      header: 'Hyperlink',
      styleItems: Defaults.createStyle(HyperlinkTheme.of(context).toString()),
      items: [
        ItemTitle(
          title: 'Example',
          body: (context) => InputContent(
            enabled: _buttonContent,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                child: HyperlinkButton(
                  'https://github.com/adrianos42/desktop',
                  onPressed: !_disabled ? (value) {} : null,
                ),
              ),
            ),
          ),
          codeText: codeText,
          options: [
            Button.icon(
              Icons.lightMode,
              active: _buttonContent,
              onPressed: () => setState(() => _buttonContent = !_buttonContent),
            ),
            Button.icon(
              Icons.close,
              active: _disabled,
              onPressed: () => setState(() => _disabled = !_disabled),
            ),
          ],
        ),
      ],
    );
  }
}
