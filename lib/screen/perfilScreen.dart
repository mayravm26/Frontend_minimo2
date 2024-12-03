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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            ElevatedButton(
              onPressed: () => _onButtonPressed(context, 'Configuración'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF89AFAF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Configuración'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _onButtonPressed(context, 'Mis Posts'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF89AFAF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Mis Posts'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _onButtonPressed(context, 'Cerrar Sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF89AFAF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
