import 'package:steam/core/constants/api_info.dart';
import 'package:steam/core/network/auth_api_client.dart';
import 'package:steam/core/network/session_manager.dart';
import 'package:steam/features/contact_way/data/model/contact_model.dart';

class UpdateContactApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<ContactModel> updateContact(ContactModel contact) async {
    try {
      final body = contact.toJson();
      final response = await _apiClient.patch(
        '$baseUrl/me/${SessionManager.instance.userId}/',
        data: body,
      );
      return ContactModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update contact... ${e.toString()}');
    }
  }
}
