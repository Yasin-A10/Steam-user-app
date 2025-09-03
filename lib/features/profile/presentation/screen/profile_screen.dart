import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/info_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حساب کاربری'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Image.asset(
                              'assets/images/image1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            color: AppColors.white.withValues(alpha: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 185,
                        width: 185,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/image1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 12,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(HugeIcons.strokeRoundedEdit03, size: 24),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: AppColors.myGrey2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.myGrey6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              'نام کاربری',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppColors.myGrey2,
                              ),
                            ),
                            const InfoCard(
                              icon: HugeIcons.strokeRoundedGlobe,
                              title: 'محل سکونت',
                              info: 'تهران',
                            ),
                            const InfoCard(
                              icon: HugeIcons.strokeRoundedCalendar03,
                              title: 'تاریخ تولد',
                              info: '۱۳۹۹/۰۴/۰۱',
                            ),
                            const InfoCard(
                              icon: HugeIcons.strokeRoundedManWoman,
                              title: 'جنسیت',
                              info: 'مرد',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.myGrey6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'راه های ارتباطی',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.myGrey2,
                      ),
                    ),
                    const InfoCard(
                      icon: HugeIcons.strokeRoundedCall02,
                      title: '۰۹۸۳۶۲۸۴۰۱۸',
                    ),
                    const InfoCard(
                      icon: HugeIcons.strokeRoundedMailAtSign01,
                      title: 'info@steam.com',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: AppColors.myGrey7,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.myGrey6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'رزومه',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.myGrey,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 0,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            HugeIcons.strokeRoundedFileUpload,
                            color: AppColors.myGrey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            HugeIcons.strokeRoundedView,
                            color: AppColors.myGrey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            HugeIcons.strokeRoundedDelete02,
                            color: AppColors.error200,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Button(
                width: double.infinity,
                backgroundColor: AppColors.error200.withValues(alpha: 0.1),
                textColor: AppColors.error200,
                label: 'خروج از حساب کاربری',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
