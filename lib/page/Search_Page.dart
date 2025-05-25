import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(36, 18, 0, 78),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(36, 18, 0, 78),
        title: const Text("Поиск", style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text("Страница поиска", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
