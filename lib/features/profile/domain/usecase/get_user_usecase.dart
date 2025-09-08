import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase {
  UserRepository userRepository;
  GetUserUseCase({required this.userRepository});

  //! for call repository method
  Future<Either<String, UserEntity>> call() async {
    return await userRepository.fetchUserData();
  }
}
