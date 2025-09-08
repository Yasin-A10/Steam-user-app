import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:steam/core/cities/data/model/cities_model.dart';
import 'package:steam/core/cities/data/source/cities_api_provider.dart';
import 'package:steam/core/cities/domain/entity/cities_entity.dart';
import 'package:steam/core/cities/domain/repository/cities_repository.dart';

class CitiesRepositoryImpl implements CitiesRepository {
  ProvinceApiProvider provinceApiProvider;
  ProvinceWithCitiesApiProvider provinceWithCitiesApiProvider;

  CitiesRepositoryImpl({
    required this.provinceApiProvider,
    required this.provinceWithCitiesApiProvider,
  });

  @override
  Future<Either<String, List<ProvinceEntity>>> fetchProvinces() async {
    try {
      //* for loading state from api provider
      final response = await provinceApiProvider.getProvinces();

      //* for success state
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          List<ProvinceEntity> provinces = data
              .map((e) => ProvinceModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
          return Right(provinces);
        } else {
          return Left('Invalid data format from server');
        }

        //* for error state
      } else {
        return Left('Failed to fetch provinces...');
      }
    } catch (e) {
      return Left('Please try again later...');
    }
  }

  @override
  Future<Either<String, List<ProvinceWithCitiesEntity>>>
  fetchProvincesWithCities({int? provinceId}) async {
    try {
      //* for loading state from api provider
      Response response = await provinceWithCitiesApiProvider
          .getProvincesWithCities(provinceId: provinceId);

      // print('runtimeType: ${response.data.runtimeType}');
      // print('data: ${response.data}');

      //* for success state
      if (response.statusCode == 200) {
        if (response.data is Map) {
          final model = ProvinceWithCitiesModel.fromJson(
            Map<String, dynamic>.from(response.data),
          );
          return Right([model]);
        }
        return Left('Invalid data format from server');
      }
      //* for error state
      else {
        return Left('Failed to fetch province with cities...');
      }
    } catch (e) {
      return Left('Please try again later...');
    }
  }
}
