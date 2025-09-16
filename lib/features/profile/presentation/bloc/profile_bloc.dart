import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:steam/features/profile/data/model/update_resume_model.dart';
import 'package:steam/features/profile/data/repository/update_resume_repository_impl.dart';
import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/domain/usecase/get_user_usecase.dart';
import 'package:steam/features/profile/presentation/bloc/profile_status.dart';
import 'package:steam/features/profile/presentation/bloc/update_resume_status.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUseCase getUserUseCase;
  final UpdateResumeRepositoryImpl updateResumeRepository;

  ProfileBloc({
    required this.getUserUseCase,
    required this.updateResumeRepository,
  }) : super(
         ProfileState(
           profileStatus: ProfileLoading(),
           resumeStatus: ResumeInitial(),
         ),
       ) {
    on<LoadProfileEvent>((event, emit) async {
      // emit loading state
      emit(
        state.copyWith(
          newProfileStatus: ProfileLoading(),
          newResumeStatus: ResumeLoading(),
        ),
      );

      // call use case
      Either<String, UserEntity> dataState = await getUserUseCase();

      // emit error or success state
      dataState.fold(
        (left) =>
            emit(state.copyWith(newProfileStatus: ProfileError(message: left))),
        (right) => emit(
          state.copyWith(newProfileStatus: ProfileSuccess(userEntity: right)),
        ),
      );
    });

    on<UpdateResumeEvent>((event, emit) async {
      emit(state.copyWith(newResumeStatus: ResumeLoading()));

      // call use case
      try {
        final Either<String, UpdateResumeModel?> result =
            await updateResumeRepository.updateResume(event.updateResumeModel);

        result.fold(
          (error) => emit(
            state.copyWith(newResumeStatus: ResumeError(message: error)),
          ),
          (updateResumeModel) {
            // final bool isDeleted = updateResumeModel?.resume == null;
            final bool isDeleted = event.isDelete;

            emit(
              state.copyWith(
                newResumeStatus: ResumeSuccess(
                  updateResumeModel:
                      updateResumeModel ?? UpdateResumeModel(resume: null),
                  isDeleted: isDeleted,
                ),
              ),
            );
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            newResumeStatus: ResumeError(
              message: 'Unexpected error: ${e.toString()}',
            ),
          ),
        );
      }
    });
  }
}
