import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ProgressIndicatorPage extends StatefulWidget {
  ProgressIndicatorPage({Key? key}) : super(key: key);

  @override
  _ProgressIndicatorPageState createState() => _ProgressIndicatorPageState();
}

class _ProgressIndicatorPageState extends State<ProgressIndicatorPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Progress indicator'),
        Expanded(
          child: Center(
            child: LinearProgressIndicator(
            ),
          ),
        ),
      ],
    );
  }
}
