import 'package:steam/features/profile/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.username,
    super.picture,
    super.fullName,
    super.email,
    super.walletBalance,
    super.biography,
    super.resume,
    super.linkedIn,
    super.instagram,
    super.telegramId,
    super.city,
    super.gender,
    super.birthDate,
    super.eitaaId,
    super.bale,
    super.rubika,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      picture: json['picture'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      walletBalance: json['wallet_balance'] as int,
      biography: json['biography'] as String?,
      resume: json['resume'] as String?,
      linkedIn: json['linked_in'] as String?,
      instagram: json['instagram'] as String?,
      telegramId: json['telegram_id'] as String?,
      city: json['city'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birth_date'] as String?,
      eitaaId: json['eitaa_id'] as String?,
      bale: json['bale'] as String?,
      rubika: json['rubika'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'picture': picture,
      'full_name': fullName,
      'email': email,
      'wallet_balance': walletBalance,
      'biography': biography,
      'resume': resume,
      'linked_in': linkedIn,
      'instagram': instagram,
      'telegram_id': telegramId,
      'city': city,
      'gender': gender,
      'birth_date': birthDate,
      'eitaa_id': eitaaId,
      'bale': bale,
      'rubika': rubika,
    };
  }
}
