
import 'package:flutter/material.dart';
import 'package:pc_shop/auth/service/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();
  void logout() async {
    await authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    final currentEmail = authService.getCurrentUserEmail();

    return Scaffold(
      backgroundColor: const Color.fromARGB(36, 18, 0, 78),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(36, 18, 0, 78),
        title: const Text("Профиль", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Text(
          currentEmail.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}