import 'package:flutter/material.dart';
import 'package:pc_shop/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: screenWidth * 0.8, 
        child: ElevatedButton(
          onPressed: () async {
            final phoneNumber = '+998903377273';
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
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.black,
            foregroundColor: AppTheme.white,
            elevation: 6,
            shadowColor: AppTheme.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppTheme.purpleAccent),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ).copyWith(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(MaterialState.pressed)) {
                  return AppTheme.purple.withOpacity(0.3);
                }
                if (states.contains(MaterialState.hovered)) {
                  return AppTheme.purple.withOpacity(0.3);
                }
                return null;
              },
            ),
          ),
          child: const Text('Позвонить'),
        ),
      ),
    );
  }
}
