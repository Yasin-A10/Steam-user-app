// import 'package:dio/dio.dart';
// import 'package:steam/core/constants/api_info.dart';
// import 'package:steam/core/network/session_manager.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:steam/features/home/data/model/content_post_model.dart';

// class ContentPostApiProvider {
//   final Dio _dio = Dio();
//   final String baseUrl = ApiInfo.baseUrl;

//   ContentPostApiProvider() {
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

//   Future<ContentPostModel> getContentPost(int page, int pageSize) async {
//     final response = await _dio.get(
//       '$baseUrl/content/posts/',
//       queryParameters: {'page': page, 'page_size': pageSize},
//     );
//     return ContentPostModel.fromJson(response.data);
//   }
// }

import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';
import 'package:steam/features/home/data/model/content_post_model.dart';

class ContentPostApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<ContentPostModel> getContentPost(int page, int pageSize) async {
    try {
      final response = await _apiClient.get(
        '$baseUrl/content/posts/',
        queryParams: {'page': page, 'page_size': pageSize},
      );
      return ContentPostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get content post... ${e.toString()}');
    }
  }
}
