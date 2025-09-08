part of 'cities_bloc.dart';

abstract class CitiesEvent {}

//! for provinces
class LoadProvincesEvent extends CitiesEvent {}

//! for province with cities
class LoadProvincesWithCitiesEvent extends CitiesEvent {
  final int provinceId;
  LoadProvincesWithCitiesEvent({required this.provinceId});
}

// //! for selected province
// class SelectProvinceEvent extends CitiesEvent {
//   final ProvinceEntity selectedProvince;

//   SelectProvinceEvent({required this.selectedProvince});
// }

// //! for selected city
// class SelectCityEvent extends CitiesEvent {
//   final String selectedCity;

//   SelectCityEvent({required this.selectedCity});
// }
