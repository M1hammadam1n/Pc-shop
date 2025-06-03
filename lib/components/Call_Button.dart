import 'package:flutter/material.dart';
import 'package:pc_shop/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  final String phoneNumber;

  const CallButton({super.key, required this.phoneNumber});

  Future<void> _makePhoneCall(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Не удалось открыть телефонное приложение"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Максимальная ширина кнопки — 80% от доступной ширины
        final buttonWidth = constraints.maxWidth * 0.8;

        // Размер шрифта адаптивный: от 14 до 18 в зависимости от ширины
        final fontSize = (constraints.maxWidth / 30).clamp(14.0, 18.0);

        return Center(
          child: SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: () => _makePhoneCall(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.black,
                foregroundColor: AppTheme.white,
                elevation: 6,
                shadowColor: AppTheme.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppTheme.purpleAccent),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (states) {
                    if (states.contains(MaterialState.pressed) ||
                        states.contains(MaterialState.hovered)) {
                      return AppTheme.purple.withOpacity(0.3);
                    }
                    return null;
                  },
                ),
              ),
              child: Text('Позвонить $phoneNumber'),
            ),
          ),
        );
      },
    );
  }
}
