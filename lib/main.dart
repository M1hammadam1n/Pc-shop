import 'package:flutter/material.dart';
import 'package:pc_shop/auth/service/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

void main() async {
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const MyApp());
}

 

 //MMM
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
