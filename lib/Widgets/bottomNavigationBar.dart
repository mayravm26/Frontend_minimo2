import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/navigationController.dart';

class BottomNavScaffold extends StatelessWidget {
  final Widget child;
  final NavigationController navController = Get.put(NavigationController());

  BottomNavScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: navController.navigateTo,
          selectedItemColor: const Color(0xFF89AFAF), // Verde claro (estética del Home)
          unselectedItemColor: const Color(0xFF4D6F6F), // Verde oscuro/gris para elementos no seleccionados
          backgroundColor: const Color(0xFFE0F7FA), // Fondo azul claro (coherente con Home)
          elevation: 5, // Sombra suave para el diseño
          type: BottomNavigationBarType.fixed, // Fija para mantener los elementos en su lugar
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Usuarios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_activity),
              label: 'Experiencias',
            ),
          ],
        ),
      ),
    );
  }
}