part of 'cities_bloc.dart';

class CitiesState {
  ProvincesStatus provincesStatus;
  ProvincesWithCitiesStatus provincesWithCitiesStatus;
  // ProvinceEntity? selectedProvince;
  // ProvinceWithCitiesEntity? selectedCity;

  CitiesState({
    required this.provincesStatus,
    required this.provincesWithCitiesStatus,
    // this.selectedProvince,
    // this.selectedCity,
  });

  CitiesState copyWith({
    ProvincesStatus? newProvincesStatus,
    ProvincesWithCitiesStatus? newProvincesWithCitiesStatus,
    // ProvinceEntity? newSelectedProvince,
    // ProvinceWithCitiesEntity? newSelectedCity,
  }) {
    return CitiesState(
      provincesStatus: newProvincesStatus ?? this.provincesStatus,
      provincesWithCitiesStatus:
          newProvincesWithCitiesStatus ?? this.provincesWithCitiesStatus,
      // selectedProvince: newSelectedProvince ?? this.selectedProvince,
      // selectedCity: newSelectedCity ?? this.selectedCity,
    );
  }
}

// abstract class CitiesState {}

// class CitiesInit extends CitiesState {}

// class CitiesLoading extends CitiesState {}

// class CitiesLoading2 extends CitiesState {}

// class CitiesSuccess extends CitiesState {}

// class Provinceswithcitiessuccess1 extends CitiesState {
//   Either<String, ProvinceWithCitiesEntity> provincesWithCities;
//   Provinceswithcitiessuccess1({required this.provincesWithCities});
// }

// class ProvincesSuccess1 extends CitiesState {
//   final List<ProvinceEntity> provinces;
//   ProvincesSuccess1({required this.provinces});
// }

// class ProvincesError1 extends CitiesState {
//   final String message;
//   ProvincesError1({required this.message});
// }
