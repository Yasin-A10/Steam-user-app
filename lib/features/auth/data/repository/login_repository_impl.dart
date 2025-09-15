import 'package:dartz/dartz.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:steam/features/auth/data/model/login_model.dart';
import 'package:steam/features/auth/data/source/login_api_provider.dart';

class LoginRepositoryImpl {
  final LoginApiProvider apiProvider;

  LoginRepositoryImpl({required this.apiProvider});

  Future<Either<String, LoginModel>> loginWithOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final LoginModel response = await apiProvider.loginWithOtp(
        phone: phone,
        otp: otp,
      );

      await SessionManager.instance.saveSession(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        userId: response.userId,
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
