import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/widgets/social_icon_list.dart';
import 'package:steam/features/contact_us/widgets/map.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تماس با ما'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Column(
            spacing: 16,
            children: [
              ContactUsCard(
                title: 'شماره تماس',
                subtitle: '۰۹۸۳۶۲۸۴۰۱۸',
                icon: HugeIcons.strokeRoundedHeadset,
              ),
              ContactUsCard(
                title: 'ایمیل',
                subtitle: 'info@steam.com',
                icon: HugeIcons.strokeRoundedMailAtSign01,
              ),
              MapWidget(latitude: '35.6895', longitude: '51.3891'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'آدرس',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: AppColors.myGrey2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تهران، جهارراه وليعصر، خيابان برادران مظفر شمالى ، كوجه بخشنده ، يلاك ۵',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.myBlack,
                    ),
                  ),
                ],
              ),
              const SocialIconList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactUsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const ContactUsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.myGrey3, size: 38),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: AppColors.myGrey2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: AppColors.myGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
