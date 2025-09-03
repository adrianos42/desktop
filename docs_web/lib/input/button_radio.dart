import 'package:desktop/desktop.dart';

import '../defaults.dart';
import 'content.dart';

class ButtonRadioPage extends StatefulWidget {
  const ButtonRadioPage({super.key});

  @override
  State<ButtonRadioPage> createState() => _ButtonRadioPageState();
}

class TestRegistry<T> extends RadioGroupRegistry<T> {
  final Set<RadioClient<T>> clients = <RadioClient<T>>{};
  @override
  T? groupValue;

  @override
  ValueChanged<T?> get onChanged =>
      (T? newValue) => groupValue = newValue;

  @override
  void registerClient(RadioClient<T> radio) => clients.add(radio);

  @override
  void unregisterClient(RadioClient<T> radio) => clients.remove(radio);
}

class _ButtonRadioPageState extends State<ButtonRadioPage> {
  String? _valueGroup = 'First';
  bool _disabled = false;
  bool _buttonContent = false;
  bool _toggleable = false;

  @override
  Widget build(BuildContext context) {
    const groupCode = '''
 return RadioGroup<String>(
  onChanged: (value) {
    setState(() => _valueGroup = value);
  },
  groupValue: _valueGroup,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: 'First',
            enabled: !_disabled,
            toggleable: _toggleable,
          ),
          const Text('First'),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: 'Second',
            enabled: !_disabled,
            toggleable: _toggleable,
          ),
          const Text('Second'),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: 'Third',
            enabled: !_disabled,
            toggleable: _toggleable,
          ),
          const Text('Third'),
        ],
      ),
    ],
  ),
);
''';

    return Defaults(
      header: 'Radio',
      styleItems: Defaults.createStyle(RadioTheme.of(context).toString()),
      items: [
        ItemTitle(
          title: 'Group',
          body: (context) => InputContent(
            enabled: _buttonContent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RadioGroup<String>(
                  onChanged: (value) {
                    setState(() => _valueGroup = value);
                  },
                  groupValue: _valueGroup,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: 'First',
                            enabled: !_disabled,
                            toggleable: _toggleable,
                          ),
                          const Text('First'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: 'Second',
                            enabled: !_disabled,
                            toggleable: _toggleable,
                          ),
                          const Text('Second'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: 'Third',
                            enabled: !_disabled,
                            toggleable: _toggleable,
                          ),
                          const Text('Third'),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text('Selected value: ${_valueGroup ?? 'None'}'),
                ),
              ],
            ),
          ),
          codeText: groupCode,
          options: [
            Button.icon(
              Icons.lightMode,
              active: _buttonContent,
              onPressed: () => setState(() => _buttonContent = !_buttonContent),
            ),
            Button.icon(
              Icons.toggleOn,
              active: _toggleable,
              onPressed: () => setState(() => _toggleable = !_toggleable),
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
