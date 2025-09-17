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
