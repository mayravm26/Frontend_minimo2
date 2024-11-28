import 'package:get/get.dart';
import 'package:flutter_application_1/models/user.dart';

class UserModelController extends GetxController {
  final user = UserModel(
    username: 'Username desconocido',
    name: 'Usuario desconocido',
    email: 'No especificado',
    password: 'Sin contraseña',
    actualUbication: [],
    inHome: true,
    admin: true,
    disabled: false,
  ).obs;

  // Método para actualizar los datos del usuario
  void setUser(String username, String name, String email, String password, List<dynamic> actualUbication, bool inHome, bool admin, bool disabled ) {
    user.update((val) {
      if (val != null) {
        val.setUser(username, name, email, password, actualUbication, inHome, admin, disabled);
      }
    });
  }
}