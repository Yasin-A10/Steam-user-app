import 'package:dartz/dartz.dart';
import 'package:steam/core/cities/domain/repository/cities_repository.dart';
import 'package:steam/core/cities/domain/entity/cities_entity.dart';

class GetCitiesUseCase {
  CitiesRepository citiesRepository;
  GetCitiesUseCase({required this.citiesRepository});

  //* for call provinces repository method
  Future<Either<String, List<ProvinceEntity>>> call() async {
    return await citiesRepository.fetchProvinces();
  }
}

class GetCitiesWithProvinceUseCase {
  CitiesRepository citiesRepository;
  GetCitiesWithProvinceUseCase({required this.citiesRepository});

  //* for call province with cities repository method
  Future<Either<String, List<ProvinceWithCitiesEntity>>> call({
    int? provinceId,
  }) async {
    return await citiesRepository.fetchProvincesWithCities(
      provinceId: provinceId,
    );
  }
}
