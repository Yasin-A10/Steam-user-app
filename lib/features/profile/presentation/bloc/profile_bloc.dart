import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:steam/features/profile/domain/usecase/get_user_usecase.dart';
import 'package:steam/features/profile/presentation/bloc/profile_status.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserUseCase getUserUseCase;

  ProfileBloc({required this.getUserUseCase})
    : super(ProfileState(profileStatus: ProfileLoading())) {
    on<LoadProfileEvent>((event, emit) async {
      // emit loading state
      emit(state.copyWith(newProfileStatus: ProfileLoading()));

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
  }
}
