import 'package:analyzer/dart/element/nullability_suffix.dart'
    show NullabilitySuffix;
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

extension _Case on String {
  String toPascalCase() => replaceAllMapped(
    RegExp(r'(^[a-z])|(?:_([a-z]))|(_)'),
    (match) => match[1] != null
        ? match[1]!.toUpperCase()
        : match[2] != null
        ? match[2]!.toUpperCase()
        : '',
  );

  String toCamelCase() => replaceAllMapped(
    RegExp(r'(^[A-Z])|(?:_([a-z]))|(_)'),
    (match) => match[1] != null
        ? match[1]!.toLowerCase()
        : match[2] != null
        ? match[2]!.toUpperCase()
        : '',
  );
}

///
class ThemeDataGenerator extends Generator {
  ///
  const ThemeDataGenerator();

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final classes = <Class>[];

    final themeName = library.element.firstFragment.source.shortName
        .replaceAll('.dart', '')
        .toPascalCase();

    for (final classElement in library.classes) {
      final targetThemeDataClassName = '${themeName}ThemeData';
      final targetThemeClassName = '${themeName}Theme';

      // Only generate for get fields, final fields must be ignored.
      final fields = classElement.fields2.where(
        (e) => e.getter2 != null && !e.name3!.startsWith('_'),
      );

      for (final field in fields) {
        if (field.getter2!.documentationComment == null) {
          throw InvalidGenerationSourceError(
            'Fields in theme data must have documentation.',
            todo: 'Create documentation for ${field.displayName}.',
            element: field,
          );
        }
      }

      final methods = <Method>[];

      methods.add(
        Method(
          (b) => b
            ..name = 'copyWith'
            ..returns = refer(targetThemeDataClassName)
            ..optionalParameters.addAll(
              fields.map(
                (e) => Parameter(
                  (b) => b
                    ..type = refer('${e.type}?')
                    ..name = e.name3!
                    ..named = true,
                ),
              ),
            )
            ..body = Code(
              'return $targetThemeDataClassName(${fields.fold('', (p, e) => '$p${e.name3}: ${e.name3} ?? this.${e.name3},')});',
            )
            ..docs.add(
              '/// Makes a copy of [$targetThemeDataClassName] overwriting selected fields.',
            ),
        ),
      );

      methods.add(
        Method(
          (b) => b
            ..name = 'merge'
            ..returns = refer(targetThemeDataClassName)
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..name = 'other'
                  ..type = refer('$targetThemeDataClassName?'),
              ),
            )
            ..body = Code('''
                if (other == null) {
                  return this;
                }
                return copyWith(${fields.fold('', (p, e) => '$p${e.name3}: other.${e.name3},')});''')
            ..docs.add(
              '/// Merges the theme data [$targetThemeDataClassName].',
            ),
        ),
      );

      methods.add(
        Method(
          (b) => b
            ..name = '_isConcrete'
            ..returns = refer('bool')
            ..type = MethodType.getter
            ..body = Code('''
              return ${fields.where((e) => e.type.nullabilitySuffix == NullabilitySuffix.none).fold('', (String p, e) => '$p${p.isNotEmpty ? '&&' : ''}${e.name3} != null')};
          '''),
        ),
      );

      methods.add(
        Method(
          (b) => b
            ..name = 'hashCode'
            ..returns = refer('int')
            ..annotations.add(refer('override'))
            ..type = MethodType.getter
            ..body = Code('''
              return Object.hashAll([${fields.fold('', (p, e) => '$p${e.name3},')}]);
          '''),
        ),
      );

      methods.add(
        Method(
          (b) => b
            ..name = 'toString'
            ..returns = refer('String')
            ..annotations.add(refer('override'))
            ..body = Code('''
              return r\'\'\'
${fields.fold('', (p, e) => '$p${e.name3}:${e.getter2!.documentationComment!.replaceAll(RegExp(r'///'), '')};;')}
\'\'\';
          '''),
        ),
      );

      methods.add(
        Method(
          (b) => b
            ..name = 'hashCode'
            ..name = 'operator =='
            ..returns = refer('bool')
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..name = 'other'
                  ..type = refer('covariant $targetThemeDataClassName'),
              ),
            )
            ..annotations.add(refer('override'))
            ..body = Code(
              '''
              return identical(this, other) || ${fields.fold('', (p, e) => '${p.isNotEmpty ? '$p &&' : ''} other.${e.name3} == ${e.name3} ')};''',
            ),
        ),
      );

      if (classElement.documentationComment == null) {
        throw InvalidGenerationSourceError(
          'Class must have documentation.',
          todo: 'Create documentation for ${classElement.displayName}.',
          element: classElement,
        );
      }

      classes.add(
        Class(
          (b) => b
            ..methods.addAll(methods)
            ..fields.addAll(
              fields
                  .map(
                    (e) => Field(
                      (b) => b
                        ..name = e.name3
                        ..modifier = FieldModifier.final$
                        ..docs.add(e.getter2!.documentationComment!)
                        ..type = refer('${e.type}?'),
                    ),
                  )
                  .toList(),
            )
            ..name = targetThemeDataClassName
            ..annotations.add(refer('immutable'))
            ..constructors.add(
              Constructor(
                (b) => b
                  ..constant = true
                  ..optionalParameters.addAll(
                    fields.map(
                      (e) => Parameter(
                        (b) => b
                          ..name = e.name3!
                          ..toThis = true
                          ..named = true,
                      ),
                    ),
                  )
                  ..docs.add('/// Creates a [$targetThemeDataClassName].'),
              ),
            )
            ..docs.add(classElement.documentationComment!),
        ),
      );

      final themeMethods = <Method>[];
      final themeFields = <Field>[];

      themeFields.add(
        Field(
          (b) => b
            ..name = 'data'
            ..type = refer(targetThemeDataClassName)
            ..modifier = FieldModifier.final$
            ..docs.add(
              '/// The data representing this [$targetThemeClassName].',
            ),
        ),
      );

      final themeIdent = '${themeName.toCamelCase()}Theme';
      final themeDataIdent = '${themeName.toCamelCase()}ThemeData';
      final themeValueIdent = '${themeName.toCamelCase()}Value';

      themeMethods.add(
        Method(
          (b) => b
            ..name = 'merge'
            ..static = true
            ..returns = refer('Widget')
            ..optionalParameters.addAll([
              Parameter(
                (b) => b
                  ..name = 'key'
                  ..type = refer('Key?')
                  ..named = true,
              ),
              Parameter(
                (b) => b
                  ..name = 'data'
                  ..type = refer(targetThemeDataClassName)
                  ..named = true
                  ..required = true,
              ),
              Parameter(
                (b) => b
                  ..name = 'child'
                  ..type = refer('Widget')
                  ..required = true
                  ..named = true,
              ),
            ])
            ..body = Code('''
              return Builder(
                key: key,
                builder: (context) => $targetThemeClassName(
                  data: $targetThemeClassName.of(context).merge(data),
                  child: child,
                ),
              );
            ''')
            ..docs.add(
              '/// Merges the nearest [$targetThemeClassName] with a specified [child].',
            ),
        ),
      );

      themeMethods.add(
        Method(
          (b) => b
            ..name = 'copyWith'
            ..static = true
            ..returns = refer('Widget')
            ..optionalParameters.addAll([
              ...[
                Parameter(
                  (b) => b
                    ..name = 'key'
                    ..type = refer('Key?')
                    ..named = true,
                ),
                Parameter(
                  (b) => b
                    ..name = 'child'
                    ..type = refer('Widget')
                    ..required = true
                    ..named = true,
                ),
              ],
              ...fields.map(
                (e) => Parameter(
                  (b) => b
                    ..type = refer('${e.type}?')
                    ..name = e.name3!
                    ..named = true,
                ),
              ),
            ])
            ..body = Code('''
              return Builder(
                key: key,
                builder: (context) => $targetThemeClassName(
                  data: $targetThemeClassName.of(context).copyWith(
                    ${fields.fold('', (p, e) => '$p${e.name3}: ${e.name3},')}
                  ),
                  child: child,
                ),
              );
            ''')
            ..docs.add(
              '/// Makes a copy of the nearest [$targetThemeClassName] overwriting selected fields.',
            ),
        ),
      );

      themeMethods.add(
        Method(
          (b) => b
            ..name = 'wrap'
            ..returns = refer('Widget')
            ..annotations.add(refer('override'))
            ..requiredParameters.addAll([
              Parameter(
                (b) => b
                  ..name = 'context'
                  ..type = refer('BuildContext'),
              ),
              Parameter(
                (b) => b
                  ..name = 'child'
                  ..type = refer('Widget'),
              ),
            ])
            ..body = Code('''
              final $targetThemeClassName? $themeIdent = 
                context.findAncestorWidgetOfExactType<$targetThemeClassName>();
              return identical(this, $themeIdent) ? child : $targetThemeClassName(data: data, child: child);
            ''')
            ..docs.add(
              '/// Returns a copy of [$targetThemeClassName] with the specified [child].',
            ),
        ),
      );

      themeMethods.add(
        Method(
          (b) => b
            ..name = 'of'
            ..static = true
            ..returns = refer(targetThemeDataClassName)
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..name = 'context'
                  ..type = refer('BuildContext'),
              ),
            )
            ..body = Code('''
            final $targetThemeClassName? $themeIdent = 
              context.dependOnInheritedWidgetOfExactType<$targetThemeClassName>();
            $targetThemeDataClassName? $themeDataIdent = $themeIdent?.data;

            if ($themeDataIdent == null || !$themeDataIdent._isConcrete) {
              final ThemeData themeData = Theme.of(context);

              $themeDataIdent ??= themeData.$themeIdent;
              
              final $themeValueIdent = ${classElement.name3}(themeData);

              ${fields.fold('', (p, e) => '$p final ${e.type} ${e.name3} = $themeDataIdent.${e.name3} ?? $themeValueIdent.${e.name3};')}

              return $themeDataIdent.copyWith(${fields.fold('', (p, e) => '$p${e.name3}: ${e.name3},')});
            }

            assert($themeDataIdent._isConcrete);

            return $themeDataIdent;
          ''')
            ..docs.add('/// Returns the nearest [$targetThemeClassName].'),
        ),
      );

      themeMethods.add(
        Method(
          (b) => b
            ..name = 'updateShouldNotify'
            ..returns = refer('bool')
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..name = 'oldWidget'
                  ..type = refer(targetThemeClassName),
              ),
            )
            ..lambda = true
            ..annotations.add(refer('override'))
            ..body = const Code('data != oldWidget.data'),
        ),
      );

      classes.add(
        Class(
          (b) => b
            ..name = targetThemeClassName
            ..extend = refer('InheritedTheme')
            ..annotations.add(refer('immutable'))
            ..constructors.add(
              Constructor(
                (b) => b
                  ..constant = true
                  ..optionalParameters.addAll([
                    Parameter(
                      (b) => b
                        ..name = 'key'
                        ..toSuper = true
                        ..named = true,
                    ),

                    Parameter(
                      (b) => b
                        ..name = 'data'
                        ..toThis = true
                        ..required = true
                        ..named = true,
                    ),
                    Parameter(
                      (b) => b
                        ..name = 'child'
                        ..required = true
                        ..toSuper = true
                        ..named = true,
                    ),
                  ])
                  ..docs.add('/// Creates a [$targetThemeClassName].'),
              ),
            )
            ..fields.addAll(themeFields)
            ..methods.addAll(themeMethods)
            ..docs.add('/// Inherited theme for [$targetThemeDataClassName].'),
        ),
      );
    }

    final themeLibrary = Library((b) => b..body.addAll(classes));

    return themeLibrary.accept(DartEmitter()).toString();
  }
}
