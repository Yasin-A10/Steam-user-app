import 'package:dio/dio.dart';
import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:steam/features/contact_way/data/model/contact_model.dart';

class UpdateContactApiProvider {
  final Dio _dio = Dio();
  final String baseUrl = ApiInfo.baseUrl;

  UpdateContactApiProvider() {
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

  Future<ContactModel> updateContact(ContactModel contact) async {
    try {
      final body = contact.toJson();

      final response = await _dio.patch(
        '$baseUrl/me/${SessionManager.userId}/',
        data: body,
      );

      return ContactModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update contact... ${e.toString()}');
    }
  }
}
