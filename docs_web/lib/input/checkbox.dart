import 'package:desktop/desktop.dart';
import '../defaults.dart';

class CheckboxPage extends StatefulWidget {
  CheckboxPage({Key? key}) : super(key: key);

  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool first = false;
  bool second = false;
  bool? third;

  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
Container(
  width: 200.0,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Checkbox(
        value: first,
        tristate: false,
        onChanged: (fvalue) {
          setState(() => first = fvalue!);
        },
      ),
      Checkbox(
        value: second,
        tristate: false,
        onChanged: (fvalue) {
          setState(() => second = fvalue!);
        },
      ),
      Checkbox(
        value: third,
        tristate: true,
        onChanged: (fvalue) {
          setState(() => third = fvalue);
        },
      ),
    ],
  ),
)
''';

    const disabledCode = '''
Container(
  width: 200.0,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Checkbox(
        value: true,
        tristate: false,
      ),
      Checkbox(
        value: false,
        tristate: false,
      ),
      Checkbox(
        value: null,
        tristate: true,
      ),
    ],
  ),
)
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Checkbox(
                    value: first,
                    tristate: false,
                    onChanged: (fvalue) {
                      setState(() => first = fvalue!);
                    },
                  ),
                  Checkbox(
                    value: second,
                    tristate: false,
                    onChanged: (fvalue) {
                      setState(() => second = fvalue!);
                    },
                  ),
                  Checkbox(
                    value: third,
                    tristate: true,
                    onChanged: (fvalue) {
                      setState(() => third = fvalue);
                    },
                  ),
                ],
              ),
            ),
          ),
          codeText: enabledCode,
          title: 'Enabled',
          height: 400.0,
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Checkbox(
                    value: true,
                    tristate: false,
                  ),
                  Checkbox(
                    value: false,
                    tristate: false,
                  ),
                  Checkbox(
                    value: null,
                    tristate: true,
                  ),
                ],
              ),
            ),
          ),
          codeText: disabledCode,
          title: 'Disabled',
          height: 400.0,
        ),
      ],
      header: 'Checkbox',
    );
  }
}
