import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/validators.dart';
import 'package:steam/core/widgets/inputs/input_form_feild.dart';

GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();

class ContactWayScreen extends StatelessWidget {
  const ContactWayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('راه های ارتباطی'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedTick02, size: 28),
            onPressed: () {
              if (!contactFormKey.currentState!.validate()) return;
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: contactFormKey,
                child: Column(
                  spacing: 16,
                  children: [
                    CustomInputField(
                      label: 'شماره تماس',
                      icon: HugeIcons.strokeRoundedCall02,
                      validator: (value) => AppValidator.phoneNumber(
                        value,
                        fieldName: 'شماره تماس',
                      ),
                    ),
                    CustomInputField(
                      label: 'ایمیل',
                      icon: HugeIcons.strokeRoundedMailAtSign02,
                      validator: (value) =>
                          AppValidator.email(value, fieldName: 'ایمیل'),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Text(
                          'شبکه های اجتماعی',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: AppColors.myGrey3,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.myGrey6,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    CustomInputField(
                      label: 'Telegram',
                      icon: HugeIcons.strokeRoundedTelegram,
                      validator: (value) =>
                          AppValidator.userName(value, fieldName: 'Telegram'),
                      textDirection: TextDirection.ltr,
                    ),
                    CustomInputField(
                      label: 'Instagram',
                      icon: HugeIcons.strokeRoundedInstagram,
                      validator: (value) =>
                          AppValidator.userName(value, fieldName: 'Instagram'),
                      textDirection: TextDirection.ltr,
                    ),
                    CustomInputField(
                      label: 'LinkedIn',
                      icon: HugeIcons.strokeRoundedLinkedin01,
                      validator: (value) =>
                          AppValidator.userName(value, fieldName: 'LinkedIn'),
                      textDirection: TextDirection.ltr,
                    ),
                    CustomInputField(
                      label: 'Twitter',
                      icon: HugeIcons.strokeRoundedNewTwitter,
                      validator: (value) =>
                          AppValidator.email(value, fieldName: 'Twitter'),
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
