import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/userController.dart'; // Importa el controlador
import 'package:flutter_application_1/models/user.dart'; // Asegúrate de importar el modelo
import 'package:shared_preferences/shared_preferences.dart'; // Para acceder a SharedPreferences

class ConfiguracionScreen extends StatefulWidget {
  @override
  _ConfiguracionScreenState createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  final UserController userController = Get.find<UserController>();  // Obtén el controlador
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  String? _userId; // Para almacenar la ID del usuario

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Cargar los datos del usuario, incluida la ID

    // Inicializar los campos con los valores actuales del usuario
    if (userController.user.value != null) {
      _usernameController.text = userController.user.value!.username;
      _nameController.text = userController.user.value!.name;
      _emailController.text = userController.user.value!.email;
      _passController.text = userController.user.value!.password;
    }
  }

  // Cargar la ID del usuario desde SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userId'); // Asumiendo que 'userId' está almacenado en SharedPreferences
    });
  }

  // Función para guardar la configuración
  void _saveConfiguration() {
    String newUsername = _usernameController.text.trim();
    String newName = _nameController.text.trim();
    String newEmail = _emailController.text.trim();
    String newPassword = _passController.text.trim();

    if (newUsername.isEmpty || newEmail.isEmpty || newPassword.isEmpty) {
      Get.snackbar('Error', 'Los campos no pueden estar vacíos');
    } else if (_userId == null) {
      Get.snackbar('Error', 'No se pudo obtener la ID del usuario');
    } else {
      // Crear un nuevo objeto UserModel con los datos actualizados
      UserModel updatedUser = UserModel(
        username: newUsername.isNotEmpty ? newUsername : userController.user.value!.username,
        name: newName.isNotEmpty ? newName : userController.user.value!.name,
        email: newEmail.isNotEmpty ? newEmail : userController.user.value!.email,
        password: newPassword.isNotEmpty ? newPassword : userController.user.value!.password,
        actualUbication: userController.user.value!.actualUbication, // Mantener los valores fijos
        inHome: userController.user.value!.inHome,
        admin: userController.user.value!.admin,
        disabled: userController.user.value!.disabled,
      );

      // Llamar al método editUser para actualizar el usuario
      userController.editUser(updatedUser, _userId!);

      // Volver a la pantalla anterior
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración de Perfil"),
        backgroundColor: const Color(0xFF89AFAF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre Completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Para ocultar la contraseña
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveConfiguration, // Guardar configuración
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF89AFAF),
              ),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
