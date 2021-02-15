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
    return Column(
      children: [
        Defaults.createHeader(context, 'List table'),
        Defaults.createTitle(context, 'Basic table'),
        Expanded(
          child: Container(
            //decoration: Defaults.itemDecoration(context),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            child: ListTable(
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
          ),
        ),
      ],
    );
  }
}
