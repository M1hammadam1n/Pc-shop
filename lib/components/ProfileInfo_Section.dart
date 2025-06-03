import 'package:flutter/material.dart';
import 'package:pc_shop/components/Pulsing_Hover_Text.dart';
import 'package:pc_shop/theme/app_theme.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: PulsingHoverText(
            'О нас:\nMIR_PC_UZ — всё для вашего ПК: сборки, комплектующие, аксессуары и обустройство офисов и клубов. Качество и забота о каждом клиенте — наш приоритет.',
            fontSize: 16,
          ),
        ),
        Divider(thickness: 1, height: 32),
        Text(
          'Контакты:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.white70,
          ),
        ),
        SizedBox(height: 8),
        PulsingHoverText('Телефон: +998 95 334 72 73', fontSize: 16),
        SizedBox(height: 4),
        PulsingHoverText('Телефон: +998 90 337 72 73', fontSize: 16),
        SizedBox(height: 12),
      ],
    );
  }
}
