import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/number_formater.dart';
import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:steam/features/profile/presentation/bloc/profile_status.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final drawerBg = theme.scaffoldBackgroundColor;
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      width: screenWidth * 0.75,
      backgroundColor: drawerBg,
      child: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state.profileStatus is ProfileLoading) {
                return Center(
                  child: LoadingAnimationWidget.twoRotatingArc(
                    color: AppColors.orange,
                    size: 32,
                  ),
                );
              }
              if (state.profileStatus is ProfileError) {
                return Center(
                  child: Text(
                    (state.profileStatus as ProfileError).message,
                    style: const TextStyle(color: AppColors.error200),
                  ),
                );
              }
              if (state.profileStatus is ProfileSuccess) {
                final ProfileSuccess profileSuccess =
                    state.profileStatus as ProfileSuccess;
                final UserEntity user = profileSuccess.userEntity;
                return Container(
                  height: 200,
                  padding: EdgeInsets.zero,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      user.picture != null
                          ? CachedNetworkImage(
                              imageUrl: user.picture!,
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 500),
                            )
                          // Image.network(user.picture!, fit: BoxFit.cover)
                          : Image.asset(
                              'assets/images/image2.png',
                              fit: BoxFit.cover,
                            ),

                      Container(color: Colors.white.withValues(alpha: 0.8)),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 50.0,
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: user.picture != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: user.picture!,
                                              width: 72,
                                              height: 72,
                                              fit: BoxFit.cover,
                                              fadeInDuration: const Duration(
                                                milliseconds: 500,
                                              ),
                                              placeholder: (context, url) {
                                                return Center(
                                                  child:
                                                      LoadingAnimationWidget.flickr(
                                                        leftDotColor:
                                                            AppColors.orange,
                                                        rightDotColor:
                                                            AppColors.blue,
                                                        size: 28,
                                                      ),
                                                );
                                              },
                                            ),
                                            // Image.network(
                                            //   user.picture!,
                                            //   width: 72,
                                            //   height: 72,
                                            //   fit: BoxFit.cover,
                                            // ),
                                          )
                                        : Image.asset(
                                            'assets/images/image2.png',
                                            width: 72,
                                            height: 72,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    user.fullName ?? 'بدون نام',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.myGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatNumberToPersianWithoutSeparator(
                                      user.username,
                                    ),
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
                                  color: AppColors.myGrey6,
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
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
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
