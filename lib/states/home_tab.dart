import 'package:flutter/material.dart';

class HomeTabState extends ChangeNotifier {
  int selectedIndex = 0;

  void update(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
