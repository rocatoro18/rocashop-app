import 'package:teslo_shop/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
      id: json['id'],
      username: json['fullName'],
      email: json['email'],
      roles: List<String>.from(json['roles'].map((rol) => rol)),
      token: json['token'] ?? '');
}
