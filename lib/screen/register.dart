import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/registerController.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: registerController.usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: registerController.nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: registerController.emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: registerController.passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            
            SizedBox(height: 16),
            
            // Mostrar CircularProgressIndicator o botón de registro según el estado de carga
            Obx(() {
              if (registerController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: registerController.signUp,
                  child: Text('Registrarse'),
                );
              }
            }),

            // Mostrar mensaje de error si existe
            Obx(() {
              if (registerController.errorMessage.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    registerController.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return Container();
              }
            }),

            SizedBox(height: 16),
            
            // Botón para volver a la página de inicio de sesión
            ElevatedButton(
              onPressed: () => Get.toNamed('/login'),
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

