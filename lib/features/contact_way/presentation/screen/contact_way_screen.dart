import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/number_formater.dart';
import 'package:steam/core/utils/validators.dart';
import 'package:steam/core/widgets/inputs/input_form_feild.dart';
import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:steam/features/profile/presentation/bloc/profile_status.dart';

GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();

class ContactWayScreen extends StatefulWidget {
  const ContactWayScreen({super.key});

  @override
  State<ContactWayScreen> createState() => _ContactWayScreenState();
}

class _ContactWayScreenState extends State<ContactWayScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController eitaaController = TextEditingController();
  final TextEditingController baleController = TextEditingController();
  final TextEditingController rubikaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //! Provide Blocs
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
  }

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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.profileStatus is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
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

            if (phoneNumberController.text.isEmpty) {
              phoneNumberController.text =
                  formatNumberToPersianWithoutSeparator(user.username);
              emailController.text = user.email ?? '';
              telegramController.text = user.telegramId ?? '';
              instagramController.text = user.instagram ?? '';
              linkedinController.text = user.linkedIn ?? '';
              eitaaController.text = user.eitaaId ?? '';
              rubikaController.text = user.rubika ?? '';
              baleController.text = user.bale ?? '';
            }
            return GestureDetector(
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
                            controller: phoneNumberController,
                            validator: (value) => AppValidator.phoneNumber(
                              value,
                              fieldName: 'شماره تماس',
                            ),
                          ),
                          CustomInputField(
                            label: 'ایمیل',
                            icon: HugeIcons.strokeRoundedMailAtSign02,
                            controller: emailController,
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
                            controller: telegramController,
                            validator: (value) => AppValidator.userName(
                              value,
                              fieldName: 'Telegram',
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'Instagram',
                            icon: HugeIcons.strokeRoundedInstagram,
                            controller: instagramController,
                            validator: (value) => AppValidator.userName(
                              value,
                              fieldName: 'Instagram',
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'LinkedIn',
                            icon: HugeIcons.strokeRoundedLinkedin01,
                            controller: linkedinController,
                            validator: (value) => AppValidator.userName(
                              value,
                              fieldName: 'LinkedIn',
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'Rubika',
                            icon: HugeIcons.strokeRoundedRubiksCube,
                            controller: rubikaController,
                            validator: (value) =>
                                AppValidator.email(value, fieldName: 'Rubika'),
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'Bale',
                            icon: HugeIcons.strokeRoundedCheckmarkSquare01,
                            controller: baleController,
                            validator: (value) =>
                                AppValidator.email(value, fieldName: '‌Bale'),
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'Eitaa',
                            icon: HugeIcons.strokeRoundedFlower,
                            controller: eitaaController,
                            validator: (value) =>
                                AppValidator.email(value, fieldName: 'Eitaa'),
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                    ),
                  ),
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
