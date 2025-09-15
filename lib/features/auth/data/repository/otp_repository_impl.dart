import 'package:dartz/dartz.dart';
import 'package:steam/features/auth/data/source/otp_api_provider.dart';

class OtpRepositoryImpl {
  final OtpApiProvider apiProvider;

  OtpRepositoryImpl({required this.apiProvider});

  Future<Either<String, bool>> requestOtp(String username) async {
    try {
      final result = await apiProvider.requestOtp(username);

      return Right(result);
    } catch (e) {
      return Left('خطا در دریافت OTP: ${e.toString()}');
    }
  }
}
