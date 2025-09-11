import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/inputs/drop_down.dart';
import 'package:steam/core/widgets/social_icon_list.dart';

const List<String> items = ['تهران', 'قم', 'کرمانشاه', 'کرمان'];

class AgenciesScreen extends StatelessWidget {
  const AgenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نمایندگان'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/image2.png', fit: BoxFit.cover),

                  Container(color: AppColors.white.withValues(alpha: 0.5)),
                ],
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(0, -230, 0),
              child: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: CustomDropdown(
                            label: 'استان',
                            icon: HugeIcons.strokeRoundedMapsCircle01,
                            items: items,
                            onChanged: (value) {},
                          ),
                        ),
                        Expanded(
                          child: CustomDropdown(
                            label: 'شهر',
                            icon: HugeIcons.strokeRoundedMapsSquare01,
                            items: items,
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/image2.png',
                        height: 185,
                        width: 185,
                        fit: BoxFit.cover,
                      ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Button(
                      onPressed: () {},
                      label: 'مشاهده رزومه',
                      textColor: AppColors.orange,
                      backgroundColor: AppColors.orangeLight,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
