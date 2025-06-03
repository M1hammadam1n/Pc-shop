import 'package:flutter/material.dart';
import 'package:pc_shop/components/Call_Button.dart';
import 'package:pc_shop/components/Pulsing_Hover_Text.dart';
import 'package:pc_shop/theme/app_theme.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: PulsingHoverText(
            'О нас:\nMIR_PC_UZ — всё для вашего ПК: сборки, комплектующие, аксессуары и обустройство офисов и клубов. Качество и забота о каждом клиенте — наш приоритет.',
            fontSize: 16,
          ),
        ),
        const Divider(thickness: 1, height: 32),
        const Text(
          'Контакты:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.white70,
          ),
        ),
        const SizedBox(height: 8),
        CallButton(phoneNumber: '+998903377273'),
        const SizedBox(height: 15),
        CallButton(phoneNumber: '+998953347273'),
        const SizedBox(height: 12),
      ],
    );
  }
}
