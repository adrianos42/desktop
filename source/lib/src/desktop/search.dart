import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'text_field.dart';
import 'theme_color.dart';
import 'theme_nav.dart';
import 'nav_scope.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NavThemeData navThemeData = NavTheme.of(context);

    if (NavScope.of(context)!.navAxis == Axis.horizontal && false) {
      return Container(
        color: navThemeData.background,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Encontrar items',
                style: Theme.of(context).textTheme.subtitle,
              ),
              SizedBox(height: 20.0),
              Text(
                'Search',
                style: Theme.of(context).textTheme.body1,
              ),
              Container(
                height: 10.0,
                //width: double.infinity,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 300.0,
                    child: TextField(
                      maxLines: 1,
                      enabled: true,
                      onSubmitted: (value) {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: 300.0,
        color: navThemeData.background,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Encontrar items',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Search',
                  style: Theme.of(context).textTheme.body1,
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 260.0,
                  child: TextField(
                    maxLines: 1,
                    enabled: true,
                    onSubmitted: (value) {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
