import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_application_1/controllers/ubiController.dart';
import 'package:flutter_application_1/models/ubi.dart';

class MapScreen extends StatelessWidget {
  final UbiController ubiController =
      Get.put(UbiController()); // Obtenim el controlador
  RxList<UbiModel> selectedUbications =
      RxList<UbiModel>([]); // Llista d'ubicacions seleccionades

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        backgroundColor: const Color(0xFF89AFAF),
      ),
      body: Obx(() {
        // Espera que les ubicacions siguin carregades
        if (ubiController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Si no hi ha ubicacions, mostra un missatge
        if (ubiController.ubis.isEmpty) {
          return const Center(child: Text('No hi ha ubicacions disponibles'));
        }

        return Stack(
          children: [
            // Mapa
            FlutterMap(
              options: MapOptions(
                center: LatLng(41.382395521312176,
                    2.1567611541534366), // Coordenades de Barcelona
                zoom: 13.0, // Nivell de zoom inicial
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: ubiController.ubis.map((ubi) {
                    // Accedim a les coordenades
                    final latitude =
                        ubi.ubication['latitud'] ?? 41.382395521312176;
                    final longitude =
                        ubi.ubication['longitud'] ?? 2.1567611541534366;

                    return Marker(
                      point: LatLng(latitude, longitude),
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          if (!selectedUbications.contains(ubi)) {
                            selectedUbications.add(ubi); // Afegim a la llista
                          }
                        },
                        child: Icon(
                          Icons.place, // Icònica més estètica
                          color: const Color.fromARGB(255, 133, 160, 160),
                          size: 35.0, // Mida del marcador
                        ),
                      ),
                    );
                  }).toList(), // Convertim el resultat en una llista
                ),
              ],
            ),

            // Mostra les caixes per a les ubicacions seleccionades
            ...selectedUbications.map((ubi) {
              int index = selectedUbications.indexOf(ubi);
              return Positioned(
                right: 16.0,
                top: 16.0 + index * 160.0, // Espai suficient entre caixes
                child: Container(
                  width: 220.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB2D5D5),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6.0,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Detalls',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              selectedUbications
                                  .remove(ubi); // Elimina la caixa
                            },
                            child: const Icon(
                              Icons.close,
                              size: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Nom: ${ubi.name}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tipus: ${ubi.tipo}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Horari: ${ubi.horari}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        'Adreça: ${ubi.address}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Comentari: ${ubi.comentari}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        );
      }),
    );
  }
}
