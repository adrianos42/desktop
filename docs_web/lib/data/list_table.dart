import 'package:desktop/desktop.dart';

import '../defaults.dart';

const someDataTableHeader = ['Title', 'Album', 'Composer', 'Performer'];
const someDataTableRows = [
  [
    '''Angenehme, heitere Empfindungen, welche bei der Ankunft auf dem Lande im Menschen erwachen. Allegro ma non troppo (Pleasant, cheerful feelings which awaken in one on arrival in the country)''',
    '''Complete Symphonies''',
    '''Ludwig van Beethoven''',
    '''Andris Nelsons - Wiener Philharmoniker''',
  ],
  [
    '''Szene am Bach. Andante molto moto (Scene by the brook)''',
    '''Complete Symphonies''',
    '''Ludwig van Beethoven''',
    '''Andris Nelsons - Wiener Philharmoniker''',
  ],
  [
    '''Lustiges Zusammensein der Landleute. Allegro (Merry gathering of country folk)''',
    '''Complete Symphonies''',
    '''Ludwig van Beethoven''',
    '''Andris Nelsons - Wiener Philharmoniker''',
  ],
  [
    '''Donner, Sturm. Allegro (Thunderstorm)''',
    '''Complete Symphonies''',
    '''Ludwig van Beethoven''',
    '''Andris Nelsons - Wiener Philharmoniker''',
  ],
  [
    '''Hirtengesang, wohltätige, mit Dank an die Gottheit verbundene Gefühle nach dem Sturm. Allegretto (Shepherd's song, happy and thankful feelings after the storm)''',
    '''Complete Symphonies''',
    '''Ludwig van Beethoven''',
    '''Andris Nelsons - Wiener Philharmoniker''',
  ],
  [
    '''Romeo und Julia''',
    '''Symphonies''',
    '''Pyotr Il'yich Tchaikovsky''',
    '''Claudio Abbado - Chicago Symphony Orchestra''',
  ],
  [
    '''Marche Slave, Op. 31''',
    '''Symphonies''',
    '''Pyotr Il'yich Tchaikovsky''',
    '''Claudio Abbado - Chicago Symphony Orchestra''',
  ],
  [
    '''Act III, Appendice Ah que ton ame''',
    '''Guillaume Tell''',
    '''Gioacchino Rossini''',
    '''Lamberto Gardelli; Bacquier, Caballe, Gedda, Mes''',
  ],
  [
    '''Act IV, Scene 1 Ne m'abandonne pas''',
    '''Guillaume Tell''',
    '''Gioacchino Rossini''',
    '''Lamberto Gardelli; Bacquier, Caballe, Gedda, Mes''',
  ],
  [
    '''Act IV, Scene 1 Asile hereditaire''',
    '''Guillaume Tell''',
    '''Gioacchino Rossini''',
    '''Lamberto Gardelli; Bacquier, Caballe, Gedda, Mes''',
  ],
  [
    '''Symphony No. 7 in C Major, Op. 60 'Leningrad' - 1. Allegretto''',
    '''Symphonies nos. 6 & 7 "Leningrad"''',
    '''Shostakovich''',
    '''Andris Nelsons - Boston Symphony Orchestra''',
  ],
  [
    '''Finale II- 'Avrem lieta di maschere la notte' (Flora, Marchese, Dottore, Tutti)''',
    '''La Traviata''',
    '''Giuseppi Verdi''',
    '''Anna Netrebko, Rolando Vilazón, Thomas Hampson, Carlo Rizzi: Wiener Philharmoniker''',
  ],
];

class ListTablePage extends StatefulWidget {
  ListTablePage({Key? key}) : super(key: key);

  @override
  _ListTablePageState createState() => _ListTablePageState();
}

class _ListTablePageState extends State<ListTablePage> {
  @override
  Widget build(BuildContext context) {
    const someDataSample = ''' 
final borderColor = Theme.of(context).colorScheme.shade[40].toColor();
final borderSide = BorderSide(color: borderColor, width: 2.0);

ListTable(
  colCount: 4,
  itemCount: 10,
  tableBorder: TableBorder(
    bottom: borderSide,
    top: borderSide,
    left: borderSide,
    right: borderSide,
    horizontalInside: borderSide.copyWith(width: 1.0),
  ),
  onPressed: (row) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        body: Text(someDataTableRows[row][0]),
        title: Text(someDataTableRows[row][2]),
      ),
    );
  },
  colFraction: {0: 0.5},
  collapseOnDrag: false,
  headerColumnBorder: BorderSide(width: 2.0, color: borderColor),
  tableHeaderBuilder: (context, col, constraints) {
    return Container(
      constraints: constraints,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        someDataTableHeader[col],
        overflow: TextOverflow.ellipsis,
      ),
    );
  },
  tableRowBuilder: (context, row, col, constraints) {
    return Container(
      constraints: constraints,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        someDataTableRows[row][col],
        overflow: TextOverflow.ellipsis,
      ),
    );
  },
);
''';

    const codeSample = '''
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

    final borderColor = Theme.of(context).colorScheme.shade[40];
    final borderSide = BorderSide(color: borderColor, width: 1.0);
    final dataTableRows = [...someDataTableRows, ...someDataTableRows];

    return Defaults.createItemsWithTitle(
      context,
      items: [
        ItemTitle(
          body: (context) => ListTable(
            colCount: 4,
            itemCount: dataTableRows.length,
            allowColumnDragging: true,
            tableBorder: TableBorder(
              bottom: borderSide,
              top: borderSide,
              left: borderSide,
              right: borderSide,
              horizontalInside: borderSide.copyWith(width: 1.0),
            ),
            onPressed: (row, _) async {
              final dialog = showDialog(
                context,
                builder: (context) => Dialog(
                  body: Text(dataTableRows[row][0]),
                  title: Text(dataTableRows[row][2]),
                ),
              );
              await dialog.closed;
            },
            colFraction: const {0: 0.5},
            //collapseOnDrag: true,
            headerColumnBorder: borderSide,
            tableHeaderBuilder: (context, col) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  someDataTableHeader[col],
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
            tableRowBuilder: (context, row, col) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  dataTableRows[row][col],
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
          codeText: someDataSample,
          title: 'Example with data',
          height: 600.0,
          hasBorder: false,
        ),
        // ItemTitle(
        //   body: (context) => ListTable(
        //     colCount: 4,
        //     itemCount: 10,
        //     tableHeaderBuilder: (context, col, constraints) {
        //       return Container(
        //         constraints: constraints,
        //         alignment: Alignment.centerLeft,
        //         padding: const EdgeInsets.only(left: 8.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text('$col'),
        //           ],
        //         ),
        //       );
        //     },
        //     tableRowBuilder: (context, row, col, constraints) {
        //       return Container(
        //         constraints: constraints,
        //         alignment: Alignment.centerLeft,
        //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //         child: Text('$row$col'),
        //       );
        //     },
        //   ),
        //   codeText: codeSample,
        //   title: 'Borderless list table',
        //   height: 600.0,
        //   hasBorder: false,
        // ),
      ],
      header: 'List table',
    );
  }
}
