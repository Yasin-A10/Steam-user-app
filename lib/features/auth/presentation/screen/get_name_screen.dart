import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/validators.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/inputs/input_form_feild.dart';

GlobalKey<FormState> getNameFormKey = GlobalKey<FormState>();

class GetNameScreen extends StatelessWidget {
  const GetNameScreen({super.key});

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
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/steam.svg',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 120),
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.myGrey5,
                            width: 1,
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          HugeIcons.strokeRoundedUser02,
                          color: AppColors.myGrey,
                          size: 80,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.translationValues(0, -24, 0),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            HugeIcons.strokeRoundedPen01,
                            color: AppColors.myGrey,
                            size: 24,
                          ),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              AppColors.myGrey7,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: AppColors.myGrey4,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.all(8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: Form(
                          key: getNameFormKey,
                          child: Column(
                            children: [
                              CustomInputField(
                                label: 'نام و نام خانوادگی',
                                icon: HugeIcons.strokeRoundedUser,
                                validator: (value) => AppValidator.userName(
                                  value,
                                  fieldName: 'نام و نام خانوادگی',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Button(
                                width: double.infinity,
                                label: 'ورود',
                                textColor: AppColors.white,
                                backgroundColor: AppColors.orange,
                                onPressed: () {
                                  if (!getNameFormKey.currentState!.validate())
                                    return;
                                  context.go('/');
                                },
                              ),
                            ],
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
