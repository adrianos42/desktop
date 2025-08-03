import 'package:desktop/desktop.dart';

import '../home.dart';

class _CustomBackgroundColor extends BackgroundColor {
  const _CustomBackgroundColor();

  @override
  Color get b0 => const Color(0xff101010);

  @override
  Color get b4 => const Color(0xff141414);

  @override
  Color get b8 => const Color(0xff181818);

  @override
  Color get b12 => const Color(0xff202020);

  @override
  Color get b16 => const Color(0xff242424);

  @override
  Color get b20 => const Color(0xff282828);

  @override
  Color get w0 => throw UnimplementedError();

  @override
  Color get w12 => throw UnimplementedError();

  @override
  Color get w16 => throw UnimplementedError();

  @override
  Color get w20 => throw UnimplementedError();

  @override
  Color get w4 => throw UnimplementedError();

  @override
  Color get w8 => throw UnimplementedError();

  @override
  BackgroundColor withBrightness(Brightness brightness) {
    return const _CustomBackgroundColor();
  }
}

class _CustomPrimaryColor extends PrimaryColor {
  const _CustomPrimaryColor() : super(name: 'CustomPrimaryColor');

  @override
  Color get b30 => const Color(0xff3c486b);

  @override
  Color get b40 => const Color(0xff2b3467);

  @override
  Color get b50 => const Color(0xff1c6dd0);

  @override
  Color get b60 => const Color(0xffeb455f);

  @override
  Color get b70 => const Color(0xff59ce8f);
}

class CustomTheme extends StatelessWidget {
  const CustomTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const _CustomBackgroundColor().b0,
      child: Theme(
        data: ThemeData(
          backgroundColor: const _CustomBackgroundColor(),
          primaryColor: const _CustomPrimaryColor(),
        ),
        child: DocHome(
          packageName: 'Desktop Custom Theme',
          packageVersion: '1.0.0',
          allowThemeColorChange: false,
          treeNodes: DocApp.createItems(false),
          allowDragging: true,
        ),
      ),
    );
  }
}
