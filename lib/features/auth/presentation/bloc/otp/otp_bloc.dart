import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam/features/auth/data/repository/otp_repository_impl.dart';

part 'otp_state.dart';
part 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepositoryImpl repository;
  OtpBloc({required this.repository}) : super(OtpStateInitial()) {
    on<OtpEventRequestOtp>((event, emit) async {
      emit(OtpStateLoading());

      try {
        final Either<String, bool> result = await repository.requestOtp(
          event.username,
        );
        result.fold(
          (left) => emit(OtpStateError(error: left)),
          (right) => emit(OtpStateSuccess(success: right)),
        );
      } catch (e) {
        emit(OtpStateError(error: 'Unexpected error: ${e.toString()}'));
      }
    });
  }
}
