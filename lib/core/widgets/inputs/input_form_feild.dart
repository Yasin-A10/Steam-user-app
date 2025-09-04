import 'package:flutter/material.dart';
import 'package:steam/core/constants/colors.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const CustomInputField({
    super.key,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.borderColor = AppColors.myGrey6,
    this.iconColor = AppColors.myGrey,
    this.textColor = AppColors.myGrey,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: textColor),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.myGrey2),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(icon, color: iconColor),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error200),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error200, width: 2),
        ),

        errorStyle: const TextStyle(color: AppColors.error200, fontSize: 12),
        filled: true,
        fillColor: AppColors.myGrey7,
      ),
    );
  }
}
