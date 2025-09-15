// import 'package:dio/dio.dart';
// import 'package:steam/core/constants/api_info.dart';
// import 'package:steam/core/network/session_manager.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class UserApiProvider {
//   final Dio _dio = Dio();
//   final String baseUrl = ApiInfo.baseUrl;

//   UserApiProvider() {
//     _dio.interceptors.add(
//       PrettyDioLogger(
//         requestBody: true,
//         requestHeader: true,
//         responseBody: true,
//         responseHeader: false,
//         error: true,
//         compact: true,
//         maxWidth: 90,
//       ),
//     );

//     // add token to header
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           final token = SessionManager.accessToken;
//           if (token.isNotEmpty) {
//             options.headers['Authorization'] = 'JWT $token';
//           }
//           return handler.next(options);
//         },
//       ),
//     );
//   }

//   Future<dynamic> getUser() async {
//     final response = await _dio.get('$baseUrl/me/${SessionManager.userId}');
//     return response;
//   }
// }

import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';
import 'package:steam/core/network/session_manager.dart';

class UserApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<dynamic> getUser() async {
    try {
      final response = await _apiClient.get(
        '$baseUrl/me/${SessionManager.instance.userId}/',
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get user... ${e.toString()}');
    }
  }
}
