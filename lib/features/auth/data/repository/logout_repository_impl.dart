import 'package:dartz/dartz.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:steam/features/auth/data/source/logout_api_provider.dart';

//? Unit is a type that represents the absence of a value

class LogoutRepositoryImpl {
  final LogoutApiProvider apiProvider;

  LogoutRepositoryImpl({required this.apiProvider});

  Future<Either<String, Unit>> logout() async {
    try {
      await apiProvider.logout();

      await SessionManager.instance.clearSession();

      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
