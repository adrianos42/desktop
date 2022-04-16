import 'dart:async';
import 'dart:io';

String _getText(String value) {
  return '''
import 'package:flutter/widgets.dart';

const _kFontFamily = 'SharpMaterialIcons';
const _kFontPackage = 'desktop';

/// Icons from sharp 'Material Icons'.
class Icons {
  Icons._();
  $value
}
''';
}

Future<void> _main() async {
  final myFile = await File('../fonts/Material_Icons_Sharp_Regular/codepoints')
      .readAsLines();

  var listValues = '';

  for (final line in myFile) {
    final items = line.split(' ');
    //var name = _toCamelCase(items[0]);
    var name = items[0];
    final code = items[1];

    if (name.startsWith(RegExp(r'\d'))) {
      name = '_$name';
      continue; // TODO(as): Add icons that start with a number.
    }

    if (name == 'try' || name == 'class') {
      name = '${name}_';
    }

    listValues += '''

  /// `${items[0]}` material icon.
  static const $name = IconData(
    0x$code,
    fontFamily: _kFontFamily,
    fontPackage: _kFontPackage,
  );
    ''';
  }

  listValues = _getText(listValues);

  final iconFile = File('src/desktop/icons.dart');
  final sink = iconFile.openWrite(mode: FileMode.write);
  sink.write(listValues);
}
