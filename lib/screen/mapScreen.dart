import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_application_1/controllers/ubiController.dart'; // El controlador que tens

class MapScreen extends StatelessWidget {
  final UbiController ubiController = Get.put(UbiController()); // Obtenim el controlador

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: Obx(() {
        // Espera que les ubicacions siguin carregades
        if (ubiController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Si no hi ha ubicacions, mostra un missatge
        if (ubiController.ubis.isEmpty) {
          return Center(child: Text('No hi ha ubicacions disponibles'));
        }

        // Generem el mapa amb els markers
        return FlutterMap(
          options: MapOptions(
            center: LatLng(41.382395521312176, 2.1567611541534366), // Coordenades de Barcelona
            zoom: 13.0, // Nivell de zoom inicial
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: ubiController.ubis.map((ubi) {
                // Accedim a les coordenades
                final latitude = ubi.ubication['latitud'] ?? 41.382395521312176;
                final longitude = ubi.ubication['longitud'] ?? 2.1567611541534366;

                return Marker(
                  point: LatLng(latitude, longitude),
                  builder: (ctx) => Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30.0,
                  ),
                );
              }).toList(), // Convertim el resultat en una llista
            ),
          ],
        );
      }),
    );
  }
}


