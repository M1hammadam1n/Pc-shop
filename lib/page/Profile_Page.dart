import 'package:flutter/material.dart';
import 'package:pc_shop/auth/auth_service/auth_service.dart';
import 'package:pc_shop/components/ProfileInfo_Section.dart';
import 'package:pc_shop/components/User_Agreement_Page.dart';
import 'package:pc_shop/theme/app_theme.dart';

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

  void openUserAgreement() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UserAgreementPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
          final scaleAnimation = Tween(begin: 0.9, end: 1.0).animate(animation);
          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentEmail =
        authService.getCurrentUserEmail() ?? 'Неизвестный пользователь';

    return Scaffold(
      backgroundColor: AppTheme.black70,
      appBar: AppBar(
        backgroundColor: AppTheme.black70,
        iconTheme: const IconThemeData(color: AppTheme.purpleAccent),
        title: const Text("Профиль", style: TextStyle(color: AppTheme.white)),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout_outlined, color: AppTheme.purpleAccent),
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final contentWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.95;
            final avatarRadius = screenWidth * 0.15 > 60
                ? 60.0
                : screenWidth * 0.15;
            final logoSize = screenWidth * 0.3 > 120
                ? 120.0
                : screenWidth * 0.3;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: const AssetImage(
                          'assets/images/user.png',
                        ),
                        backgroundColor: const Color(
                          0xFF2A2A2A,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        currentEmail,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppTheme.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.purpleAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: openUserAgreement,
                          child: const Text(
                            'Пользовательское соглашение',
                            style: TextStyle(fontSize: 16, color: AppTheme.black),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      ClipOval(
                        child: Image.asset(
                          'assets/images/Logo.jpg',
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ProfileInfoSection(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
