import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/cities/bloc/cities_bloc.dart';
import 'package:steam/core/cities/bloc/cities_status.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/validators.dart';
import 'package:steam/core/widgets/inputs/drop_down.dart';
import 'package:steam/core/widgets/inputs/input_form_feild.dart';

GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String? selectedProvince;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    final citiesBloc = BlocProvider.of<CitiesBloc>(context);
    citiesBloc.add(LoadProvincesEvent());
  }

  @override
  Widget build(BuildContext context) {
    //! Provide Bloc
    // final citiesBloc = BlocProvider.of<CitiesBloc>(context);
    // citiesBloc.add(LoadProvincesEvent());

    //! UI
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
                    // CustomDropdown(
                    //   label: 'استان محل سکونت',
                    //   icon: HugeIcons.strokeRoundedMapPin,
                    //   items: items,
                    //   onChanged: (value) {},
                    // ),
                    // const SizedBox(height: 16),
                    // CustomDropdown(
                    //   label: 'شهر محل سکونت',
                    //   icon: HugeIcons.strokeRoundedMapPin,
                    //   items: items,
                    //   onChanged: (value) {},
                    // ),
                    BlocBuilder<CitiesBloc, CitiesState>(
                      builder: (context, state) {
                        List<String> provincesItems = [];
                        bool isLoadingProvinces = false;

                        if (state.provincesStatus is ProvincesLoading) {
                          isLoadingProvinces = true;
                        } else if (state.provincesStatus is ProvincesSuccess) {
                          final ProvincesSuccess provincesSuccess =
                              state.provincesStatus as ProvincesSuccess;
                          provincesItems = provincesSuccess.provinces
                              .map((e) => e.name)
                              .toList();
                        } else if (state.provincesStatus is ProvincesError) {
                          final ProvincesError provincesError =
                              state.provincesStatus as ProvincesError;
                          provincesItems = provincesError.message.split(',');
                        }

                        return CustomDropdown(
                          label: 'استان محل سکونت',
                          icon: HugeIcons.strokeRoundedMapPin,
                          items: provincesItems,
                          value: selectedProvince,
                          isLoading: isLoadingProvinces,
                          onChanged: (value) {
                            setState(() {
                              selectedProvince = value;
                              selectedCity = null;
                            });

                            //! for get province id
                            if (state.provincesStatus is ProvincesSuccess) {
                              final provincesSuccess =
                                  state.provincesStatus as ProvincesSuccess;
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

                    // BlocBuilder<CitiesBloc, CitiesState>(
                    //   builder: (context, state) {
                    //     List<String> cityItems = [];
                    //     bool isCityLoading = false;

                    //     if (state.provincesWithCitiesStatus
                    //         is ProvincesWithCitiesLoading) {
                    //       isCityLoading = true;
                    //     } else if (state.provincesWithCitiesStatus
                    //         is ProvincesWithCitiesSuccess) {
                    //       final provincesWithCitiesSuccess =
                    //           state.provincesWithCitiesStatus
                    //               as ProvincesWithCitiesSuccess;
                    //       cityItems = provincesWithCitiesSuccess
                    //           .provincesWithCities
                    //           .map((e) => e.name)
                    //           .toList();

                    //       // Reset selectedCity when a new province is selected
                    //       if (!cityItems.contains(selectedCity)) {
                    //         selectedCity = null;
                    //       }
                    //     }

                    //     return CustomDropdown(
                    //       label: 'شهر محل سکونت',
                    //       icon: HugeIcons.strokeRoundedMapPin,
                    //       items: cityItems,
                    //       value: selectedCity,
                    //       isLoading: isCityLoading,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           selectedCity = value;
                    //         });
                    //       },
                    //     );
                    //   },
                    // ),
                    // The corrected BlocBuilder for the cities dropdown
                    BlocBuilder<CitiesBloc, CitiesState>(
                      builder: (context, state) {
                        List<String> cityItems = [];
                        bool isCityLoading = false;

                        // First, handle the loading state
                        if (state.provincesWithCitiesStatus
                            is ProvincesWithCitiesLoading) {
                          isCityLoading = true;
                        }
                        // Then, handle the success state
                        else if (state.provincesWithCitiesStatus
                            is ProvincesWithCitiesSuccess) {
                          final success =
                              state.provincesWithCitiesStatus
                                  as ProvincesWithCitiesSuccess;

                          // Make sure a province is selected before trying to get cities
                          if (selectedProvince != null) {
                            // Find the selected province from the list.
                            final selectedProvinceModel = success
                                .provincesWithCities
                                .firstWhere(
                                  (p) => p.name == selectedProvince,
                                  // Add a fallback in case the province is not found
                                  orElse: () =>
                                      success.provincesWithCities.first,
                                );

                            // Get the list of city names from the found province
                            cityItems = selectedProvinceModel.cities
                                .map((c) => c.name)
                                .toList();
                          }

                          // Check if the currently selected city is still in the list of available cities
                          if (selectedCity != null &&
                              !cityItems.contains(selectedCity)) {
                            selectedCity = null;
                          }
                        }

                        return CustomDropdown(
                          label: 'شهر محل سکونت',
                          icon: HugeIcons.strokeRoundedMapPin,
                          items: cityItems,
                          value: selectedCity,
                          isLoading: isCityLoading,
                          onChanged: (value) {
                            setState(() {
                              selectedCity = value;
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 16),
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
