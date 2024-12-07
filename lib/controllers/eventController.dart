import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/event.dart';
import 'package:flutter_application_1/services/eventServices.dart';

class EventController extends GetxController {
  final eventService = EventService(); // Instanciem el servei d'esdeveniments
  var events = <EventModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Variables per gestionar el calendari
  var focusedDay = DateTime.now().obs; // El dia actual per centrar el calendari
  var selectedDay = DateTime.now().obs; // El dia seleccionat

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  // Mètode per obtenir els esdeveniments des del servei
  Future<void> fetchEvents() async {
    isLoading.value = true;
    try {
      final fetchedEvents = await eventService.getAllEvents(); // Obtenir tots els esdeveniments
      events.value = fetchedEvents;
    } catch (e) {
      errorMessage.value = 'Error al carregar els esdeveniments.';
    } finally {
      isLoading.value = false;
    }
  }

  // Mètode per obtenir els esdeveniments per a un dia en concret
  List<EventModel> getEventsForDay(DateTime day) {
    return events.where((event) {
      // Comprovem si la data de l'esdeveniment coincideix amb el dia seleccionat
      return event.date.year == day.year &&
          event.date.month == day.month &&
          event.date.day == day.day;
    }).toList();
  }

  // Mètode per gestionar la selecció d'un dia
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay; // Actualitzar el mes quan es selecciona un dia
  }
}
