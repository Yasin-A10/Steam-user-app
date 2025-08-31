import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';

class MainPageCard extends StatelessWidget {
  const MainPageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/image2.png',
                      width: 54,
                      height: 54,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'شادمهر عقیلی',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.myGrey,
                          ),
                        ),
                        Text(
                          'خواننده معاصر',
                          style: TextStyle(
                            color: AppColors.myGrey2,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.myGrey4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Text(
                            '۲۲۰',
                            style: TextStyle(
                              color: AppColors.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Icon(
                            HugeIcons.strokeRoundedDollar02,
                            color: AppColors.yellow,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'بشنو از گل',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.myGrey,
                ),
              ),
              Text(
                'لورم ایپسوم متنی دلخواه برای چاپ و طراحی گرافیکی و کلا طراحی بصری',
                style: TextStyle(
                  color: AppColors.myGrey2,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.myGrey4, thickness: 1),
        ],
      ),
    );
  }
}
