// import 'package:dio/dio.dart';
// import 'package:steam/core/network/auth_api_client.dart';

// class OtpApiProvider {
//   final AuthApiClient _apiClient;

//   OtpApiProvider(this._apiClient);

//   Future<dynamic> requestOtp(String username) async {
//     try {
//       final response = await _apiClient.post(
//         '/auth/otp/',
//         data: {'username': username},
//       );

//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception('خطا در دریافت OTP: ${response.data['message']}');
//       }
//     } on DioException catch (e) {
//       throw Exception(
//         'خطا در ارسال درخواست OTP: ${e.response?.data ?? e.message}',
//       );
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:steam/core/constants/api_info.dart';

class OtpApiProvider {
  final Dio _dio = Dio();
  final String baseUrl = ApiInfo.baseUrl;

  OtpApiProvider() {
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

  Future<bool> requestOtp(String username) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/otp/',
        data: {'username': username},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('خطا در دریافت OTP: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('خطا در ارسال درخواست OTP: $e');
    }
  }
}
