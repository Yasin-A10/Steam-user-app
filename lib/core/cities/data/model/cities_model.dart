import 'package:steam/core/cities/domain/entity/cities_entity.dart';

// for provinces
class ProvinceModel extends ProvinceEntity {
  const ProvinceModel({required super.id, required super.name});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

// for province with own cities
// class ProvinceWithCitiesModel extends ProvinceWithCitiesEntity {
//   const ProvinceWithCitiesModel({
//     required super.id,
//     required super.name,
//     required super.cities,
//   });

//   factory ProvinceWithCitiesModel.fromJson(Map<String, dynamic> json) {
//     return ProvinceWithCitiesModel(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       cities: (json['cities'] as List)
//           .map((e) => CityModel.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'cities': cities.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class CityModel {
//   final int id;
//   final String name;

//   const CityModel({required this.id, required this.name});

//   factory CityModel.fromJson(Map<String, dynamic> json) {
//     return CityModel(id: json['id'] as int, name: json['name'] as String);
//   }

//   Map<String, dynamic> toJson() => {"id": id, "name": name};
// }

// cities_model.dart
class CityModel extends CityEntity {
  const CityModel({required super.id, required super.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ProvinceWithCitiesModel extends ProvinceWithCitiesEntity {
  const ProvinceWithCitiesModel({
    required super.id,
    required super.name,
    required super.cities,
  });

  factory ProvinceWithCitiesModel.fromJson(Map<String, dynamic> json) {
    return ProvinceWithCitiesModel(
      id: json['id'],
      name: json['name'],
      cities: (json['cities'] as List)
          .map((e) => CityModel.fromJson(e))
          .toList(),
    );
  }
}
