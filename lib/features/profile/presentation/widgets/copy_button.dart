import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steam/core/constants/colors.dart';

class CopyIconButton extends StatelessWidget {
  final String text;
  final IconData icon;

  const CopyIconButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: AppColors.orange, size: 24),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.orangeLight),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
      ),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: text));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('لینک کپی شد: $text'),
            backgroundColor: AppColors.success200,
            duration: const Duration(seconds: 3),
          ),
        );
      },
    );
  }
}
