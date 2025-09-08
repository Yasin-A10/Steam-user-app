import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  //! use in get_user_use_case
  Future<Either<String, UserEntity>> fetchUserData();
}
