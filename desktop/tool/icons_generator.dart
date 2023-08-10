import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

extension StringCase on String {
  String toCamelCase() => replaceAllMapped(
      RegExp(r'(^[A-Z])|(?:_([a-z]))|(_)'),
      (match) => match[1] != null
          ? match[1]!.toLowerCase()
          : match[2] != null
              ? match[2]!.toUpperCase()
              : '');
}

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

      var name = items[0].toCamelCase();
      final code = items[1];

      if (name.startsWith(RegExp(r'\d'))) {
        name = '\$$name';
      }

      if (name == 'try' || name == 'class') {
        name = '\$$name';
      }

      fields.add(Field((b) => b
        ..name = name
        ..static = true
        ..modifier = FieldModifier.constant
        ..type = refer('IconData')
        ..docs.add('/// The `${items[0].toCamelCase()}` material icon.')
        ..assignment = Code('''
        IconData(
          0x$code,
          fontFamily: _kFontFamily,
          fontPackage: _kFontPackage,
        )
      ''')));
    }

    final themeLibrary = Library(
      (b) => b
        ..body.add(
          Class(
            (b) => b
              ..name = 'Icons'
              ..docs.add('''/// Icons from sharp 'Material Icons'.''')
              ..fields.addAll(fields)
              ..constructors.add(
                Constructor(
                  (b) => b
                    ..name = '_'
                    ..constant = true,
                ),
              ),
          ),
        ),
    );

    return themeLibrary.accept(DartEmitter()).toString();
  }
}
