// import 'package:dio/dio.dart';
// import 'package:steam/core/constants/api_info.dart';
// import 'package:steam/core/network/session_manager.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:steam/features/personal_info/data/model/update_personal_info_model.dart';

// class UpdatePersonalInfoApiProvider {
//   final Dio _dio = Dio();
//   final String baseUrl = ApiInfo.baseUrl;

//   UpdatePersonalInfoApiProvider() {
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

//   Future<UpdatePersonalInfoModel> updatePersonalInfo(
//     UpdatePersonalInfoModel user,
//   ) async {
//     try {
//       final data = user.picture != null
//           ? await user.toFormData()
//           : user.toJson();

//       final response = await _dio.patch(
//         '$baseUrl/me/${SessionManager.userId}/',
//         data: data,
//       );

//       return UpdatePersonalInfoModel.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to update personal info... ${e.toString()}');
//     }
//   }
// }

import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:steam/features/personal_info/data/model/update_personal_info_model.dart';

class UpdatePersonalInfoApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<UpdatePersonalInfoModel> updatePersonalInfo(
    UpdatePersonalInfoModel user,
  ) async {
    try {
      final data = user.picture != null
          ? await user.toFormData()
          : user.toJson();

      final response = await _apiClient.patch(
        '$baseUrl/me/${SessionManager.instance.userId}/',
        data: data,
      );

      return UpdatePersonalInfoModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update personal info... ${e.toString()}');
    }
  }
}
