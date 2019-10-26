import 'package:azuralabs_flutter/states/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './orders/orders.dart';
import './products/products.dart';
import 'profile/profile.dart';
import '../theme.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final homeTabState = Provider.of<HomeTabState>(context);
    return Scaffold(
      body: IndexedStack(
        index: homeTabState.selectedIndex,
        children: [
          ProductsPage(),
          OrdersPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Belanja'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Riwayat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            title: Text('Profil'),
          ),
        ],
        currentIndex: homeTabState.selectedIndex,
        selectedItemColor: ThemeColor.primary,
        onTap: (index) {
          homeTabState.update(index);
        },
      ),
    );
  }
}
