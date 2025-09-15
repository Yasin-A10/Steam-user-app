import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:steam/features/auth/data/model/get_name_model.dart';
import 'package:steam/features/auth/data/repository/get_name_repository_impl.dart';

part 'get_name_event.dart';
part 'get_name_state.dart';

class GetNameBloc extends Bloc<GetNameEvent, GetNameState> {
  final GetNameRepositoryImpl repository;

  GetNameBloc({required this.repository}) : super(GetNameInitial()) {
    on<SendNameEvent>(_onSendName);
  }

  Future<void> _onSendName(
    SendNameEvent event,
    Emitter<GetNameState> emit,
  ) async {
    emit(GetNameLoading());

    try {
      final Either<String, GetNameModel> result = await repository.sendName(
        event.userInfo,
      );

      result.fold(
        (error) => emit(GetNameError(message: error)),
        (getNameModel) => emit(GetNameSuccess(getNameModel: getNameModel)),
      );
    } catch (e) {
      emit(GetNameError(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
