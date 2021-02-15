import 'package:desktop/desktop.dart';
import '../defaults.dart';

class BreadcrumbPage extends StatefulWidget {
  BreadcrumbPage({Key? key}) : super(key: key);

  @override
  _BreadcrumbPageState createState() => _BreadcrumbPageState();
}

class _BreadcrumbPageState extends State<BreadcrumbPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Defaults.createHeader(context, 'Breadcrumb'),
        Defaults.createTitle(context, 'Breadcrumb example'),
        Expanded(
          child: Container(
            decoration: Defaults.itemDecoration(context),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            // child: Breadcrumb(
            //   initialRoute: '/page1',
            //   routeBuilder: (context, settings) {
            //     print(settings.name);
            //     switch (settings.name) {
            //       case '/page1':
            //         return DesktopPageRoute(
            //           builder: (context) {
            //             return Center(
            //               child: TextButton(
            //                 'navigate page 2',
            //                 onPressed: () =>
            //                     Navigator.of(context).pushNamed('/page2'),
            //               ),
            //             );
            //           },
            //           settings: settings,
            //         );
            //       case '/page2':
            //         return DesktopPageRoute(
            //           builder: (context) {
            //             return Center(
            //               child: TextButton(
            //                 'navigate page 2',
            //                 onPressed: () =>
            //                     Navigator.of(context).pushNamed('/page3'),
            //               ),
            //             );
            //           },
            //           settings: settings,
            //         );
            //     }

            //     throw Exception('Page not found');
            //   },
            // ),
          ),
        ),
      ],
    );
  }
}
