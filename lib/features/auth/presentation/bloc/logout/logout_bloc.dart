import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam/features/auth/data/repository/logout_repository_impl.dart';

part 'logout_state.dart';
part 'logout_event.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutRepositoryImpl repository;
  LogoutBloc({required this.repository}) : super(LogoutStateInitial()) {
    on<LogoutEventRequest>((event, emit) async {
      emit(LogoutStateLoading());
      try {
        final Either<String, Unit> response = await repository.logout();
        response.fold(
          (l) => emit(LogoutStateError(message: l)),
          (r) => emit(LogoutStateSuccess()),
        );
      } catch (e) {
        emit(LogoutStateError(message: e.toString()));
      }
    });
  }
}
