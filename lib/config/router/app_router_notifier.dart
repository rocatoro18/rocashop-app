import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.watch(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

// STUDY
// ESTO SIEMPRE VA A SER IGUAL NO IMPORTA EL GESTOR DE ESTADO
class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this._authNotifier) {
    // EN TODO MOMENTO TENGO QUE ESTAR PENDIENTE DE ESTE ESTADO
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
