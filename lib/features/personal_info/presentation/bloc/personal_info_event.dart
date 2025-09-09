part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent {}

class LoadPersonalInfoEvent extends PersonalInfoEvent {}

class UpdatePersonalInfoEvent extends PersonalInfoEvent {
  final UpdatePersonalInfoModel userInfo;

  UpdatePersonalInfoEvent({required this.userInfo});
}
