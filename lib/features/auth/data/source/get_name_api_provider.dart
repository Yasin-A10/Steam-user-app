import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:steam/features/auth/data/model/get_name_model.dart';

class GetNameApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<GetNameModel> sendName(GetNameModel user) async {
    try {
      final data = user.picture != null
          ? await user.toFormData()
          : user.toJson();

      final response = await _apiClient.patch(
        '$baseUrl/me/${SessionManager.instance.userId}/',
        data: data,
      );

      return GetNameModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update personal info... ${e.toString()}');
    }
  }
}
