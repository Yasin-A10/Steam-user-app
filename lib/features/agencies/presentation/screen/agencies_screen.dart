import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/cities/bloc/cities_bloc.dart';
import 'package:steam/core/cities/bloc/cities_status.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/number_formater.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/inputs/drop_down.dart';
import 'package:steam/core/widgets/social_icon_list.dart';
import 'package:steam/features/agencies/presentation/bloc/agencies_bloc.dart';

class AgenciesScreen extends StatefulWidget {
  const AgenciesScreen({super.key});

  @override
  State<AgenciesScreen> createState() => _AgenciesScreenState();
}

class _AgenciesScreenState extends State<AgenciesScreen> {
  String? selectedProvince = 'تهران';
  String? selectedCityName = 'تهران';
  int? selectedCityId = 303;

  Map<String, int> cityMap = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AgenciesBloc>(context).add(LoadAgencies(cityId: 303));
    BlocProvider.of<CitiesBloc>(context).add(LoadProvincesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نمایندگان'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(HugeIcons.strokeRoundedArrowRight01, size: 28),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<AgenciesBloc, AgenciesState>(
        builder: (context, state) {
          if (state is AgenciesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AgenciesError) {
            return Center(child: Text(state.message));
          }

          if (state is AgenciesSuccess) {
            if (state.agenciesModel.count == 0) {
              return const Center(child: Text('اطلاعاتی وجود ندارد'));
            }

            final agency = state.agenciesModel.results;

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        agency[0].user.picture != null
                            ? Image.network(
                                agency[0].user.picture!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/image1.png',
                                fit: BoxFit.cover,
                              ),

                        Container(
                          color: AppColors.white.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(0, -230, 0),
                    child: Column(
                      spacing: 16,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            spacing: 16,
                            children: [
                              Expanded(
                                child: BlocBuilder<CitiesBloc, CitiesState>(
                                  builder: (context, state) {
                                    List<String> provincesItems = [];
                                    bool isLoadingProvinces = false;

                                    if (state.provincesStatus
                                        is ProvincesLoading) {
                                      isLoadingProvinces = true;
                                    }

                                    if (state.provincesStatus
                                        is ProvincesError) {
                                      final ProvincesError provincesError =
                                          state.provincesStatus
                                              as ProvincesError;
                                      provincesItems = provincesError.message
                                          .split(',');
                                    }

                                    if (state.provincesStatus
                                        is ProvincesSuccess) {
                                      final ProvincesSuccess provincesSuccess =
                                          state.provincesStatus
                                              as ProvincesSuccess;
                                      provincesItems = provincesSuccess
                                          .provinces
                                          .map((e) => e.name)
                                          .toList();
                                    }
                                    return CustomDropdown(
                                      label: 'استان',
                                      icon: HugeIcons.strokeRoundedMapsCircle01,
                                      items: provincesItems,
                                      isLoading: isLoadingProvinces,
                                      hint: Text(agency[0].provinceName),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedProvince = value;
                                          selectedCityName = null;
                                          selectedCityId = null;
                                        });

                                        //! for get province id
                                        if (state.provincesStatus
                                            is ProvincesSuccess) {
                                          final provincesSuccess =
                                              state.provincesStatus
                                                  as ProvincesSuccess;
                                          final selectedProvinceId =
                                              provincesSuccess.provinces
                                                  .firstWhere(
                                                    (p) => p.name == value,
                                                  )
                                                  .id;

                                          BlocProvider.of<CitiesBloc>(
                                            context,
                                          ).add(
                                            LoadProvincesWithCitiesEvent(
                                              provinceId: selectedProvinceId,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: BlocBuilder<CitiesBloc, CitiesState>(
                                  builder: (context, state) {
                                    List<String> citiesItems = [];
                                    bool isLoadingCities = false;

                                    if (state.provincesWithCitiesStatus
                                        is ProvincesWithCitiesError) {
                                      final error =
                                          state.provincesWithCitiesStatus
                                              as ProvincesWithCitiesError;
                                      citiesItems = error.message.split(',');
                                    }

                                    if (state.provincesWithCitiesStatus
                                        is ProvincesWithCitiesLoading) {
                                      isLoadingCities = true;
                                    }

                                    if (state.provincesWithCitiesStatus
                                        is ProvincesWithCitiesSuccess) {
                                      final success =
                                          state.provincesWithCitiesStatus
                                              as ProvincesWithCitiesSuccess;

                                      if (selectedProvince != null) {
                                        final selectedProvinceModel = success
                                            .provincesWithCities
                                            .firstWhere(
                                              (p) => p.name == selectedProvince,
                                              orElse: () => success
                                                  .provincesWithCities
                                                  .first,
                                            );

                                        //* cities List
                                        citiesItems = selectedProvinceModel
                                            .cities
                                            .map((c) => c.name)
                                            .toList();

                                        //* Fill in the public cityMap here.
                                        cityMap = {
                                          for (var c
                                              in selectedProvinceModel.cities)
                                            c.name: c.id,
                                        };
                                      }

                                      if (selectedCityName != null &&
                                          !citiesItems.contains(
                                            selectedCityName,
                                          )) {
                                        selectedCityName = null;
                                      }
                                    }
                                    return CustomDropdown(
                                      label: 'شهر',
                                      icon: HugeIcons.strokeRoundedMapsSquare01,
                                      items: citiesItems,
                                      isLoading: isLoadingCities,
                                      hint:
                                          selectedCityName != null &&
                                              !citiesItems.contains(
                                                selectedCityName,
                                              )
                                          ? Text(selectedCityName!)
                                          : Text(agency[0].cityName),
                                      value:
                                          citiesItems.contains(selectedCityName)
                                          ? selectedCityName
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCityName = value;
                                          selectedCityId = cityMap[value];
                                        });

                                        BlocProvider.of<AgenciesBloc>(
                                          context,
                                        ).add(
                                          LoadAgencies(
                                            cityId: selectedCityId ?? 303,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            agency[0].user.picture != null
                                ? Image.network(
                                    agency[0].user.picture!,
                                    height: 185,
                                    width: 185,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/image2.png',
                                    height: 185,
                                    width: 185,
                                    fit: BoxFit.cover,
                                  ),
                            Text(
                              agency[0].user.fullName ?? 'نام کاربری',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.myGrey,
                              ),
                            ),
                            Text(
                              agency[0].user.biography ?? 'توضیحاتی وجود ندارد',
                              style: TextStyle(
                                color: AppColors.myGrey2,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 8,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
                                  formatNumberToPersianWithoutSeparator(
                                    agency[0].user.username,
                                  ),
                                  style: TextStyle(
                                    color: AppColors.myGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(
                                  HugeIcons.strokeRoundedCall02,
                                  color: AppColors.myGrey2,
                                  size: 24,
                                ),
                              ],
                            ),
                            Row(
                              spacing: 8,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  agency[0].user.email ?? 'ایمیل',
                                  style: TextStyle(
                                    color: AppColors.myGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(
                                  HugeIcons.strokeRoundedMail01,
                                  color: AppColors.myGrey2,
                                  size: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SocialIconList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Button(
                            onPressed: () {
                              if (agency[0].user.resume == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: AppColors.error200,
                                    content: const Text('رزومه وجود ندارد'),
                                  ),
                                );
                              } else {
                                GoRouter.of(context).push(
                                  '/resume-viewer',
                                  extra: agency[0].user.resume,
                                );
                              }
                            },
                            label: 'مشاهده رزومه',
                            textColor: AppColors.orange,
                            backgroundColor: AppColors.orangeLight,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('اطلاعاتی وجود ندارد'));
        },
      ),
    );
  }
}
