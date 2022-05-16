import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonIconPage extends StatefulWidget {
  ButtonIconPage({Key? key}) : super(key: key);

  @override
  _ButtonIconPageState createState() => _ButtonIconPageState();
}

class _ButtonIconPageState extends State<ButtonIconPage> {
  @override
  Widget build(BuildContext context) {
    const enabledCode = '''
Button.icon(
  Icons.place,
  onPressed: () {},
)
''';

    const disabledCode = '''
Button.icon(Icons.place)
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Button.icon(
              Icons.place,
              onPressed: () {},
            ),
          ),
          codeText: enabledCode,
          title: 'Enabled',
          height: 200.0,
        ),
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: Button.icon(Icons.place),
          ),
          codeText: disabledCode,
          title: 'Disabled',
          height: 200.0,
        ),
      ],
      header: 'Icon button',
    );
  }
}
