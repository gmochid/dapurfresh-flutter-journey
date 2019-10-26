import 'package:azuralabs_flutter/pages/auth/auth_box.dart';
import 'package:azuralabs_flutter/pages/auth/verify_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import './login_form.dart';
import './auth_container.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _phone = '';
  String _errorMessage = '';
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  void phoneLogin() {
    final phoneNumber = '+62$_phone';
    setState(() {
      _loading = true;
    });

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) async {
      try {
        await _authService.login(credential);
        setState(() {
          _loading = false;
        });
        Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
      } catch (error) {
        setState(() {
          _loading = false;
          _errorMessage = error.message;
        });
      }
    };
    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      setState(() {
        _loading = false;
        _errorMessage = authException.message;
      });
    };
    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) {
      setState(() {
        _loading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyPhonePage(phone: phoneNumber, verificationId: verificationId),
        )
      );
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {};

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    );
  }

  void showError(error) {
    this.setState(() {
      _loading = false;
    });
    if (error is PlatformException) {
      this._errorMessage = error.message;
    } else {
      this._errorMessage = error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: AuthContainer(children: <Widget>[
          AuthBox(
            child: LoginForm(
              onPhoneChange: (phone) {
                setState(() {
                  this._phone = phone;
                });
              },
              onLoginPress: this.phoneLogin,
              errorMessage: _errorMessage,
              formKey: _formKey,
            ),
          ),
        ]),
      ),
    );
  }
}
