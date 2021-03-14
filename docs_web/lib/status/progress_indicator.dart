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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Defaults.createTitle(context, 'Linear'),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: Defaults.itemDecoration(context),
                child: LinearProgressIndicator(),
              ),
              Defaults.createTitle(context, 'Circular'),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: Defaults.itemDecoration(context),
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
