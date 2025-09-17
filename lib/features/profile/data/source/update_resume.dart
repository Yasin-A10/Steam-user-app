import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:steam/features/profile/data/model/update_resume_model.dart';

class UpdateResumeApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<UpdateResumeModel?> updateResume(UpdateResumeModel resumeModel) async {
    try {
      final Object data;

      if (resumeModel.resume != null) {
        data = await resumeModel.toFormData();
      } else {
        data = {"resume": null};
      }

      await _apiClient.patch(
        '$baseUrl/me/${SessionManager.instance.userId}/',
        data: data,
        // options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return null;
    } catch (e) {
      throw Exception('Failed to update resume... ${e.toString()}');
    }
  }
}
