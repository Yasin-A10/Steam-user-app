import 'package:flutter/material.dart';
import 'package:steam/core/cities/domain/entity/cities_entity.dart';

//! for provinces
@immutable
abstract class ProvincesStatus {}

class ProvincesLoading extends ProvincesStatus {}

class ProvincesSuccess extends ProvincesStatus {
  final List<ProvinceEntity> provinces;
  ProvincesSuccess({required this.provinces});
}

class ProvincesError extends ProvincesStatus {
  final String message;
  ProvincesError({required this.message});
}

//! for province with cities
@immutable
abstract class ProvincesWithCitiesStatus {}

class ProvincesWithCitiesLoading extends ProvincesWithCitiesStatus {}

class ProvincesWithCitiesSuccess extends ProvincesWithCitiesStatus {
  final List<ProvinceWithCitiesEntity> provincesWithCities;
  ProvincesWithCitiesSuccess({required this.provincesWithCities});
}

class ProvincesWithCitiesError extends ProvincesWithCitiesStatus {
  final String message;
  ProvincesWithCitiesError({required this.message});
}

// //! for selected province
// @immutable
// abstract class SelectedProvinceStatus {}

// class SelectedProvinceLoading extends SelectedProvinceStatus {}

// class SelectedProvinceSuccess extends SelectedProvinceStatus {
//   final ProvinceEntity province;
//   SelectedProvinceSuccess({required this.province});
// }

// class SelectedProvinceError extends SelectedProvinceStatus {
//   final String message;
//   SelectedProvinceError({required this.message});
// }

// //! for selected city
// @immutable
// abstract class SelectedCityStatus {}

// class SelectedCityLoading extends SelectedCityStatus {}

// class SelectedCitySuccess extends SelectedCityStatus {
//   final ProvinceWithCitiesEntity city;
//   SelectedCitySuccess({required this.city});
// }

// class SelectedCityError extends SelectedCityStatus {
//   final String message;
//   SelectedCityError({required this.message});
// }
