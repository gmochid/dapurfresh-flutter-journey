import 'package:azuralabs_flutter/pages/auth/auth_box.dart';
import 'package:azuralabs_flutter/pages/auth/auth_container.dart';
import 'package:azuralabs_flutter/services/auth_service.dart';
import 'package:azuralabs_flutter/widgets/primary_button.dart';
import 'package:azuralabs_flutter/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class VerifyPhonePage extends StatefulWidget {
  VerifyPhonePage({@required this.verificationId, @required this.phone});

  final String verificationId;
  final String phone;

  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState(verificationId: verificationId, phone: phone);
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  _VerifyPhonePageState({@required this.verificationId, @required this.phone});

  final String verificationId;
  final String phone;
  String _verificationToken;
  String _errorMessage = '';
  bool _loading = false;
  final _authService = AuthService();

  void submit() async {
    setState(() {
      this._loading = true;
    });
    try {
      _authService.phoneLogin(verificationId, _verificationToken);
      Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
      setState(() {
        this._loading = false;
      });
    } catch (error) {
      setState(() {
        this._loading = false;
        this._errorMessage = error.message;
      });
    }
  }

  void backToLogin() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: AuthContainer(
          children: <Widget>[
            AuthBox(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Verifikasi Nomor Telepon', style: TextStyle(fontSize: 20)),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      'Isi kode verifikasi yang sudah dikirimkan melalui sms ke nomor berikut',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(phone, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Kode Verifikasi',
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) => this._verificationToken = value,
                    ),
                    if (_errorMessage.length > 0)
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        alignment: Alignment.topLeft,
                        child: Text(_errorMessage, style: TextStyle(color: Colors.red, fontSize: 11)),
                      ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      width: 250,
                      child: PrimaryButton(
                        onPress: this.submit,
                        text: 'Verifikasi',
                      ),
                    ),
                    Container(
                      width: 250,
                      child: SecondaryButton(
                        onPress: this.backToLogin,
                        text: 'Kembali',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 24)),
          ],
        ),
      ),
    );
  }
}
