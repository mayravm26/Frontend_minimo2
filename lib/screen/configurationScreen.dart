import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Para acceder a SharedPreferences
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/userController.dart'; // Importa el controlador
import 'package:flutter_application_1/models/user.dart'; // Asegúrate de importar el modelo
import 'package:flutter_application_1/services/userServices.dart'; // Importar el servicio

class ConfiguracionScreen extends StatefulWidget {
  @override
  _ConfiguracionScreenState createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  String? _userId; // Para almacenar la ID del usuario
  String? _username;
  String? _email;

  final UserController userController = Get.find<UserController>();  // Obtén el controlador
  final UserService userService = Get.find<UserService>(); // Instancia del servicio
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    super.initState();  
    _loadUserData(); // Cargar los datos del usuario, incluida la ID
  }

  // Cargar la ID del usuario desde SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('user_id'); // Asumiendo que 'userId' está almacenado en SharedPreferences
      print ("id $_userId");
    });

    if (_userId != null) {
      await _fetchUserData(); // Obtener los datos completos del usuario si la ID está disponible
    }
  }

  // Obtener los datos completos del usuario con su ID
  Future<void> _fetchUserData() async {
    await userController.fetchUser(_userId!); // Obtiene el usuario desde la API
    if (userController.user.value != null) {
      setState(() {
        _usernameController.text = userController.user.value!.username;
        _nameController.text = userController.user.value!.name;
        _emailController.text = userController.user.value!.email;
        _passController.text = userController.user.value!.password;
      });
    } else {
      Get.snackbar('Error', 'No se pudo obtener los datos del usuario');
    }
  }

  // Función para guardar la configuración
 void _saveConfiguration() async {
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

    // Guardar los valores en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
    await prefs.setString('email', newEmail);

    // Actualizar la pantalla principal
    setState(() {
      _username = newUsername;
      _email = newEmail;
    });

    // Mostrar confirmación y cerrar el diálogo
    Get.snackbar('Éxito', 'Configuración guardada correctamente');
    Navigator.pop(context);
  }
}


// Método para eliminar el usuario
Future<void> _deleteUser() async {
  if (_userId != null) {
    int success = await userService.deleteUser(_userId!);
    print("success: $success");
    if (success == 200) {
      Get.snackbar('Éxito', 'Usuario eliminado correctamente');

      // Eliminar los datos locales almacenados en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id'); // Elimina el ID de usuario
      await prefs.remove('user_data'); // Elimina otros datos del usuario si los tienes almacenados
      await userService.logOut();
      // Redirigir a la pantalla de inicio de sesión después de la eliminación
      Get.offAllNamed('/login');
    } else {
      Get.snackbar('Error', 'No se pudo eliminar el usuario');
    }
  } else {
    Get.snackbar('Error', 'ID de usuario no disponible');
  }
}

  // Método para mostrar el diálogo de confirmación
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar tu cuenta? Esta acción es irreversible.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin hacer nada
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                _deleteUser(); // Eliminar el usuario
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showDeleteConfirmationDialog, // Mostrar diálogo de confirmación para eliminar
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Rojo para indicar acción destructiva
              ),
              child: const Text('Eliminar Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
