import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonRadioPage extends StatefulWidget {
  ButtonRadioPage({Key? key}) : super(key: key);

  @override
  _ButtonRadioPageState createState() => _ButtonRadioPageState();
}

class _ButtonRadioPageState extends State<ButtonRadioPage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
Container(
  width: 100.0,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Radio(
        value: value,
        onChanged: (fvalue) {
          setState(() {
            value = true;
          });
        },
      ),
      Radio(
        value: !value,
        onChanged: (fvalue) {
          setState(() {
            value = false;
          });
        },
      ),
    ],
  ),
)
''';

    const disabledCode = '''
Container(
  width: 100.0,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Radio(
        value: true,
      ),
      Radio(
        value: false,
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
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Radio(
                    value: value,
                    onChanged: (fvalue) {
                      setState(() {
                        value = true;
                      });
                    },
                  ),
                  Radio(
                    value: !value,
                    onChanged: (fvalue) {
                      setState(() {
                        value = false;
                      });
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
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Radio(
                    value: true,
                  ),
                  Radio(
                    value: false,
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
      header: 'Radio',
    );
  }
}
