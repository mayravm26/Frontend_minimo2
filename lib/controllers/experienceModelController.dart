import 'package:get/get.dart';
import 'package:flutter_application_1/models/experienceModel.dart';

class ExperienceModelController extends GetxController {
  final experience = ExperienceModel(
    owner: 'Propietario desconocido',
    participants: 'Sin Participantes',
    description: 'Sin descripcion',
  ).obs;

  // Método para actualizar los datos de la experiencia
  void setExperience(String owner, String participants, String description) {
    experience.update((val) {
      if (val != null) {
        val.setExperience(owner, participants, description);
      }
    });
  }
}
