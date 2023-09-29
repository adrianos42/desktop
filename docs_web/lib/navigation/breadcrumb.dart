import 'package:desktop/desktop.dart';
import '../defaults.dart';

class BreadcrumbPage extends StatefulWidget {
  const BreadcrumbPage({super.key});

  @override
  State<BreadcrumbPage> createState() => _BreadcrumbPageState();
}

class _BreadcrumbPageState extends State<BreadcrumbPage> {
  late BreadcrumbController breadcrumbController;

  Widget buildPage(BuildContext context, int index) {
    return _MainPage(index, () {
      breadcrumbController.push(
        builder: buildPage,
        breadcrumbBuilder: buildItem,
      );
    });
  }

  Widget buildItem(BuildContext context, int index) {
    return Text('page $index');
  }

  @override
  void initState() {
    super.initState();

    breadcrumbController = BreadcrumbController(
      builder: buildPage,
      breadcrumbBuilder: buildItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(text: '''
return Column(
  children: [
    Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Defaults.createSubheader(context, 'Page \$count'),
    ),
    Expanded(
      child: Center(
        child: Button.text(
          'Next page',
          onPressed: pushPage,
        ),
      ),
    ),
  ],
);
''');

    return Defaults(
      styleItems: Defaults.createStyle(BreadcrumbTheme.of(context).toString()),
      items: [
        ItemTitle(
          body: (context) => Breadcrumb(
            controller: breadcrumbController,
          ),
          codeText: textController.text,
          title: 'Basic example',
        )
      ],
      header: 'Breadcrumb',
    );
  }
}

class _MainPage extends StatelessWidget {
  _MainPage(this.count, this.pushPage);

  final int count;

  final VoidCallback pushPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Defaults.createSubheader(context, 'Page $count'),
        ),
        Expanded(
          child: Center(
            child: Button.text(
              'Next page',
              onPressed: pushPage,
            ),
          ),
        ),
      ],
    );
  }
}
