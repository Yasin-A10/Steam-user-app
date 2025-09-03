import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/widgets/social_icon_list.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('درباره ما'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 28),
                Text.rich(
                  TextSpan(
                    text: 'معرفی ',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w200,
                      color: AppColors.myGrey2,
                    ),
                    children: [
                      TextSpan(
                        text: 'استیم',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 44),
                Image.asset('assets/images/about-us.png'),
                const SizedBox(height: 28),
                Text(
                  'استیم (STeam) يك شبکه اجتماعی برای تیم سازی است. اکنون برای شروع کسب و کار و یا توسعه کسب و کار تان دست تنها هستید، شبکه اجتماعی استیم می تواند به شما کمک کند تا هم تیمی پیدا کنید، فقط کافی است اپلیکیشن استیم را نصب کنید، پروفایل خودتان را تکمیل کنید و در رویدادها استیم شرکت کنید. ما تضمین می کنیم که فرد مناسب (Person Right) شما را پیدا کنیم جانانجه کام به کام ما را همراه کنید تا در این مسی ر موفق شوید هم تیم یا همبنیانکذار پیدا شود.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.myGrey3,
                  ),
                ),
                const SizedBox(height: 28),
                const SocialIconList(),
                const SizedBox(height: 20),
                Image.asset('assets/images/about-us.png'),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
