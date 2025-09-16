import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/convert_to_jalali.dart';
import 'package:steam/core/utils/number_formater.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/info_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:steam/features/profile/data/model/update_resume_model.dart';
import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:steam/features/profile/presentation/bloc/profile_status.dart';
import 'package:steam/features/profile/presentation/bloc/update_resume_status.dart';
import 'package:steam/features/profile/presentation/widgets/copy_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    //! Provide Blocs
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
  }

  Future<void> _pickAndUploadResume(context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);

        final resumeModel = UpdateResumeModel(resume: file);

        BlocProvider.of<ProfileBloc>(
          context,
        ).add(UpdateResumeEvent(updateResumeModel: resumeModel));

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("در حال آپلود رزومه...")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("خطا در انتخاب فایل: $e")));
    }
  }

  Future<void> _deleteResume(context) async {
    try {
      BlocProvider.of<ProfileBloc>(context).add(
        UpdateResumeEvent(
          updateResumeModel: UpdateResumeModel(resume: null),
          isDelete: true,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("خطا در حذف رزومه: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    //! UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('حساب کاربری'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.profileStatus is ProfileLoading) {
            return Center(
              child: LoadingAnimationWidget.twoRotatingArc(
                color: AppColors.orange,
                size: 32,
              ),
            );
          } else if (state.profileStatus is ProfileError) {
            return Center(
              child: Text(
                (state.profileStatus as ProfileError).message,
                style: const TextStyle(color: AppColors.error200),
              ),
            );
          } else if (state.profileStatus is ProfileSuccess) {
            //!cast profileStatus to ProfileSuccess
            final ProfileSuccess profileSuccess =
                state.profileStatus as ProfileSuccess;
            final UserEntity user = profileSuccess.userEntity;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
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
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 4,
                                    sigmaY: 4,
                                  ),
                                  child: user.picture != null
                                      ? CachedNetworkImage(
                                          imageUrl: user.picture!,
                                          fit: BoxFit.cover,
                                          fadeInDuration: const Duration(
                                            milliseconds: 500,
                                          ),
                                        )
                                      : Image.asset(
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
                                child: user.picture != null
                                    ? CachedNetworkImage(
                                        imageUrl: user.picture!,
                                        width: 185,
                                        height: 185,
                                        fit: BoxFit.cover,
                                        fadeInDuration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                              width: 185,
                                              height: 185,
                                              alignment: Alignment.center,
                                              child:
                                                  LoadingAnimationWidget.flickr(
                                                    leftDotColor:
                                                        AppColors.orange,
                                                    rightDotColor:
                                                        AppColors.blue,
                                                    size: 28,
                                                  ),
                                            ),
                                      )
                                    : Image.asset(
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
                              onPressed: () {
                                GoRouter.of(context).push('/personal-info');
                              },
                              icon: Icon(
                                HugeIcons.strokeRoundedEdit03,
                                size: 24,
                              ),
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
                                  user.fullName ?? 'نامشخص',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.myGrey,
                                  ),
                                ),
                                Text(
                                  user.biography ?? 'نامشخص',
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
                                  const SizedBox(height: 0),
                                  InfoCard(
                                    icon: HugeIcons.strokeRoundedGlobe,
                                    title: 'محل سکونت',
                                    info: user.city ?? 'نامشخص',
                                  ),
                                  InfoCard(
                                    icon: HugeIcons.strokeRoundedCalendar03,
                                    title: 'تاریخ تولد',
                                    info: formatNumberToPersianWithoutSeparator(
                                      convertToJalaliDate(
                                        user.birthDate ?? 'نامشخص',
                                      ),
                                    ),
                                  ),
                                  InfoCard(
                                    icon: HugeIcons.strokeRoundedManWoman,
                                    title: 'جنسیت',
                                    info: user.gender == '0' ? 'مرد' : 'زن',
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
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.myGrey6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'راه های ارتباطی',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.myGrey2,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  GoRouter.of(context).push('/contact-way');
                                },
                                icon: Icon(
                                  HugeIcons.strokeRoundedEdit03,
                                  color: AppColors.myGrey,
                                ),
                              ),
                            ],
                          ),
                          InfoCard(
                            icon: HugeIcons.strokeRoundedCall02,
                            title: formatNumberToPersianWithoutSeparator(
                              user.username!,
                            ),
                          ),
                          InfoCard(
                            icon: HugeIcons.strokeRoundedMailAtSign01,
                            title: user.email!,
                          ),
                          Row(
                            children: [
                              user.telegramId != null
                                  ? CopyIconButton(
                                      text: user.telegramId!,
                                      icon: HugeIcons.strokeRoundedTelegram,
                                    )
                                  : const SizedBox(),
                              user.instagram != null
                                  ? CopyIconButton(
                                      text: user.instagram!,
                                      icon: HugeIcons.strokeRoundedInstagram,
                                    )
                                  : const SizedBox(),
                              user.linkedIn != null
                                  ? CopyIconButton(
                                      text: user.linkedIn!,
                                      icon: HugeIcons.strokeRoundedLinkedin01,
                                    )
                                  : const SizedBox(),
                              user.bale != null
                                  ? CopyIconButton(
                                      text: user.bale!,
                                      icon: HugeIcons
                                          .strokeRoundedCheckmarkSquare01,
                                    )
                                  : const SizedBox(),
                              user.rubika != null
                                  ? CopyIconButton(
                                      text: user.rubika!,
                                      icon: HugeIcons.strokeRoundedRubiksCube,
                                    )
                                  : const SizedBox(),
                              user.eitaaId != null
                                  ? CopyIconButton(
                                      text: user.eitaaId!,
                                      icon: HugeIcons.strokeRoundedFlower,
                                    )
                                  : const SizedBox(),
                            ],
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
                            children: [
                              BlocConsumer<ProfileBloc, ProfileState>(
                                listener: (context, state) {
                                  if (state.resumeStatus is ResumeSuccess) {
                                    final success =
                                        state.resumeStatus as ResumeSuccess;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          success.isDeleted
                                              ? 'رزومه با موفقیت حذف شد'
                                              : 'رزومه با موفقیت آپلود شد',
                                        ),
                                      ),
                                    );
                                    BlocProvider.of<ProfileBloc>(
                                      context,
                                    ).add(LoadProfileEvent());
                                  } else if (state.resumeStatus
                                      is ResumeError) {
                                    final errorMessage =
                                        (state.resumeStatus as ResumeError)
                                            .message;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '$errorMessage خطا در آپلود یا حذف رزومه',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  final isLoading =
                                      state.profileStatus is ProfileLoading;

                                  return Row(
                                    children: [
                                      IconButton(
                                        onPressed: isLoading
                                            ? null
                                            : () =>
                                                  _pickAndUploadResume(context),
                                        icon: Icon(
                                          HugeIcons.strokeRoundedFileUpload,
                                          color: AppColors.myGrey,
                                        ),
                                      ),

                                      if (user.resume != null)
                                        IconButton(
                                          onPressed: () {
                                            GoRouter.of(context).push(
                                              '/resume-viewer',
                                              extra: user.resume,
                                            );
                                          },
                                          icon: Icon(
                                            HugeIcons.strokeRoundedView,
                                            color: AppColors.myGrey,
                                          ),
                                        ),

                                      IconButton(
                                        onPressed: isLoading
                                            ? null
                                            : () => _deleteResume(context),
                                        icon: Icon(
                                          HugeIcons.strokeRoundedDelete02,
                                          color: AppColors.error200,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Button(
                      width: double.infinity,
                      backgroundColor: AppColors.error25,
                      textColor: AppColors.error200,
                      label: 'خروج از حساب کاربری',
                      onPressed: () {
                        _handleLogoutModal(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

//! Logout Modal
void _handleLogoutModal(BuildContext context) {
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
                  bottom: 20,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'خروج از حساب کاربری',
                      style: TextStyle(
                        color: AppColors.myGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'آیا از خروج از حساب کاربری مطمئن هستید؟',
                          style: TextStyle(
                            color: AppColors.myGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Button(
                                backgroundColor: AppColors.blueLight,
                                textColor: AppColors.blue,
                                label: 'انصراف',
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: BlocConsumer<LogoutBloc, LogoutState>(
                                listener: (context, state) {
                                  if (state is LogoutStateSuccess) {
                                    GoRouter.of(context).go('/login');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'شما با موفقیت از حساب کاربری خارج شدید.',
                                        ),
                                      ),
                                    );
                                  }
                                  if (state is LogoutStateError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return Button(
                                    backgroundColor: AppColors.error25,
                                    textColor: AppColors.error200,
                                    label: 'خروج',
                                    onPressed: state is LogoutStateLoading
                                        ? null
                                        : () {
                                            BlocProvider.of<LogoutBloc>(
                                              context,
                                            ).add(LogoutEventRequest());
                                          },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
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
