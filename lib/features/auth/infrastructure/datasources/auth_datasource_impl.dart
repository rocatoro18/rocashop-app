import 'package:teslo_shop/features/auth/domain/domain.dart';

class AuthDataSourceImpl extends AuthDataSource {
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register(String username, String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
