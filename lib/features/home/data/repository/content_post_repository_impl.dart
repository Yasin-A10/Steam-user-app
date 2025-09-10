import 'package:dartz/dartz.dart';
import 'package:steam/features/home/data/model/content_post_model.dart';
import 'package:steam/features/home/data/source/content_post_api_provider.dart';

class ContentPostRepositoryImpl {
  final ContentPostApiProvider apiProvider;

  ContentPostRepositoryImpl({required this.apiProvider});

  Future<Either<String, ContentPostModel>> getContentPost(
    int page,
    int pageSize,
  ) async {
    try {
      final result = await apiProvider.getContentPost(page, pageSize);
      return Right(result);
    } catch (e) {
      return Left('Please try again later...${e.toString()}');
    }
  }
}
