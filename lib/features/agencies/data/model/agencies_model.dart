class AgenciesModel {
  final int count;
  final String? next;
  final String? previous;
  final List<AgencyResult> results;

  AgenciesModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory AgenciesModel.fromJson(Map<String, dynamic> json) {
    return AgenciesModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => AgencyResult.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class AgencyResult {
  final AgencyUser user;
  final String provinceName;
  final String cityName;

  AgencyResult({
    required this.user,
    required this.provinceName,
    required this.cityName,
  });

  factory AgencyResult.fromJson(Map<String, dynamic> json) {
    return AgencyResult(
      user: AgencyUser.fromJson(json['user']),
      provinceName: json['province_name'],
      cityName: json['city_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'province_name': provinceName,
      'city_name': cityName,
    };
  }
}

class AgencyUser {
  final String id;
  final String username;
  final String? picture;
  final String? fullName;
  final String? email;
  final String? biography;
  final String? resume;
  final String? linkedIn;
  final String? instagram;
  final String? telegramId;
  final int? city;
  final String? eitaaId;
  final String? bale;
  final String? rubika;

  AgencyUser({
    required this.id,
    required this.username,
    this.picture,
    this.fullName,
    this.email,
    this.biography,
    this.resume,
    this.linkedIn,
    this.instagram,
    this.telegramId,
    this.city,
    this.eitaaId,
    this.bale,
    this.rubika,
  });

  factory AgencyUser.fromJson(Map<String, dynamic> json) {
    return AgencyUser(
      id: json['id'],
      username: json['username'],
      picture: json['picture'],
      fullName: json['full_name'],
      email: json['email'],
      biography: json['biography'],
      resume: json['resume'],
      linkedIn: json['linked_in'],
      instagram: json['instagram'],
      telegramId: json['telegram_id'],
      city: json['city'],
      eitaaId: json['eitaa_id'],
      bale: json['bale'],
      rubika: json['rubika'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'picture': picture,
      'full_name': fullName,
      'email': email,
      'biography': biography,
      'resume': resume,
      'linked_in': linkedIn,
      'instagram': instagram,
      'telegram_id': telegramId,
      'city': city,
      'eitaa_id': eitaaId,
      'bale': bale,
      'rubika': rubika,
    };
  }
}
