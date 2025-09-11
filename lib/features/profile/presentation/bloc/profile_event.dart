part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class UpdateResumeEvent extends ProfileEvent {
  final UpdateResumeModel updateResumeModel;
  UpdateResumeEvent({required this.updateResumeModel});
}
