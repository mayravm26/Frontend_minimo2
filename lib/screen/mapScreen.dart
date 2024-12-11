import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart'; 
import 'package:flutter_application_1/controllers/ubiController.dart'; // El controlador que tens

class MapScreen extends StatelessWidget {
  final UbiController ubiController = Get.put(UbiController()); // Obtenim el controlador
  //final MapController mapController = MapController(); // Controlador per controlar el mapa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: FlutterMap(
        //mapController: mapController,
        options: MapOptions(
          center: LatLng(41.382395521312176, 2.1567611541534366), // Coordenades de Barcelona
          zoom: 13.0, // Nivell de zoom inicial
          //maxZoom: 18.0, // Màxim nivell de zoom
          //minZoom: 5.0,  // Mínim nivell de zoom
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(41.382395521312176, 2.1567611541534366), // Coordenades de Barcelona
                builder: (ctx) => Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30.0,
                ),
              ),
              Marker(
                point: LatLng(39.884440544020734, 4.266759450372821), // Una altra ubicació (exemple: Maó)
                builder: (ctx) => Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 30.0,
                ),
              ),
              // Aquí pots afegir més marcadors si és necessari
            ],
          ),
        ],
      ),
    );
  }
}

