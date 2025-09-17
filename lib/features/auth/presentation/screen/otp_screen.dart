import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:steam/core/constants/colors.dart';
// import 'package:steam/core/widgets/button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:steam/core/utils/number_formater.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:steam/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:steam/features/auth/presentation/widgets/custom_otp.dart';
import 'package:steam/features/auth/presentation/widgets/resend_code_widget.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: -140,
                right: -140,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -140,
                left: -140,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blue,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -160,
                right: -160,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -160,
                left: -160,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blue,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/steam.svg',
                        height: 230,
                        width: 230,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 120),
                      const Text(
                        'تایید شماره موبایل',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.myBlack,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'کد ۵ رقمی به شماره ${formatNumberToPersianWithoutSeparator(widget.phone)} ارسال شد',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: AppColors.myGrey3,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          context.go('/login');
                        },
                        child: const Text(
                          'ویرایش شماره',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.orange,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                          key: otpFormKey,
                          child: Column(
                            children: [
                              BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginStateSuccess) {
                                    if (state.loginResponse.isCreated ==
                                        false) {
                                      context.go('/');
                                    } else {
                                      context.go('/get-name');
                                    }
                                  }
                                  if (state is LoginStateError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.error200,
                                        content: Text('کد وارد شده صحیح نیست'),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      CustomOtpField(
                                        controller: otpController,
                                        onCompleted: (value) {
                                          if (state is LoginStateLoading) {
                                            return;
                                          }
                                          BlocProvider.of<LoginBloc>(
                                            context,
                                          ).add(
                                            LoginEventRequest(
                                              username: widget.phone,
                                              otp: value,
                                            ),
                                          );
                                        },
                                      ),
                                      if (state is LoginStateLoading)
                                        Padding(
                                          padding: EdgeInsets.only(top: 16),
                                          child:
                                              LoadingAnimationWidget.twoRotatingArc(
                                                color: AppColors.orange,
                                                size: 32,
                                              ),
                                        ),

                                      // BlocConsumer<OtpBloc, OtpState>(
                                      //   listener: (context, state) {
                                      //     if (state is OtpStateError) {
                                      //       ScaffoldMessenger.of(
                                      //         context,
                                      //       ).showSnackBar(
                                      //         SnackBar(
                                      //           backgroundColor:
                                      //               AppColors.error200,
                                      //           content: Text(
                                      //             'خطا در ارسال کد',
                                      //           ),
                                      //         ),
                                      //       );
                                      //     }
                                      //   },
                                      //   builder: (context, state) {
                                      //     return Padding(
                                      //       padding: const EdgeInsets.symmetric(
                                      //         horizontal: 24,
                                      //       ),
                                      //       child: ResendCodeButton(
                                      //         duration: 5,
                                      //         onResend: () {
                                      //           BlocProvider.of<OtpBloc>(
                                      //             context,
                                      //           ).add(
                                      //             OtpEventRequestOtp(
                                      //               username: widget.phone,
                                      //             ),
                                      //           );
                                      //         },
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        child: ResendCodeButton(
                                          duration: 5,
                                          onResend: () {
                                            BlocProvider.of<OtpBloc>(
                                              context,
                                            ).add(
                                              OtpEventRequestOtp(
                                                username: widget.phone,
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                      Button(
                                        width: double.infinity,
                                        label: 'ورود',
                                        textColor: AppColors.white,
                                        backgroundColor: AppColors.orange,
                                        onPressed: state is LoginStateLoading
                                            ? null
                                            : () {
                                                if (!otpFormKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                BlocProvider.of<LoginBloc>(
                                                  context,
                                                ).add(
                                                  LoginEventRequest(
                                                    username: widget.phone,
                                                    otp: otpController.text,
                                                  ),
                                                );
                                              },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          _openTerms(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: const Text(
                            'ثبت نام در اپلیکیشن استیم به معنای پذیرش تمام قوانین و مقررات و مرام نامه حرمی خصوصی استیم است',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: AppColors.myGrey3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _openTerms(BuildContext context) {
  showDialog(
    barrierColor: AppColors.blueLight.withValues(alpha: 0.2),
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'قوانین و مقررات',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.myGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(HugeIcons.strokeRoundedCancel01, size: 30),
                    ),
                  ],
                ),
              ),
              Divider(color: AppColors.myGrey5, thickness: 1),
              SizedBox(height: 16),

              // --- Body ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text('توضیحات قوانین و مقررات ${index + 1}'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
