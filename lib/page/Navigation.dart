import 'package:flutter/material.dart';
import 'package:pc_shop/page/Home_Page.dart';
import 'package:pc_shop/page/Search_Page.dart';
import 'package:pc_shop/page/profile_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<Navigation> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, 
        selectedItemColor: Colors.purpleAccent, 
        unselectedItemColor: Colors.white70, 
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}
