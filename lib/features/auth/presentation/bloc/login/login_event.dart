part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginEventRequest extends LoginEvent {
  final String username;
  final String otp;

  LoginEventRequest({required this.username, required this.otp});
}
