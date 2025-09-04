import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/validators.dart';
import 'package:steam/core/widgets/inputs/drop_down.dart';
import 'package:steam/core/widgets/inputs/input_form_feild.dart';

List<String> items = ['تهران', 'کرمانشاه', 'کرمان', 'یزد'];

GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اطلاعات شخصی'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedTick02, size: 28),
            onPressed: () {
              if (!personalFormKey.currentState!.validate()) return;
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
                key: personalFormKey,
                child: Column(
                  children: [
                    ProfileImageCard(),
                    const SizedBox(height: 30),
                    CustomInputField(
                      label: 'نام و نام خانوادگی',
                      icon: HugeIcons.strokeRoundedUser,
                      validator: (value) => AppValidator.userName(
                        value,
                        fieldName: 'نام و نام خانوادگی',
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      label: 'بیوگرافی',
                      icon: HugeIcons.strokeRoundedInformationCircle,
                      validator: (value) =>
                          AppValidator.userName(value, fieldName: 'بیوگرافی'),
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown(
                      label: 'استان محل سکونت',
                      icon: HugeIcons.strokeRoundedMapPin,
                      items: items,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown(
                      label: 'شهر محل سکونت',
                      icon: HugeIcons.strokeRoundedMapPin,
                      items: items,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16),
                    //TODO: add Date of birth
                    CustomDropdown(
                      label: 'جنسیت',
                      icon: HugeIcons.strokeRoundedManWoman,
                      items: ['مرد', 'زن'],
                      onChanged: (value) {},
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

//! Profile Image Card
class ProfileImageCard extends StatelessWidget {
  const ProfileImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/image3.jpg',
                height: 185,
                width: 185,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: -12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: AppColors.myGrey,
                    ),
                    label: const Text(
                      "ویرایش",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.myGrey7,
                      foregroundColor: AppColors.myGrey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      HugeIcons.strokeRoundedDelete02,
                      color: AppColors.error200,
                      size: 24,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        AppColors.error25,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
