import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:steam/features/agencies/data/model/agencies_model.dart';
import 'package:steam/features/agencies/data/source/agencies_api_provider.dart';

class AgenciesRepositoryImpl {
  AgenciesApiProvider apiProvider;

  AgenciesRepositoryImpl({required this.apiProvider});

  Future<Either<String, AgenciesModel>> fetchAgencies({
    required int cityId,
  }) async {
    try {
      Response response = await apiProvider.getAgencies(cityId);

      if (response.statusCode == 200) {
        AgenciesModel agenciesModel = AgenciesModel.fromJson(response.data);
        return Right(agenciesModel);
      } else {
        return Left('Failed to fetch agencies...');
      }
    } catch (e) {
      return Left('Please try again later...');
    }
  }
}
