import 'package:desktop/desktop.dart';
import '../defaults.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Search'),
        Expanded(
          child: Text(''),
        ),
      ],
    );
  }
}
