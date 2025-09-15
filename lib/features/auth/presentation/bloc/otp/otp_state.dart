part of 'otp_bloc.dart';

@immutable
abstract class OtpState {}

class OtpStateInitial extends OtpState {}

class OtpStateLoading extends OtpState {}

class OtpStateSuccess extends OtpState {
  final bool success;

  OtpStateSuccess({required this.success});
}

class OtpStateError extends OtpState {
  final String error;

  OtpStateError({required this.error});
}
