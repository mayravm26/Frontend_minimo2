import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  // Ruta para cada botón de la pantalla de perfil
  void _onButtonPressed(BuildContext context, String route) {
    // Aquí puedes implementar la navegación a otras pantallas
    // Por ahora solo es un ejemplo con un mensaje de consola
    print('Navegando a $route');
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
                // Foto de perfil centrada
                CircleAvatar(
                  radius: 80, // Tamaño de la imagen
                  backgroundImage: NetworkImage(
                    'https://www.example.com/profile_image.jpg', // Aquí va la URL de la imagen del perfil
                  ),
                ),
                const SizedBox(height: 20),
                
                // Nombre del usuario
                const Text(
                  'Nombre del Usuario', // Aquí puedes poner el nombre del usuario dinámicamente
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF89AFAF), // El mismo color que hemos usado
                  ),
                ),
                const SizedBox(height: 10),
                
                // Correo electrónico o información adicional
                const Text(
                  'usuario@example.com', // Aquí puedes poner el correo dinámico
                  style: TextStyle(
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
}
