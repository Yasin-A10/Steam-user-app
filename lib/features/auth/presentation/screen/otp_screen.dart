import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:steam/features/auth/presentation/widgets/custom_otp.dart';

GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
                        'ثبت نام',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.myBlack,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'لطفاً کد تایید را وارد کنید',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: AppColors.myGrey3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                          key: otpFormKey,
                          child: Column(
                            children: [
                              CustomOtpField(),
                              const SizedBox(height: 16),
                              Button(
                                width: double.infinity,
                                label: 'ورود',
                                textColor: AppColors.white,
                                backgroundColor: AppColors.orange,
                                onPressed: () {
                                  if (!otpFormKey.currentState!.validate())
                                    return;
                                  context.push('/get-name');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
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
