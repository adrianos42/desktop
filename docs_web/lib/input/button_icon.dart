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
    final enabledCode = '''
IconButton(
  Icons.place,
  onPressed: () {},
)
''';

    final disabledCode = '''
IconButton(Icons.place)
''';

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
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
            child: IconButton(Icons.place),
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
