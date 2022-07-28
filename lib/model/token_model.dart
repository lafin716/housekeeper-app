
class UserModel {
  String type;
  String accessToken;
  String refreshToken;
  String createdAt;

  UserModel({required this.type, required this.accessToken, required this.refreshToken, required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'createdAt': createdAt,
    };
  }
}