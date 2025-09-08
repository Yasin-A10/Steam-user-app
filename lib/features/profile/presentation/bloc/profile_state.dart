part of 'profile_bloc.dart';

class ProfileState {
  ProfileStatus profileStatus;

  ProfileState({required this.profileStatus});

  ProfileState copyWith({ProfileStatus? newProfileStatus}) {
    return ProfileState(profileStatus: newProfileStatus ?? this.profileStatus);
  }
}
