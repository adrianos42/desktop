import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'icons_generator.dart';
import 'theme_data_generator.dart';

///
Builder themeDataBuilder(BuilderOptions options) =>
    SharedPartBuilder([const ThemeDataGenerator()], 'themeData');

///
Builder iconsBuilder(BuilderOptions options) =>
    SharedPartBuilder([const IconsGenerator()], 'icons');
