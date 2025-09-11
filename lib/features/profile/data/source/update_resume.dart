import 'package:dio/dio.dart';
import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:steam/features/profile/data/model/update_resume_model.dart';

class UpdateResumeApiProvider {
  final Dio _dio = Dio();
  final String baseUrl = ApiInfo.baseUrl;

  UpdateResumeApiProvider() {
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

  Future<UpdateResumeModel?> updateResume(UpdateResumeModel resumeModel) async {
    try {
      final Object data;
      if (resumeModel.resume != null) {
        data = await resumeModel.toFormData();
      } else {
        data = {"resume": null};
      }

      await _dio.patch(
        '$baseUrl/me/${SessionManager.userId}/',
        data: data,
        // options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return null;
    } catch (e) {
      throw Exception('Failed to update resume... ${e.toString()}');
    }
  }
}
