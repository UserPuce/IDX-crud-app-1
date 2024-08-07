//biblioteca de gestion de estado
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Definimos un proveedor de estado que usará la clase LoginNotifier para manejar el estado de login.
final loginProvider = StateNotifierProvider<LoginNotifier, String?>((ref) {
  return LoginNotifier(); // Crea una instancia de LoginNotifier.
});

// La clase LoginNotifier extiende StateNotifier y maneja un estado de tipo String? (puede ser una cadena o null).
class LoginNotifier extends StateNotifier<String?> {
  LoginNotifier() : super(null); // Inicializa el estado con null.

  // Método para realizar el login.
  void login(String username, String password) {
    // Si el usuario y la contraseña son correctos, actualiza el estado con el nombre de usuario.
    if (username == 'pablo' && password == 'clave') {
      state = username;
    }
  }

  // Método para realizar el logout.
  void logout() {
    state = null; // Resetea el estado a null.
  }
}
