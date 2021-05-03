import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TooltipPage extends StatefulWidget {
  TooltipPage({Key? key}) : super(key: key);

  @override
  _TooltipPageState createState() => _TooltipPageState();
}

class _TooltipPageState extends State<TooltipPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Tooltip'),
        Expanded(
          child: Center(
            child: Button.text(
              'Text button with tooltip',
              tooltip: 'Text button with tooltip',
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
