import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/userController.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Necesario para lanzar URL (como un teléfono)

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller); // Animación más sutil
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Función para abrir una llamada de emergencia
  _contactEmergency() async {
    const emergencyPhoneNumber = 'tel:6399845501'; // Número de teléfono de emergencia (puedes cambiarlo)
    if (await canLaunch(emergencyPhoneNumber)) {
      await launch(emergencyPhoneNumber);
    } else {
      throw 'No se puede realizar la llamada';
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF89AFAF), // Color de la AppBar
      ),
      body: Container(
        color: const Color(0xFFE0F7FA), // Fondo de la pantalla
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 300), // Reducido el margen para hacerlo más estrecho
            decoration: BoxDecoration(
              color: const Color.fromARGB(194, 162, 204, 204), // Fondo del contenedor
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Benvinguda a STAYCLOSE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Color del texto
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ens alegra tenir-te aquí. Gaudeix d\'aquesta aplicació i mantén la teva comunitat segura.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70, // Color de la frase secundaria
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Imagen animada
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: Image.asset(
                        'assets/icons/logo.png', // Ruta de la imagen
                        height: 80, // Tamaño de la imagen reducido
                        width: 80,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                
                // Sección de Próximos Eventos (desplegable)
                const Text(
                  'Próximos Eventos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 10),
                // Desplegable de eventos
                ExpansionTile(
                  title: const Text(
                    'Ver eventos próximos',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  children: List.generate(2, (index) {
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        title: Text('Evento ${index + 1}'),
                        subtitle: Text('Fecha y hora del evento'),
                        trailing: Icon(Icons.event),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                
                // Botón redondeado con ícono de SOS
                ElevatedButton(
                  onPressed: _contactEmergency,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(214, 255, 67, 67),
                    shape: CircleBorder(), // Hace el botón redondeado
                    padding: const EdgeInsets.all(20), // Padding para hacerlo grande
                  ),
                  child: const Icon(
                    Icons.sos, // Ícono de SOS
                    color: Colors.white, // Color blanco para el ícono
                    size: 40, // Tamaño adecuado para el ícono
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}