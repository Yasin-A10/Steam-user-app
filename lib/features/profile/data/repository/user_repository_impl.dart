import 'package:dartz/dartz.dart';
import 'package:steam/features/profile/data/model/user_model.dart';
import 'package:steam/features/profile/data/source/user_api_provider.dart';
import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/domain/repository/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl extends UserRepository {
  UserApiProvider apiProvider;

  UserRepositoryImpl({required this.apiProvider});

  @override
  Future<Either<String, UserEntity>> fetchUserData() async {
    try {
      // for loading state from api provider
      Response response = await apiProvider.getUser();

      // for success state
      if (response.statusCode == 200) {
        UserEntity userEntity = UserModel.fromJson(response.data);
        return Right(userEntity);
      }
      // for error state
      else {
        return Left('Failed to fetch user data...');
      }
    } catch (e) {
      return Left('Please try again later...');
    }
  }
}
