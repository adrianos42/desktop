import 'package:desktop/desktop.dart';
import '../defaults.dart';

class ListTablePage extends StatefulWidget {
  ListTablePage({Key? key}) : super(key: key);

  @override
  _ListTablePageState createState() => _ListTablePageState();
}

class _ListTablePageState extends State<ListTablePage> {
  @override
  Widget build(BuildContext context) {
    final codeSample = '''
ListTable(
  colCount: 4,
  itemCount: 15,
  tableHeaderBuilder: (context, col, constraints) {
    return Container(
      constraints: constraints,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Text('\$col'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  },
  tableRowBuilder: (context, row, col, constraints) {
    return Container(
      constraints: constraints,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text('\$row\$col'),
    );
  },
)
''';
    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
            body: (context) => ListTable(
                  colCount: 4,
                  itemCount: 15,
                  tableHeaderBuilder: (context, col, constraints) {
                    return Container(
                      constraints: constraints,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Text('$col'),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    );
                  },
                  tableRowBuilder: (context, row, col, constraints) {
                    return Container(
                      constraints: constraints,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('$row$col'),
                    );
                  },
                ),
            codeText: codeSample,
            title: 'Basic example',
            height: 900.0)
      ],
      header: 'List table',
    );
  }
}
