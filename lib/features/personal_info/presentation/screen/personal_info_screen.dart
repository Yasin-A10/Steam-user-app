// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/cities/bloc/cities_bloc.dart';
import 'package:steam/core/cities/bloc/cities_status.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/validators.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/inputs/drop_down.dart';
import 'package:steam/core/widgets/inputs/input_form_feild.dart';
import 'package:steam/features/personal_info/data/model/update_personal_info_model.dart';
import 'package:steam/features/personal_info/presentation/bloc/personal_info_bloc.dart';
import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:steam/features/profile/presentation/bloc/profile_status.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  File? _selectedImage;
  String? selectedProvince;
  String? selectedCityName;
  int? selectedCityId;
  String? selectedGender;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  Map<String, int> cityMap = {};

  @override
  void initState() {
    super.initState();

    //! Provide Blocs
    BlocProvider.of<CitiesBloc>(context).add(LoadProvincesEvent());
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    //! UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('اطلاعات شخصی'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () {
            context.pop();
            BlocProvider.of<ProfileBloc>(context).add(LoadProfileEvent());
          },
        ),
        actions: [
          BlocConsumer<PersonalInfoBloc, PersonalInfoState>(
            listener: (context, state) {
              if (state is PersonalInfoSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('اطلاعات با موفقیت آپدیت شد!'),
                    backgroundColor: AppColors.success200,
                  ),
                );
              } else if (state is PersonalInfoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('خطا: ${state.message}'),
                    backgroundColor: AppColors.error200,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is PersonalInfoLoading;

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
                        if (!personalFormKey.currentState!.validate()) return;

                        final updatedUser = UpdatePersonalInfoModel(
                          fullName: userNameController.text.trim(),
                          biography: bioController.text.trim(),
                          gender: selectedGender == 'مرد' ? '0' : '1',
                          selectedCityId: selectedCityId,
                          picture: _selectedImage,
                        );

                        BlocProvider.of<PersonalInfoBloc>(
                          context,
                        ).add(UpdatePersonalInfoEvent(userInfo: updatedUser));
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

            if (userNameController.text.isEmpty) {
              userNameController.text = user.fullName ?? '';
              bioController.text = user.biography ?? '';
              selectedGender = user.gender == '0' ? 'مرد' : 'زن';
              selectedProvince = user.city;
              selectedCityName = user.city;
            }

            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Form(
                      key: personalFormKey,
                      child: Column(
                        children: [
                          ProfileImageCard(
                            image: user.picture,
                            onImagePicked: (image) {
                              setState(() {
                                _selectedImage = image;
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomInputField(
                            label: 'نام و نام خانوادگی',
                            icon: HugeIcons.strokeRoundedUser,
                            controller: userNameController,
                            validator: (value) => AppValidator.userName(
                              value,
                              fieldName: 'نام و نام خانوادگی',
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomInputField(
                            label: 'بیوگرافی',
                            controller: bioController,
                            icon: HugeIcons.strokeRoundedInformationCircle,
                            validator: (value) => AppValidator.userName(
                              value,
                              fieldName: 'بیوگرافی',
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomDropdown(
                            label: 'جنسیت',
                            icon: HugeIcons.strokeRoundedManWoman,
                            items: ['مرد', 'زن'],
                            value: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          //! Province Bloc
                          BlocBuilder<CitiesBloc, CitiesState>(
                            builder: (context, state) {
                              List<String> provincesItems = [];
                              bool isLoadingProvinces = false;

                              if (state.provincesStatus is ProvincesLoading) {
                                isLoadingProvinces = true;
                              } else if (state.provincesStatus
                                  is ProvincesSuccess) {
                                final ProvincesSuccess provincesSuccess =
                                    state.provincesStatus as ProvincesSuccess;
                                provincesItems = provincesSuccess.provinces
                                    .map((e) => e.name)
                                    .toList();
                              } else if (state.provincesStatus
                                  is ProvincesError) {
                                final ProvincesError provincesError =
                                    state.provincesStatus as ProvincesError;
                                provincesItems = provincesError.message.split(
                                  ',',
                                );
                              }

                              return CustomDropdown(
                                label: 'استان محل سکونت',
                                hint:
                                    selectedProvince != null &&
                                        !provincesItems.contains(
                                          selectedProvince,
                                        )
                                    ? Text(selectedProvince!)
                                    : null,
                                icon: HugeIcons.strokeRoundedMapPin,
                                items: provincesItems,
                                value: provincesItems.contains(selectedProvince)
                                    ? selectedProvince
                                    : null,
                                isLoading: isLoadingProvinces,
                                onChanged: (value) {
                                  setState(() {
                                    selectedProvince = value;
                                    selectedCityName = null;
                                  });

                                  //! for get province id
                                  if (state.provincesStatus
                                      is ProvincesSuccess) {
                                    final provincesSuccess =
                                        state.provincesStatus
                                            as ProvincesSuccess;
                                    final selectedProvinceId = provincesSuccess
                                        .provinces
                                        .firstWhere((p) => p.name == value)
                                        .id;

                                    BlocProvider.of<CitiesBloc>(context).add(
                                      LoadProvincesWithCitiesEvent(
                                        provinceId: selectedProvinceId,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          //! City Bloc
                          BlocBuilder<CitiesBloc, CitiesState>(
                            builder: (context, state) {
                              List<String> cityItems = [];
                              bool isCityLoading = false;

                              if (state.provincesWithCitiesStatus
                                  is ProvincesWithCitiesError) {
                                final error =
                                    state.provincesWithCitiesStatus
                                        as ProvincesWithCitiesError;
                                cityItems = error.message.split(',');
                              }

                              if (state.provincesWithCitiesStatus
                                  is ProvincesWithCitiesLoading) {
                                isCityLoading = true;
                              } else if (state.provincesWithCitiesStatus
                                  is ProvincesWithCitiesSuccess) {
                                final success =
                                    state.provincesWithCitiesStatus
                                        as ProvincesWithCitiesSuccess;

                                if (selectedProvince != null) {
                                  final selectedProvinceModel = success
                                      .provincesWithCities
                                      .firstWhere(
                                        (p) => p.name == selectedProvince,
                                        orElse: () =>
                                            success.provincesWithCities.first,
                                      );

                                  //* cities List
                                  cityItems = selectedProvinceModel.cities
                                      .map((c) => c.name)
                                      .toList();

                                  //* Fill in the public cityMap here.
                                  cityMap = {
                                    for (var c in selectedProvinceModel.cities)
                                      c.name: c.id,
                                  };
                                }

                                if (selectedCityName != null &&
                                    !cityItems.contains(selectedCityName)) {
                                  selectedCityName = null;
                                }
                              }
                              return CustomDropdown(
                                label: 'شهر محل سکونت',
                                hint:
                                    selectedCityName != null &&
                                        !cityItems.contains(selectedCityName)
                                    ? Text(selectedCityName!)
                                    : null,
                                icon: HugeIcons.strokeRoundedMapPin,
                                items: cityItems,
                                value: cityItems.contains(selectedCityName)
                                    ? selectedCityName
                                    : null,
                                isLoading: isCityLoading,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCityName = value;
                                    selectedCityId = cityMap[value];
                                  });
                                },
                              );
                            },
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

//! Profile Image Card
class ProfileImageCard extends StatefulWidget {
  final String? image;
  final Function(File?)? onImagePicked;
  const ProfileImageCard({super.key, this.image, this.onImagePicked});

  @override
  State<ProfileImageCard> createState() => _ProfileImageCardState();
}

class _ProfileImageCardState extends State<ProfileImageCard> {
  File? _pickedImage;

  Future<void> _handleEditImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _pickedImage = file;
      });
      widget.onImagePicked?.call(file);
    }
  }

  //! Delete Image Modal
  void _handleDeleteImage(BuildContext context) {
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
                        'حذف عکس',
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
                            'آیا از حذف عکس مطمئن هستید؟',
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
                                child: Button(
                                  backgroundColor: AppColors.error25,
                                  textColor: AppColors.error200,
                                  label: 'حذف عکس',
                                  onPressed: () {
                                    setState(() {
                                      _pickedImage = null;
                                    });
                                    widget.onImagePicked?.call(null);
                                    context.pop();
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

  @override
  Widget build(BuildContext context) {
    final displayImage = _pickedImage != null
        ? Image.file(_pickedImage!, height: 185, width: 185, fit: BoxFit.cover)
        : widget.image != null
        ? Image.network(
            widget.image!,
            height: 185,
            width: 185,
            fit: BoxFit.cover,
          )
        : Image.asset(
            'assets/images/image3.jpg',
            height: 185,
            width: 185,
            fit: BoxFit.cover,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: displayImage,
            ),
            Positioned(
              bottom: -12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _handleEditImage,
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
                    onPressed: () => _handleDeleteImage(context),
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
