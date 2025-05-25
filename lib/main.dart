import 'package:flutter/material.dart';
import 'package:pc_shop/auth/service/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVrd2tuZGR2bWJkenNrd3l0cmRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5MDk1NjgsImV4cCI6MjA2MzQ4NTU2OH0.tbiWbRLJOLyVICxQs6zg5WN7IfapV81dkZu1WSI1Z0I",
    url: "https://ekwknddvmbdzskwytrdm.supabase.co",
  );

  runApp(MyApp());
}

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

