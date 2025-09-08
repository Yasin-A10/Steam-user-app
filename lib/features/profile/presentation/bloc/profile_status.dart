import 'package:steam/features/profile/domain/entity/user_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileStatus {}

class ProfileLoading extends ProfileStatus {}

class ProfileSuccess extends ProfileStatus {
  final UserEntity userEntity;
  ProfileSuccess({required this.userEntity});
}

class ProfileError extends ProfileStatus {
  final String message;
  ProfileError({required this.message});
}
