import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TooltipPage extends StatefulWidget {
  TooltipPage({super.key});

  @override
  _TooltipPageState createState() => _TooltipPageState();
}

class _TooltipPageState extends State<TooltipPage> {
  final codeExample = '''
return Button.text(
  'Button with tooltip',
  tooltip: 'Button with tooltip',
  onPressed: () {},
);
''';

  @override
  Widget build(BuildContext context) {
    return Defaults(
      styleItems: Defaults.createStyle(TooltipTheme.of(context).toString()),
      header: 'Tooltip',
      items: [
        ItemTitle(
          body: (context) => Center(
            child: Button.text(
              'Button with tooltip',
              tooltip: 'Button with tooltip',
              onPressed: () {},
            ),
          ),
          codeText: codeExample,
          title: 'Button with tooltip',
        )
      ],
    );
  }
}
