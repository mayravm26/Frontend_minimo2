import 'package:flutter_application_1/models/event.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventService {
  final String baseUrl = 'http://127.0.0.1:3000/api'; // La teva URL de l'API

  // Mètode per obtenir tots els esdeveniments
  Future<List<EventModel>> getAllEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((event) => EventModel.fromJson(event)).toList();
    } else {
      throw Exception('Error al carregar els esdeveniments');
    }
  }
}
