import 'package:azuralabs_flutter/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    this.formKey,
    this.errorMessage,
    this.onPhoneChange,
    this.onLoginPress,
    this.onFacebookPress,
    this.onGooglePress,
  });
  final onPhoneChange;
  final onLoginPress;
  final onFacebookPress;
  final onGooglePress;
  final errorMessage;
  final GlobalKey<FormState> formKey;

  final double buttonWidth = 250;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Text('Masuk', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Nomor Telepon',
                contentPadding: EdgeInsets.zero,
                prefixText: '+62'
              ),
              onChanged: (String value) => this.onPhoneChange(value),
              validator: (String value) {
                if (value.length == 0) {
                  return 'Nomor telepon wajib diisi';
                }
                return null;
              },
            ),
            if (errorMessage.length > 0)
              Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.topLeft,
                child: Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 11)),
              ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: buttonWidth,
              child: PrimaryButton(
                text: 'Masuk',
                onPress: () {
                  if (formKey.currentState.validate()) {
                    this.onLoginPress();
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
