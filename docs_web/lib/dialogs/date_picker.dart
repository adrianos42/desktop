import 'package:desktop/desktop.dart';
import '../defaults.dart';
import 'package:flutter/foundation.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    const basicExample = 'return TextFormField();';

    return Defaults(
      header: 'Date Picker',
      items: [
        ItemTitle(
          body: (context) => Container(
            margin: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    DesktopLocalizations.of(context)
                        .formatFullDate(_selectedDate),
                  ),
                ),
                Button.text(
                  'Open date picker',
                  onPressed: () async {
                    final date = await DatePickerDialog.showDatePicker(
                      context,
                      firstDate: DateTime(
                        DateTime.now().year - 4,
                        DateTime.december,
                      ),
                      initialDate: _selectedDate,
                      lastDate: DateTime(
                        DateTime.now().year + 4,
                        DateTime.december,
                      ),
                    );

                    setState(() {
                      if (date != null) {
                        _selectedDate = date;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          codeText: basicExample,
          title: 'Basic example',
        ),
        if (!kReleaseMode)
          ItemTitle(
            body: (context) => Center(
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints.tightFor(
                  width: 40 * (DateTime.daysPerWeek + 1) + 24.0,
                ),
                child: CalendarDate(
                  firstDate: DateTime(1970, DateTime.january, DateTime.friday),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2024, DateTime.december, DateTime.friday),
                  onDateChanged: (value) {},
                  onDateSelected: (value) {},
                ),
              ),
            ),
            codeText: basicExample,
            title: 'Basic example',
          ),
      ],
    );
  }
}
