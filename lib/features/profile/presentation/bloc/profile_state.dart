part of 'profile_bloc.dart';

class ProfileState {
  ProfileStatus profileStatus;
  ResumeStatus resumeStatus;

  ProfileState({required this.profileStatus, required this.resumeStatus});

  ProfileState copyWith({
    ProfileStatus? newProfileStatus,
    ResumeStatus? newResumeStatus,
  }) {
    return ProfileState(
      profileStatus: newProfileStatus ?? this.profileStatus,
      resumeStatus: newResumeStatus ?? this.resumeStatus,
    );
  }
}
