class ContactModel {
  final String username;
  final String? email;
  final String? telegramId;
  final String? instagram;
  final String? linkedIn;
  final String? eitaaId;
  final String? bale;
  final String? rubika;

  ContactModel({
    required this.username,
    this.email,
    this.telegramId,
    this.instagram,
    this.linkedIn,
    this.eitaaId,
    this.bale,
    this.rubika,
  });

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = {};

  //   if (username != null) data['username'] = username;
  //   if (email != null) data['email'] = email;
  //   if (telegramId != null) data['telegram_id'] = telegramId;
  //   if (instagram != null) data['instagram'] = instagram;
  //   if (linkedIn != null) data['linked_in'] = linkedIn;
  //   if (eitaaId != null) data['eitaa_id'] = eitaaId;
  //   if (bale != null) data['bale'] = bale;
  //   if (rubika != null) data['rubika'] = rubika;

  //   return data;
  // }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'telegram_id': telegramId,
      'instagram': instagram,
      'linked_in': linkedIn,
      'eitaa_id': eitaaId,
      'bale': bale,
      'rubika': rubika,
    };
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      username: json['username'] as String,
      email: json['email'] as String?,
      telegramId: json['telegram_id'] as String?,
      instagram: json['instagram'] as String?,
      linkedIn: json['linked_in'] as String?,
      eitaaId: json['eitaa_id'] as String?,
      bale: json['bale'] as String?,
      rubika: json['rubika'] as String?,
    );
  }
}
