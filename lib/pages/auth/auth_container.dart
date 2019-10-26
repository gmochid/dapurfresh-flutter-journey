import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  AuthContainer({this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 120, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('dapurfresh', style: TextStyle(fontSize: 24, color: Colors.grey)),
                  Padding(padding: EdgeInsets.only(right: 8)),
                  Image(
                    height: 48,
                    image: AssetImage("assets/images/logo.png"),
                  )
                ],
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ],
        ),
      )
    );
  }
}
