import 'package:flutter/material.dart';
import 'package:steam/core/constants/colors.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double elevation;
  final Color? backgroundColor;
  final Color? textColor;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = 8.0,
    this.elevation = 0,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isButtonEnabled = enabled && !isLoading;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isButtonEnabled
              ? backgroundColor ?? AppColors.orange
              : AppColors.myGrey3,
          foregroundColor: textColor ?? AppColors.white,
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
          textStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'IRANYekanX',
            fontWeight: FontWeight.w400,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(label),
      ),
    );
  }
}
