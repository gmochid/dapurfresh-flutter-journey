import 'package:azuralabs_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    _authService.currentUser().then((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    }).catchError((error) => Navigator.pushReplacementNamed(context, 'login'));

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
