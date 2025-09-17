import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:steam/core/constants/api_info.dart';
import 'package:steam/features/auth/data/model/login_model.dart';

class LoginApiProvider {
  final Dio _dio = Dio();

  LoginApiProvider() {
    _dio.options.baseUrl = ApiInfo.baseUrl;

    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<LoginModel> loginWithOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login/',
        data: {'username': phone, 'user_otp': otp},
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginModel.fromJson(response.data);
        return loginResponse;
      } else {
        throw Exception('خطا در ورود: ${response.data['error']}');
      }
    } on DioException catch (e) {
      throw Exception(
        'خطا در ارسال درخواست لاگین: ${e.response?.data ?? e.message}',
      );
    }
  }
}
