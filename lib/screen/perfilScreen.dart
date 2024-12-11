import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/userServices.dart';
import 'package:flutter_application_1/controllers/userController.dart'; // Controlador para crear el post
import 'configurationScreen.dart'; // Importamos la nueva pantalla de configuración

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  String? _username;
  String? _email;

  final UserService userService = Get.put(UserService());
  final UserController userController = Get.put(UserController());  // Controlador para crear post

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Cargar los datos del usuario desde SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
      _email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF89AFAF), // El mismo color que hemos usado
      ),
      body: Center( // Centra el contenido en la pantalla
        child: SingleChildScrollView( // Asegura que el contenido sea desplazable si es necesario
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
              crossAxisAlignment: CrossAxisAlignment.center, // Centra los elementos horizontalmente
              children: [
                CircleAvatar(
                  radius: 80, // Tamaño del avatar
                  backgroundColor: Colors.grey[300], // Color de fondo del avatar
                  child: Icon(
                    Icons.person, // El ícono de Flutter que representa un perfil
                    size: 80, // Tamaño del ícono
                    color: Colors.white, // Color del ícono
                  ),
                ),
                const SizedBox(height: 20),
                // Nombre del usuario, si está disponible
                Text(
                  _username ?? 'Nombre del Usuario', // Usa el nombre del usuario desde SharedPreferences
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF89AFAF), // El mismo color que hemos usado
                  ),
                ),
                const SizedBox(height: 10),
                
                // Correo electrónico, si está disponible
                Text(
                  _email ?? 'usuario@example.com', // Usa el correo desde SharedPreferences
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Botones debajo de la foto de perfil
                _buildProfileButton(context, 'Configuración'),
                const SizedBox(height: 10),
                _buildProfileButton(context, 'Mis Posts'),
                const SizedBox(height: 10),
                _buildProfileButton(context, 'Cerrar Sesión'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para construir los botones con un estilo consistente
  Widget _buildProfileButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(context, text),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF89AFAF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        minimumSize: Size(double.infinity, 50), // Hacer el botón más grande
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Ruta para cada botón de la pantalla de perfil
  void _onButtonPressed(BuildContext context, String route) {
    if (route == 'Cerrar Sesión') {
      _logOut(context);
    } else if (route == 'Configuración') {
      // Navegar a la pantalla de configuración
      Get.to(() => ConfiguracionScreen());
    } else {
      print('Navegando a $route');
    }
  }

  // Método para cerrar sesión
  void _logOut(BuildContext context) async {
    try {
      // Llamar al método de logOut desde UserService
      await userService.logOut();
      Get.snackbar('Éxito', 'Has cerrado sesión correctamente');

      // Redirigir al usuario a la pantalla de inicio de sesión
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Hubo un problema al cerrar sesión');
    }
  }
}
