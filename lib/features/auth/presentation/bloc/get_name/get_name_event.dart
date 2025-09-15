part of 'get_name_bloc.dart';

abstract class GetNameEvent {}

class SendNameEvent extends GetNameEvent {
  final GetNameModel userInfo;

  SendNameEvent({required this.userInfo});
}
