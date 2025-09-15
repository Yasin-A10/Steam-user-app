part of 'otp_bloc.dart';

abstract class OtpEvent {}

class OtpEventRequestOtp extends OtpEvent {
  final String username;

  OtpEventRequestOtp({required this.username});
}
