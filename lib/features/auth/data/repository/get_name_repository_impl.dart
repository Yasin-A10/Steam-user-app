import 'package:dartz/dartz.dart';
import 'package:steam/features/auth/data/model/get_name_model.dart';
import 'package:steam/features/auth/data/source/get_name_api_provider.dart';

class GetNameRepositoryImpl {
  final GetNameApiProvider apiProvider;

  GetNameRepositoryImpl({required this.apiProvider});

  Future<Either<String, GetNameModel>> sendName(GetNameModel userInfo) async {
    try {
      final result = await apiProvider.sendName(userInfo);

      return Right(result);
    } catch (e) {
      return Left('Please try again later...${e.toString()}');
    }
  }
}
