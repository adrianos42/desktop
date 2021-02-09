import 'package:desktop/desktop.dart';
import 'defaults.dart';

class ScrollingPage extends StatefulWidget {
  ScrollingPage({Key? key}) : super(key: key);

  @override
  _ScrollingPageState createState() => _ScrollingPageState();
}

class _ScrollingPageState extends State<ScrollingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Scrolling'),
        Expanded(
          child: Center(
            child: Center(
              child: Text(''),
            ),
          ),
        ),
      ],
    );
  }
}
