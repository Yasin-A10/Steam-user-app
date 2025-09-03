import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';

class SocialIconList extends StatefulWidget {
  const SocialIconList({super.key});

  @override
  State<SocialIconList> createState() => _SocialIconListState();
}

class _SocialIconListState extends State<SocialIconList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.orange.withValues(alpha: 0.1),
          ),
          child: SvgPicture.asset('assets/icons/instagram.svg'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.orange.withValues(alpha: 0.1),
          ),
          child: SvgPicture.asset('assets/icons/telegram.svg'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.orange.withValues(alpha: 0.1),
          ),
          child: SvgPicture.asset('assets/icons/aparat.svg'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.orange.withValues(alpha: 0.1),
          ),
          child: SvgPicture.asset('assets/icons/linkedin.svg'),
        ),
      ],
    );
  }
}
