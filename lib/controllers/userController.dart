import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/userServices.dart';
import 'package:flutter_application_1/models/user.dart';

class UserController extends GetxController {
  final UserService userService = Get.put(UserService());

  // Controladores de texto para la UI
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variables reactivas para la UI
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isPasswordVisible = false.obs;
  
  // Usando Rxn para que sea nullable (inicialmente vacío)
  var user = Rxn<UserModel>();

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void logIn() async {
    // Validación de campos
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Campos vacíos',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    print('estoy en el login de usercontroller');

    final logIn = (
      username: usernameController.text,
      password: passwordController.text,
    );

    // Iniciar el proceso de inicio de sesión
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Llamada al servicio para iniciar sesión
      final responseData = await userService.logIn(logIn);

      print('el response data es:${ responseData}');

      if (responseData != null) {
        // Manejo de respuesta exitosa
        Get.snackbar('Éxito', 'Inicio de sesión exitoso');
        // Ahora que el login fue exitoso, obtenemos los datos del usuario
        await getUserData(usernameController.text); // Llamamos a getUserData para obtener los datos del usuario
        Text('Bienvenido, ${user.value?.name ?? "Cargando..."}');
        Get.toNamed('/home');
      } else {
        errorMessage.value = 'Usuario o contraseña incorrectos';
      }
    } catch (e) {
      errorMessage.value = 'Error: No se pudo conectar con la API';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUserData(String username) async {
  try {
    // Llamamos al servicio para obtener los datos del usuario por su username
    var response = await userService.getUserByUsername(username);
    
    if (response != null) {
      // Convertimos el Map<String, dynamic> a UserModel
      user.value = UserModel.fromJson(response);  // Aquí convertimos el Map a UserModel
      print('Usuario obtenido: ${user.value}');
    } else {
      Get.snackbar('Error', 'No se pudo obtener los datos del usuario', snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    print('Error al obtener los datos del usuario: $e');
    Get.snackbar('Error', 'No se pudo conectar con el servidor', snackPosition: SnackPosition.BOTTOM);
  }
}

}
