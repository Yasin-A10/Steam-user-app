import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';

class AgenciesApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<dynamic> getAgencies(int cityId) async {
    try {
      final response = await _apiClient.get(
        '$baseUrl/agencies/',
        queryParams: {'city': cityId},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch agencies... ${e.toString()}');
    }
  }
}
