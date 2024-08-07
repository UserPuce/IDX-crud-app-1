import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, String?>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<String?> {
  LoginNotifier() : super(null);

  void login(String username, String password) {
    if (username == 'user' && password == 'password') {
      state = username;
    }
  }

  void logout() {
    state = null;
  }
}
