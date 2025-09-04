import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/social_icon_list.dart';

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
                    InkWell(
                      onTap: () {
                        _handleCardModal(context);
                      },
                      child: Image.asset(
                        'assets/images/image2.png',
                        width: 54,
                        height: 54,
                        fit: BoxFit.cover,
                      ),
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
                        border: Border.all(color: AppColors.myGrey5),
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
          const Divider(color: AppColors.myGrey5, thickness: 1),
        ],
      ),
    );
  }
}

void _handleCardModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  transform: GradientRotation(0.4),
                  colors: [
                    Color(0xFFF9A825).withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.1),
                    Color(0xFF00ACC1).withValues(alpha: 0.4),
                  ],
                  stops: [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  spacing: 16,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/image2.png',
                      height: 185,
                      width: 185,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'شادمهر عقیلی',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.myGrey,
                          ),
                        ),
                        Text(
                          'طراحی و توسعه',
                          style: TextStyle(
                            color: AppColors.myGrey2,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Text(
                              '۰۹۱۲۳۴۵۶۷۸',
                              style: TextStyle(
                                color: AppColors.myGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              HugeIcons.strokeRoundedCall02,
                              color: AppColors.myGrey2,
                              size: 24,
                            ),
                          ],
                        ),
                        Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Omid.test@gmaIl.com',
                              style: TextStyle(
                                color: AppColors.myGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              HugeIcons.strokeRoundedMail01,
                              color: AppColors.myGrey2,
                              size: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SocialIconList(),
                    Button(
                      onPressed: () {},
                      label: 'مشاهده رزومه',
                      textColor: AppColors.orange,
                      backgroundColor: AppColors.orangeLight,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
