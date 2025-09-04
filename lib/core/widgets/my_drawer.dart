import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final drawerBg = theme.scaffoldBackgroundColor;

    return Drawer(
      width: 280,
      backgroundColor: drawerBg,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/image2.png',
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'شادمهر عقیلی',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.myGrey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '۰۹۸۳۶۲۸۴۰۱۸',
                        style: TextStyle(
                          color: AppColors.myGrey2,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.myGrey3,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      HugeIcons.strokeRoundedShare08,
                      size: 24,
                      color: AppColors.myGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 0.0),
            child: ListTile(
              leading: Icon(
                HugeIcons.strokeRoundedUserCircle,
                color: AppColors.myGrey2,
              ),
              title: Text(
                'حساب کاربری',
                style: TextStyle(
                  color: AppColors.myGrey2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                GoRouter.of(context).push('/profile');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: ListTile(
              leading: Icon(
                HugeIcons.strokeRoundedUserGroup02,
                color: AppColors.myGrey2,
              ),
              title: Text(
                'نمایندگان',
                style: TextStyle(
                  color: AppColors.myGrey2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                context.pop();
                GoRouter.of(context).push('/representative');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: ListTile(
              leading: Icon(
                HugeIcons.strokeRoundedHeadphones,
                color: AppColors.myGrey2,
              ),
              title: Text(
                'ارتباط با ما',
                style: TextStyle(
                  color: AppColors.myGrey2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                GoRouter.of(context).push('/contact-us');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: ListTile(
              leading: Icon(
                HugeIcons.strokeRoundedInformationCircle,
                color: AppColors.myGrey2,
              ),
              title: Text(
                'درباره ما',
                style: TextStyle(
                  color: AppColors.myGrey2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                GoRouter.of(context).push('/about-us');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: ListTile(
              leading: Icon(
                HugeIcons.strokeRoundedHelpCircle,
                color: AppColors.myGrey2,
              ),
              title: Text(
                'راهنمایی کار با اپلیکیشن',
                style: TextStyle(
                  color: AppColors.myGrey2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                context.pop();
                GoRouter.of(context).push('/setting');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: ListTile(
              leading: Icon(
                HugeIcons.strokeRoundedShieldKey,
                color: AppColors.myGrey2,
              ),
              title: Text(
                'امنیت',
                style: TextStyle(
                  color: AppColors.myGrey2,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                context.pop();
                GoRouter.of(context).push('/setting');
              },
            ),
          ),
        ],
      ),
    );
  }
}
