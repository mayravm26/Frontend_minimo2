/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/models/userModel.dart';

class RegisterController extends GetxController {
  final UserService userService = Get.put(UserService());

  final TextEditingController nameController = TextEditingController();
   final TextEditingController passwordController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  

  void signUp() async {
    // Validación de campos vacíos
    if (nameController.text.isEmpty || passwordController.text.isEmpty || mailController.text.isEmpty || commentController.text.isEmpty) {
      errorMessage.value = 'Campos vacíos';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validación de formato de correo electrónico
    if (!GetUtils.isEmail(mailController.text)) {
      errorMessage.value = 'Correo electrónico no válido';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      UserModel newUser = UserModel(
        name: nameController.text,
        password: passwordController.text,
        mail: mailController.text,
        comment: commentController.text
      );

      final response = await userService.createUser(newUser);

      if (response != null && response== 201) {
        Get.snackbar('Éxito', 'Usuario creado exitosamente');
        Get.toNamed('/login');
      } else {
        errorMessage.value = 'Error: Este E-Mail o Teléfono ya están en uso';
        Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      errorMessage.value = 'Error al registrar usuario';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}*/
