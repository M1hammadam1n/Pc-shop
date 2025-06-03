/*
AUTH GATE
Это будет постоянно слушать изменения состояния аутентификации.

--------------------------------------------------------------

unauthenticated -> Login Page  
authenticated   -> MainNavigationPage (включающая Profile и другие страницы)
*/

import 'package:flutter/material.dart';
import 'package:pc_shop/auth/page/login_page.dart';
import 'package:pc_shop/page/Navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final session = snapshot.data?.session;

        if (session != null) {
          return const Navigation(); 
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
