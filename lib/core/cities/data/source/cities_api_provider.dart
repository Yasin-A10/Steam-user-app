// import 'package:dio/dio.dart';
// import 'package:steam/core/constants/api_info.dart';
// import 'package:steam/core/network/session_manager.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class ProvinceApiProvider {
//   final Dio _dio = Dio();
//   final String baseUrl = ApiInfo.baseUrl;

//   ProvinceApiProvider() {
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

//   Future<dynamic> getProvinces() async {
//     final response = await _dio.get('$baseUrl/cities/');
//     return response;
//   }
// }

// class ProvinceWithCitiesApiProvider {
//   final Dio _dio = Dio();
//   final String baseUrl = ApiInfo.baseUrl;

//   ProvinceWithCitiesApiProvider() {
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

//   Future<dynamic> getProvincesWithCities({int? provinceId}) async {
//     final response = await _dio.get('$baseUrl/cities/$provinceId/');
//     return response;
//   }
// }

import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';

class ProvinceApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<dynamic> getProvinces() async {
    try {
      final response = await _apiClient.get('$baseUrl/cities/');
      return response;
    } catch (e) {
      throw Exception('Failed to get provinces... ${e.toString()}');
    }
  }
}

class ProvinceWithCitiesApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<dynamic> getProvincesWithCities({int? provinceId}) async {
    try {
      final response = await _apiClient.get('$baseUrl/cities/$provinceId/');
      return response;
    } catch (e) {
      throw Exception('Failed to get provinces with cities... ${e.toString()}');
    }
  }
}
