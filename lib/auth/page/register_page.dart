import 'package:flutter/material.dart';
import 'package:pc_shop/auth/auth_service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
          begin: const Offset(0, 0.2), // чуть ниже
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void showError(String message) {
    if (!mounted) return;

    setState(() {
      _errorText = message;
    });

    _animationController.forward(from: 0);

    Future.delayed(const Duration(seconds: 15), () async {
      if (!mounted) return;
      await _animationController.reverse();
      if (!mounted) return;
      setState(() {
        _errorText = null;
      });
    });
  }

  void signup() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      showError("Пароли не совпадают");
      return;
    }

    try {
      await authService.signUpWithEmailPassword(email, password);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      showError('Ошибка: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.06;
    final verticalSpacing = size.height * 0.025;

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        20,
        0,
        60,
      ), // темно-фиолетовый фон
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 0, 80),
        iconTheme: const IconThemeData(color: Colors.white70),
        elevation: 0,
        title: const Text(
          'Регистрация',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 20,
            ),
            children: [
              SizedBox(height: verticalSpacing),
              _buildTextField(
                controller: _emailController,
                label: "Электронная почта",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: verticalSpacing),
              _buildTextField(
                controller: _passwordController,
                label: "Пароль",
                icon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: verticalSpacing),
              _buildTextField(
                controller: _confirmPasswordController,
                label: "Повторите пароль",
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              SizedBox(height: verticalSpacing * 1.5),
              AnimatedScale(
                scale: _isPressed ? 0.95 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _isPressed = true);
                      Future.delayed(const Duration(milliseconds: 100), () {
                        setState(() => _isPressed = false);
                        signup();
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
                      'Зарегистрироваться',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_errorText != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                minimum: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: size.width * 0.9),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          'Ошибка. Попробуйте еще раз.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54),
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
    );
  }
}
