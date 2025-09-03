import 'package:flutter/material.dart';
import 'package:steam/core/constants/colors.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? info;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: info != null ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.myGrey7,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.myGrey6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Icon(icon, size: 24, color: AppColors.myGrey),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.myGrey,
                  ),
                ),
              ],
            ),
            if (info != null)
              Text(
                info!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.myGrey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
