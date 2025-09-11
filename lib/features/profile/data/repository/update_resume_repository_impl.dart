import 'package:dartz/dartz.dart';
import 'package:steam/features/profile/data/model/update_resume_model.dart';
import 'package:steam/features/profile/data/source/update_resume.dart';

class UpdateResumeRepositoryImpl {
  final UpdateResumeApiProvider apiProvider;

  UpdateResumeRepositoryImpl({required this.apiProvider});

  Future<Either<String, UpdateResumeModel>> updateResume(
    UpdateResumeModel userInfo,
  ) async {
    try {
      final result = await apiProvider.updateResume(userInfo);

      if (result == null) {
        return Right(UpdateResumeModel(resume: null));
      }

      return Right(result);
    } catch (e) {
      return Left('Unexpected error: ${e.toString()}');
    }
  }
}
