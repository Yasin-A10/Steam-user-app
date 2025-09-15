import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';
import 'package:steam/core/network/session_manager.dart';

class LogoutApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  LogoutApiProvider();

  Future<dynamic> logout() async {
    try {
      final response = await _apiClient.post(
        '$baseUrl/auth/logout/',
        data: {'refresh': SessionManager.instance.refreshToken},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to logout... ${e.toString()}');
    }
  }
}
