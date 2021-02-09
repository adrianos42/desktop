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
          child: Center(
            child: HyperlinkButton('hyperlink', onPressed: () {},),
          ),
        ),
      ],
    );
  }
}
