part of 'personal_info_bloc.dart';

@immutable
abstract class PersonalInfoState {}

class PersonalInfoInitial extends PersonalInfoState {}

class PersonalInfoLoading extends PersonalInfoState {}

class PersonalInfoSuccess extends PersonalInfoState {
  final UpdatePersonalInfoModel updatePersonalInfoModel;
  PersonalInfoSuccess({required this.updatePersonalInfoModel});
}

class PersonalInfoError extends PersonalInfoState {
  final String message;
  PersonalInfoError({required this.message});
}
