import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String? picture;
  final String? fullName;
  final String? email;
  final int walletBalance;
  final String? biography;
  final String? resume;
  final String? linkedIn;
  final String? instagram;
  final String? telegramId;
  final String? city;
  final String? gender;
  final String? birthDate;
  final String? eitaaId;
  final String? bale;
  final String? rubika;

  const UserEntity({
    required this.id,
    required this.username,
    this.picture,
    this.fullName,
    this.email,
    required this.walletBalance,
    this.biography,
    this.resume,
    this.linkedIn,
    this.instagram,
    this.telegramId,
    this.city,
    this.gender,
    this.birthDate,
    this.eitaaId,
    this.bale,
    this.rubika,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    picture,
    fullName,
    email,
    walletBalance,
    biography,
    resume,
    linkedIn,
    instagram,
    telegramId,
    city,
    gender,
    birthDate,
    eitaaId,
    bale,
    rubika,
  ];
}
