import 'package:desktop/desktop.dart';
import '../defaults.dart';

class TextFormFieldPage extends StatefulWidget {
  const TextFormFieldPage({super.key});

  @override
  State<TextFormFieldPage> createState() => _TextFormFieldPageState();
}

class _TextFormFieldPageState extends State<TextFormFieldPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String _email = '';
  String _password = '';

  void _validate() {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.body1.copyWith(
      color: textTheme.textPrimaryHigh,
    );

    if (_formKey.currentState!.validate()) {
      Dialog.showDialog(
        context,
        title: const Text('Login'),
        actions: [
          Button.text(
            'Ok',
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        body: Text.rich(
          TextSpan(
            text: '',
            children: [
              TextSpan(text: '\nEmail: ', children: [
                TextSpan(
                  text: _email,
                  style: textStyle,
                )
              ]),
              TextSpan(text: '\nPassword: ', children: [
                TextSpan(
                  text: _password,
                  style: textStyle,
                )
              ]),
            ],
          ),
        ),
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const basicExample = 'return TextFormField();';

    return Defaults(
      header: 'Text Form Field',
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
                    TextFormField(
                      prefix: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => _email = value,
                      onFieldSubmitted: (_) =>
                          _passwordFocusNode.requestFocus(),
                      focusNode: _emailFocusNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter an email!';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        prefix: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        focusNode: _passwordFocusNode,
                        onChanged: (value) => _password = value,
                        onFieldSubmitted: (_) => _validate(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the password!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Button.filled('Login',
                            onPressed: () => _validate()),
                      ),
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
