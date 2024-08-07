import 'package:flutter/material.dart'; // Importa el paquete de Flutter para construir interfaces de usuario.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod para la gestión del estado.
import '../providers/login_provider.dart'; // Importa el proveedor de login.

// Define un widget con estado que usa Riverpod para la gestión del estado.
class LoginWidget extends ConsumerStatefulWidget {
  // Constructor de la clase LoginWidget, se usa una clave opcional para identificar el widget.
  const LoginWidget({super.key});

  @override
  // Crea el estado asociado a este widget. 
  // _LoginWidgetState es la clase que maneja el estado de LoginWidget.
  // ignore: library_private_types_in_public_api
  _LoginWidgetState createState() => _LoginWidgetState();

}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final _usernameController = TextEditingController(); // Controlador para el campo de texto del nombre de usuario.
  final _passwordController = TextEditingController(); // Controlador para el campo de texto de la contraseña.

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Bordes redondeados para la tarjeta.
      ),
      elevation: 8, // Sombra de la tarjeta.
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Márgenes de la tarjeta.
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Espaciado interno de la tarjeta.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController, // Controlador para el campo de texto del nombre de usuario.
              decoration: InputDecoration(
                labelText: 'Username', // Etiqueta para el campo de texto.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Bordes redondeados para el borde del campo de texto.
                ),
                prefixIcon: const Icon(Icons.person), // Icono al inicio del campo de texto.
              ),
            ),
            const SizedBox(height: 20), // Espacio entre los campos de texto.
            TextField(
              controller: _passwordController, // Controlador para el campo de texto de la contraseña.
              decoration: InputDecoration(
                labelText: 'Password', // Etiqueta para el campo de texto.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Bordes redondeados para el borde del campo de texto.
                ),
                prefixIcon: const Icon(Icons.lock), // Icono al inicio del campo de texto.
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye), // Icono al final del campo de texto.
                  onPressed: () {}, // Acción al presionar el icono (actualmente no hace nada).
                ),
              ),
            ),
            const SizedBox(height: 20), // Espacio antes del botón.
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Color de fondo del botón.
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 12.0,
                  ), // Espaciado interno del botón.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Bordes redondeados para el botón.
                  ),
                ),
                onPressed: () {
                  final username = _usernameController.text; // Obtiene el texto del campo de nombre de usuario.
                  final password = _passwordController.text; // Obtiene el texto del campo de contraseña.
                  ref.read(loginProvider.notifier).login(username, password); // Llama al método login del proveedor.
                },
                child: const Text('Login'), // Texto del botón.
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose(); // Libera el controlador del nombre de usuario.
    _passwordController.dispose(); // Libera el controlador de la contraseña.
    super.dispose();
  }
}
