import 'package:flutter/material.dart';
import 'package:pc_shop/auth/page/register_page.dart';
import 'package:pc_shop/auth/auth_service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPressed = false;

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.06;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 0, 60), // насыщенный темно-фиолетовый
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 0, 80),
        iconTheme: const IconThemeData(color: Colors.white70),
        elevation: 0,
        title: const Text(
          'Вход',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
        children: [
          SizedBox(height: size.height * 0.02),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              labelText: "Электронная почта",
              labelStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.email, color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withOpacity(0.12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color.fromARGB(255, 130, 80, 255), width: 2),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.025),
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              labelText: "Пароль",
              labelStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.lock, color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withOpacity(0.12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color.fromARGB(255, 130, 80, 255), width: 2),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          AnimatedScale(
            scale: _isPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: ElevatedButton(
              onPressed: () {
                setState(() => _isPressed = true);
                Future.delayed(const Duration(milliseconds: 100), () {
                  setState(() => _isPressed = false);
                  login();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 130, 80, 255),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 12,
                shadowColor: const Color.fromARGB(150, 130, 80, 255),
              ),
              child: const Text(
                'Войти',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.white24,
              child: const Text.rich(
                TextSpan(
                  text: "Нет аккаунта? ",
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                  children: [
                    TextSpan(
                      text: "Зарегистрироваться",
                      style: TextStyle(
                        color: Color.fromARGB(255, 130, 80, 255),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
