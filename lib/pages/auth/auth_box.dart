import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthBox extends StatelessWidget {
  const AuthBox({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.black12),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
