import 'package:azuralabs_flutter/pages/auth/login.dart';
import 'package:azuralabs_flutter/pages/home.dart';
import 'package:azuralabs_flutter/pages/landing.dart';
import 'package:azuralabs_flutter/pages/products/products.dart';
import 'package:azuralabs_flutter/states/home_tab.dart';
import 'package:azuralabs_flutter/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>(
          builder: (context) => FirebaseAuth.instance.onAuthStateChanged,
        ),
        ChangeNotifierProvider<HomeTabState>(
            builder: (context) => HomeTabState()),
      ],
      child: MaterialApp(
        title: 'Dapurfresh',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ThemeColor.scheme,
        ),
        initialRoute: 'landing',
        routes: {
          'landing': (context) => LandingPage(),
          'login': (context) => LoginPage(),
          'home': (context) => Home(),
          'products': (context) => ProductsPage(),
        },
      ),
    );
  }
}
