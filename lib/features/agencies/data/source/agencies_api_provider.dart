import 'package:dio/dio.dart';
import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AgenciesApiProvider {
  final Dio _dio = Dio();
  final String baseUrl = ApiInfo.baseUrl;

  AgenciesApiProvider() {
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

    // add token to header
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SessionManager.accessToken;
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'JWT $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<dynamic> getAgencies(int cityId) async {
    final response = await _dio.get(
      '$baseUrl/agencies/',
      queryParameters: {'city': cityId},
    );
    return response;
  }
}
