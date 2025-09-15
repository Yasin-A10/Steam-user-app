import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/validators.dart';
import 'package:steam/core/widgets/inputs/input_form_feild.dart';
import 'package:steam/features/contact_way/data/model/contact_model.dart';
import 'package:steam/features/contact_way/presentation/bloc/contact_bloc.dart';
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
          onPressed: () {
            context.pop();
            BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
          },
        ),
        actions: [
          BlocConsumer<ContactBloc, ContactState>(
            listener: (context, state) {
              if (state is ContactSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('اطلاعات با موفقیت آپدیت شد!'),
                    backgroundColor: AppColors.success200,
                  ),
                );
              } else if (state is ContactError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('خطا: ${state.message}'),
                    backgroundColor: AppColors.error200,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is ContactLoading;

              return IconButton(
                icon: isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: AppColors.orange,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(HugeIcons.strokeRoundedTick02, size: 28),
                onPressed: isLoading
                    ? null
                    : () {
                        if (!contactFormKey.currentState!.validate()) return;

                        final updatedUser = ContactModel(
                          username: phoneNumberController.text.trim(),
                          email: emailController.text.trim().isNotEmpty
                              ? emailController.text.trim()
                              : null,
                          eitaaId: eitaaController.text.trim().isNotEmpty
                              ? eitaaController.text.trim()
                              : null,
                          telegramId: telegramController.text.trim().isNotEmpty
                              ? telegramController.text.trim()
                              : null,
                          bale: baleController.text.trim().isNotEmpty
                              ? baleController.text.trim()
                              : null,
                          rubika: rubikaController.text.trim().isNotEmpty
                              ? rubikaController.text.trim()
                              : null,
                          linkedIn: linkedinController.text.trim().isNotEmpty
                              ? linkedinController.text.trim()
                              : null,
                          instagram: instagramController.text.trim().isNotEmpty
                              ? instagramController.text.trim()
                              : null,
                        );

                        BlocProvider.of<ContactBloc>(
                          context,
                        ).add(UpdateContactEvent(userInfo: updatedUser));
                      },
              );
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
              phoneNumberController.text = user.username!;
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
                            keyboardType: TextInputType.phone,
                            validator: (value) => AppValidator.phoneNumber(
                              value,
                              fieldName: 'شماره تماس',
                            ),
                          ),
                          CustomInputField(
                            label: 'ایمیل',
                            icon: HugeIcons.strokeRoundedMailAtSign02,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
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
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'Instagram',
                            icon: HugeIcons.strokeRoundedInstagram,
                            controller: instagramController,
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'LinkedIn',
                            icon: HugeIcons.strokeRoundedLinkedin01,
                            controller: linkedinController,
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'Rubika',
                            icon: HugeIcons.strokeRoundedRubiksCube,
                            controller: rubikaController,
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'Bale',
                            icon: HugeIcons.strokeRoundedCheckmarkSquare01,
                            controller: baleController,
                            textDirection: TextDirection.ltr,
                          ),
                          CustomInputField(
                            label: 'Eitaa',
                            icon: HugeIcons.strokeRoundedFlower,
                            controller: eitaaController,
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
