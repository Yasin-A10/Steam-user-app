import 'package:dartz/dartz.dart';
import 'package:steam/features/personal_info/data/model/update_personal_info_model.dart';
import 'package:steam/features/personal_info/data/source/update_personal_info.dart';

class UpdateInfoRepositoryImpl {
  final UpdatePersonalInfoApiProvider apiProvider;

  UpdateInfoRepositoryImpl({required this.apiProvider});

  Future<Either<String, UpdatePersonalInfoModel>> updatePersonalInfo(
    UpdatePersonalInfoModel userInfo,
  ) async {
    try {
      final result = await apiProvider.updatePersonalInfo(userInfo);

      return Right(result);
    } catch (e) {
      return Left('Please try again later...${e.toString()}');
    }
  }
}
