import 'package:flutter/material.dart';
import 'package:pc_shop/auth/page/register_page.dart';
import 'package:pc_shop/auth/auth_service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPressed = false;

  String? _errorText;

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _offsetAnimation =
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showError(String message) {
    if (!mounted) return;

    setState(() {
      _errorText = message;
    });

    // Анимация появления
    _animationController.forward(from: 0).then((_) async {
      // Держим сообщение 15 секунд
      await Future.delayed(const Duration(seconds: 15));
      // Анимация исчезновения
      if (!mounted) return;
      await _animationController.reverse();
      if (!mounted) return;
      setState(() {
        _errorText = null;
      });
    });
  }

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      showError('Ошибка: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.06;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 0, 60),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 0, 80),
        iconTheme: const IconThemeData(color: Colors.white70),
        elevation: 0,
        title: const Text(
          'Вход',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: size.height * 0.03,
              ),
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
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 130, 80, 255),
                        width: 2,
                      ),
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
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 130, 80, 255),
                        width: 2,
                      ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Анимированное сообщение ошибки внизу
            if (_errorText != null)
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Ошибка. Попробуйте еще раз.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
