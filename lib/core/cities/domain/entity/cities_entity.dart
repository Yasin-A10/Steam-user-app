import 'package:equatable/equatable.dart';

class ProvinceEntity extends Equatable {
  final int id;
  final String name;

  const ProvinceEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

// class ProvinceWithCitiesEntity extends Equatable {
//   final int id;
//   final String name;
//   final List<CityModel> cities;

//   const ProvinceWithCitiesEntity({
//     required this.id,
//     required this.name,
//     required this.cities,
//   });

//   @override
//   List<Object?> get props => [id, name, cities];
// }

// cities_entity.dart
class CityEntity extends Equatable {
  final int id;
  final String name;

  const CityEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class ProvinceWithCitiesEntity extends Equatable {
  final int id;
  final String name;
  final List<CityEntity> cities;

  const ProvinceWithCitiesEntity({
    required this.id,
    required this.name,
    required this.cities,
  });

  @override
  List<Object?> get props => [id, name, cities];
}
