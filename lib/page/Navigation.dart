import 'package:flutter/material.dart';
import 'package:pc_shop/page/Home_Page.dart';
import 'package:pc_shop/page/Search_Page.dart';
import 'package:pc_shop/page/profile_page.dart';
import 'package:pc_shop/page/favorite_page.dart'; 
import 'package:pc_shop/theme/app_theme.dart';

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
    const FavoritePage(),  // <-- добавляем сюда
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.065;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.black,
        selectedItemColor: AppTheme.purpleAccent,
        unselectedItemColor: AppTheme.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: iconSize),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: iconSize),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: iconSize),  
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: iconSize),
            label: 'Профиль',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}
