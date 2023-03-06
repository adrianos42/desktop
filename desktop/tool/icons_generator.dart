import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

///
class IconsGenerator extends Generator {
  ///
  const IconsGenerator();

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final myFile = await File('fonts/Material_Icons_Sharp_Regular/codepoints')
        .readAsLines();

    final fields = <Field>[];

    for (final line in myFile) {
      final items = line.split(' ');
      
      var name = items[0];
      final code = items[1];

      if (name.startsWith(RegExp(r'\d'))) {
        name = '_$name';
        continue; // TODO(as): Add icons that start with a number.
      }

      if (name == 'try' || name == 'class') {
        name = '${name}_';
      }

      fields.add(Field((b) => b
        ..name = name
        ..static = true
        ..modifier = FieldModifier.constant
        ..type = refer('IconData')
        ..docs.add('/// The `${items[0]}` material icon.')
        ..assignment = Code('''
        IconData(
          0x$code,
          fontFamily: _kFontFamily,
          fontPackage: _kFontPackage,
        )
      ''')));
    }

    final themeLibrary = Library((b) => b
      ..body.add(
        Class((b) => b
          ..name = 'Icons'
          ..docs.add('''/// Icons from sharp 'Material Icons'.''')
          ..fields.addAll(fields)
          ..constructors.add(
            Constructor((b) => b
              ..name = '_'
              ..constant = true),
          )),
      ));

    return themeLibrary.accept(DartEmitter()).toString();
  }
}
