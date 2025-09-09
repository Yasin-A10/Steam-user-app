import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:steam/features/personal_info/data/model/update_personal_info_model.dart';
import 'package:steam/features/personal_info/data/repository/update_info_repository_impl.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final UpdateInfoRepositoryImpl repository;

  PersonalInfoBloc({required this.repository}) : super(PersonalInfoInitial()) {
    on<LoadPersonalInfoEvent>((event, emit) {
      emit(PersonalInfoInitial());
    });

    on<UpdatePersonalInfoEvent>(_onUpdatePersonalInfo);
  }

  Future<void> _onUpdatePersonalInfo(
    UpdatePersonalInfoEvent event,
    Emitter<PersonalInfoState> emit,
  ) async {
    emit(PersonalInfoLoading());

    try {
      final Either<String, UpdatePersonalInfoModel> result = await repository
          .updatePersonalInfo(event.userInfo);

      result.fold(
        (error) => emit(PersonalInfoError(message: error)),
        (updatePersonalInfoModel) => emit(
          PersonalInfoSuccess(updatePersonalInfoModel: updatePersonalInfoModel),
        ),
      );
    } catch (e) {
      emit(PersonalInfoError(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
