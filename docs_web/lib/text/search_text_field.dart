import 'package:desktop/desktop.dart';
import '../defaults.dart';

class SearchTextFieldPage extends StatefulWidget {
  const SearchTextFieldPage({super.key});

  @override
  State<SearchTextFieldPage> createState() => _SearchTextFieldPageState();
}

class _SearchTextFieldPageState extends State<SearchTextFieldPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    const basicExample = 'return SearchTextField();';

    return Defaults(
      header: 'Search Text Field',
      items: [
        ItemTitle(
          body: (context) => Container(
            margin: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0,
              child: SearchTextField(focusNode: _focusNode),
            ),
          ),
          codeText: basicExample,
          title: 'Basic example',
        ),
      ],
    );
  }
}
