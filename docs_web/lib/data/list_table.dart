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
  const ListTablePage({super.key});

  @override
  State<ListTablePage> createState() => _ListTablePageState();
}

class _ListTablePageState extends State<ListTablePage> {
  bool _allowDragDataExample = true;
  bool _allowDragBordelessExample = false;

  String get someDataSample => ''' 
final borderColor = Theme.of(context).colorScheme.shade[40];
final borderSide = BorderSide(color: borderColor, width: 1.0);
final dataTableRows = [...someDataTableRows, ...someDataTableRows];

return ListTable(
  colCount: 4,
  allowColumnDragging: $_allowDragDataExample,
  tableBorder: TableBorder(
    bottom: borderSide,
    top: borderSide,
    left: borderSide,
    right: borderSide,
    horizontalInside: borderSide,
  ),
  header: ListTableHeader(
    columnBorder: borderSide,
    builder: (context, col) => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        someDataTableHeader[col],
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ),
  rows: List.generate(dataTableRows.length, (row) {
    return ListTableRow(
      onPressed: (_) async {
        final dialog = showDialog(
          context,
          builder: (context) => Dialog(
            title: Text(dataTableRows[row][2]),
            body: Text(dataTableRows[row][0]),
          ),
        );
        await dialog.closed;
      },
      builder: (context, col) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          dataTableRows[row][col],
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }),
  colFraction: const {0: 0.5},
);
''';

  String get codeSample => '''
return ListTable(
  colCount: 4,
  rows: List.generate(10, (row) {
    return ListTableRow(
      builder: (context, col) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('\$row\$col'),
      ),
    );
  }),
  allowColumnDragging: $_allowDragBordelessExample,
  header: ListTableHeader(
    builder: (context, col) => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 8.0),
      child: Text('\$col'),
    ),
  ),
);
''';

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.shade[40];
    final borderSide = BorderSide(color: borderColor, width: 1.0);
    final dataTableRows = [...someDataTableRows, ...someDataTableRows];

    return Defaults(
      styleItems: Defaults.createStyle(ListTableTheme.of(context).toString()),
      items: [
        ItemTitle(
          title: 'Example with data',
          body: (context) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: ListTable(
              colCount: 4,
              allowColumnDragging: _allowDragDataExample,
              tableBorder: TableBorder(
                bottom: borderSide,
                top: borderSide,
                left: borderSide,
                right: borderSide,
                horizontalInside: borderSide,
              ),
              header: ListTableHeader(
                columnBorder: borderSide,
                builder: (context, col) => Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    someDataTableHeader[col],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              rows: List.generate(dataTableRows.length, (row) {
                return ListTableRow(
                  onPressed: (_) async {
                    await Dialog.showDialog(
                      context,
                      title: Text(dataTableRows[row][2]),
                      body: Text(dataTableRows[row][0]),
                    );
                  },
                  builder: (context, col) => Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      dataTableRows[row][col],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }),
              colFraction: const {0: 0.5},
            ),
          ),
          codeText: someDataSample,
          options: [
            Button.icon(
              Icons.dragIndicator,
              active: _allowDragDataExample,
              tooltip: 'Allow column dragging',
              onPressed: () => setState(
                () => _allowDragDataExample = !_allowDragDataExample,
              ),
            ),
          ],
        ),
        ItemTitle(
          title: 'Borderless list table',
          body: (context) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: ListTable(
              colCount: 4,
              rows: List.generate(10, (row) {
                return ListTableRow(
                  builder: (context, col) => Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('$row$col'),
                  ),
                );
              }),
              allowColumnDragging: _allowDragBordelessExample,
              header: ListTableHeader(
                builder: (context, col) => Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('$col'),
                ),
              ),
            ),
          ),
          codeText: codeSample,
          options: [
            Button.icon(
              Icons.dragIndicator,
              tooltip: 'Allow column dragging',
              active: _allowDragBordelessExample,
              onPressed: () => setState(
                () => _allowDragBordelessExample = !_allowDragBordelessExample,
              ),
            ),
          ],
        ),
      ],
      header: 'List Table',
    );
  }
}
