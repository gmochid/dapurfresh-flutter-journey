import 'package:azuralabs_flutter/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key key,
    @required this.onPress,
    @required this.text,
  }) : super(key: key);

  final onPress;
  final text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      textColor: ThemeColor.primary,
      color: Colors.white,
      child: Text(text),
      onPressed: onPress,
    );
  }
}
