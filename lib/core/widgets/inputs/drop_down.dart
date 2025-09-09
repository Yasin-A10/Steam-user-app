import 'package:flutter/material.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:hugeicons/hugeicons.dart';

// class CustomDropdown extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color iconColor;
//   final Color borderColor;
//   final List<String> items;
//   final String? value;
//   final Function(String?) onChanged;
//   final FormFieldValidator<String>? validator;

//   const CustomDropdown({
//     super.key,
//     required this.label,
//     required this.icon,
//     this.iconColor = AppColors.myGrey,
//     this.borderColor = AppColors.myGrey6,
//     required this.items,
//     required this.onChanged,
//     this.value,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       items: items
//           .map(
//             (item) => DropdownMenuItem(
//               value: item,
//               child: Text(item, style: TextStyle(color: AppColors.myGrey)),
//             ),
//           )
//           .toList(),
//       onChanged: onChanged,
//       validator: validator,
//       icon: const Icon(
//         HugeIcons.strokeRoundedArrowDown01,
//         color: AppColors.myGrey,
//         size: 24,
//       ),

//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: AppColors.myGrey2),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         prefixIcon: Icon(icon, color: iconColor),
//         prefixIconColor: iconColor,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: borderColor.withValues(alpha: 0.3)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: borderColor, width: 2),
//         ),

//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.error200),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: AppColors.error200, width: 2),
//         ),
//         errorStyle: TextStyle(color: AppColors.error200, fontSize: 12),
//         filled: true,
//         fillColor: AppColors.myGrey7,
//       ),
//     );
//   }
// }

class CustomDropdown extends StatelessWidget {
  final String label;
  final Text? hint;
  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final FormFieldValidator<String>? validator;
  final bool isLoading; // 👈 جدید

  const CustomDropdown({
    super.key,
    required this.label,
    this.hint,
    required this.icon,
    this.iconColor = AppColors.myGrey,
    this.borderColor = AppColors.myGrey6,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.isLoading = false, // 👈 پیش‌فرض false
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: hint,
      value: value,
      items: isLoading
          ? [
              const DropdownMenuItem(
                value: null,
                enabled: false,
                child: Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.myGrey,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
            ]
          : items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(color: AppColors.myGrey),
                    ),
                  ),
                )
                .toList(),
      onChanged: isLoading ? null : onChanged,
      validator: validator,
      icon: const Icon(
        HugeIcons.strokeRoundedArrowDown01,
        color: AppColors.myGrey,
        size: 24,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.myGrey2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon, color: iconColor),
        prefixIconColor: iconColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.myGrey6),
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
