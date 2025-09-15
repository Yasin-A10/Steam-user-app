class LoginModel {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final bool isCreated;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.isCreated,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      userId: json['user_id'].toString(),
      isCreated: json['is_created'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user_id': userId,
      'is_created': isCreated,
    };
  }
}
