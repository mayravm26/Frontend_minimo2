/*//import 'package:flutter_application_1/services/userServices.dart';
//import 'package:flutter_application_1/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilController {
  //final UserService _userService = UserService();

  // Recuperar el ID del usuario desde SharedPreferences
  Future<String?> getUserIdFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  // Recuperar el username del usuario desde SharedPreferences
  Future<String?> getUsernameFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  // Recuperar el email del usuario desde SharedPreferences
  Future<String?> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // Obtener los datos del usuario desde la API
  /*Future<UserModel?> getUserProfile() async {
    String? userId = await getUserIdFromToken();
    print(userId);
    if (userId != null) {
      return await _userService.getUserById(userId);
    }
    return null;
  }*/
}*/