import 'package:desktop/desktop.dart';
import '../defaults.dart';

class DatePickerPage extends StatefulWidget {
  DatePickerPage({super.key});

  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  @override
  Widget build(BuildContext context) {
    const basicExample = 'return TextFormField();';

    return Defaults(
      header: 'Date picker',
      items: [
        ItemTitle(
          body: (context) => Center(
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints.tightFor(
                width: 40 * (DateTime.daysPerWeek + 1) + 24.0,
              ),
              child: CalendarDate(
                firstDate: DateTime(2022, DateTime.april, DateTime.friday),
                initialDate: DateTime.now(),
                lastDate: DateTime(2022, DateTime.october, DateTime.friday),
                onDateChanged: (value) {},
              ),
            ),
          ),
          codeText: basicExample,
          title: 'Basic example',
        ),
        ItemTitle(
          body: (context) => Container(
            margin: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: Button.text(
              'Open date picker',
              onPressed: () {
                Dialog.showCustomDialog(context, builder: (context) {
                  return DialogTheme(
                    data: DialogTheme.of(context).copyWidth(
                        bodyPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                    )),
                    child: Dialog(
                      allowScroll: false,
                      body: Align(
                        alignment: Alignment.centerLeft,
                        child: CalendarDate(
                          firstDate:
                              DateTime(2022, DateTime.april, DateTime.friday),
                          initialDate: DateTime.now(),
                          lastDate:
                              DateTime(2022, DateTime.october, DateTime.friday),
                          onDateChanged: (value) {},
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          codeText: basicExample,
          title: 'Basic example',
        ),
      ],
    );
  }
}
