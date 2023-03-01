import 'package:desktop/desktop.dart';
import 'package:flutter/services.dart';
import '../defaults.dart';
import 'package:intl/intl.dart';

class DateFormFieldPage extends StatefulWidget {
  DateFormFieldPage({super.key});

  @override
  _DateFormFieldPageState createState() => _DateFormFieldPageState();
}

class _DateFormFieldPageState extends State<DateFormFieldPage> {
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();
  DateTime _selectedDate = DateTime.now();

  AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;

  void _validate() {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.body1.copyWith(
      color: textTheme.textPrimaryHigh,
    );

    if (_formKey.currentState!.validate()) {
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const basicExample = 'return DateFormField();';

    return Defaults(
      header: 'Date Form Field',
      items: [
        ItemTitle(
          body: (context) => Container(
            margin: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: SizedBox(
              width: 324.0,
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
                  padding: const EdgeInsets.all(40.0),
                  children: [
                    DateFormField(
                      onChanged: (value) => setState(() {
                        try {
                          _selectedDate = DateFormat.yMd().parse(value);
                        } catch (_) {
                          _selectedDate = DateTime.now();
                        }
                      }),
                      onFieldSubmitted: (_) {},
                      focusNode: _focusNode,
                      firstDate: DateTime(
                        DateTime.now().year - 4,
                        DateTime.december,
                      ),
                      initialDate: _selectedDate,
                      lastDate: DateTime(
                        DateTime.now().year + 4,
                        DateTime.december,
                      ),
                      validator: (value) {
                        if (value != null) {
                          try {
                            DateFormat.yMd().parseStrict(value);
                          } catch (_) {
                            return 'Invalid date!';
                          }
                        }

                        return null;
                      },
                    ),
                  ],
                ),
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
