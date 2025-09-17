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
