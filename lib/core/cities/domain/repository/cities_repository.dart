import 'package:dartz/dartz.dart';
import 'package:steam/core/cities/domain/entity/cities_entity.dart';

abstract class CitiesRepository {
  //! use in get_provinces_use_case
  Future<Either<String, List<ProvinceEntity>>> fetchProvinces();

  //! use in get_provinces_with_cities_use_case
  Future<Either<String, List<ProvinceWithCitiesEntity>>>
  fetchProvincesWithCities({int? provinceId});
}
