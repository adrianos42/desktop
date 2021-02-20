import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ButtonHyperlinkPage extends StatefulWidget {
  ButtonHyperlinkPage({Key? key}) : super(key: key);

  @override
  _ButtonHyperlinkPageState createState() => _ButtonHyperlinkPageState();
}

class _ButtonHyperlinkPageState extends State<ButtonHyperlinkPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Hyperlink'),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Defaults.createCaption(context, 'Enabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  height: 50,
                  child: HyperlinkButton(
                    'https://github.com/adrianos42/desktop',
                    onPressed: (value) { },
                  ),
                ),
                Defaults.createCaption(context, 'Disabled'),
                Container(
                  decoration: Defaults.itemDecoration(context),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  height: 50,
                  child:
                      HyperlinkButton('https://github.com/adrianos42/desktop'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
