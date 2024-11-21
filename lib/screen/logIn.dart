import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/userController.dart';

class LogInPage extends StatelessWidget {
  // Inyectar el controlador para que esté disponible en esta página
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userController.usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: userController.passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 16),

            // Mostrar CircularProgressIndicator o el botón, según el estado de carga
            Obx(() {
              if (userController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: () {
                    userController.logIn();
                  },
                  child: Text('Iniciar Sesión'),
                );
              }
            }),

            // Mostrar mensaje de error si existe
            Obx(() {
              if (userController.errorMessage.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    userController.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return Container();
              }
            }),

            SizedBox(height: 16),

            // Botón para navegar a la página de registro
            ElevatedButton(
              onPressed: () => Get.toNamed('/register'),
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
