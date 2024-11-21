import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:flutter_application_1/services/experience.dart';

class ExperienceController extends GetxController {
  final ExperienceService experienceService = Get.put(ExperienceService());

  // Controladores de texto para la UI
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Variables reactivas para la UI
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Variables reactivas para los errores específicos de cada campo
  var ownerError = ''.obs;
  var participantsError = ''.obs;
  var descriptionError = ''.obs;

  // Método para crear una nueva experiencia
  void createExperience() async {
    // Validación de campos
    bool hasError = false;

    if (ownerController.text.isEmpty) {
      ownerError.value = 'El campo propietario es obligatorio';
      hasError = true;
    } else {
      ownerError.value = '';
    }

    if (participantsController.text.isEmpty) {
      participantsError.value = 'El campo participantes es obligatorio';
      hasError = true;
    } else {
      participantsError.value = '';
    }

    if (descriptionController.text.isEmpty) {
      descriptionError.value = 'El campo descripción es obligatorio';
      hasError = true;
    } else {
      descriptionError.value = '';
    }

    if (hasError) {
      Get.snackbar('Error', 'Por favor, corrige los errores',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Crear la instancia de ExperienceModel
    final newExperience = ExperienceModel(
      owner: ownerController.text,
      participants: participantsController.text,
      description: descriptionController.text,
    );

    // Iniciar el proceso de creación
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Llamada al servicio para crear la experiencia
      final statusCode = await experienceService.createExperience(newExperience);

      if (statusCode == 201) {
        // Manejo de respuesta exitosa
        Get.snackbar('Éxito', 'Experiencia creada con éxito');
        Get.toNamed('/experiencies');
      } else {
        errorMessage.value = 'Error al crear la experiencia';
      }
    } catch (e) {
      errorMessage.value = 'Error: No se pudo conectar con la API';
    } finally {
      isLoading.value = false;
    }
  }
}
