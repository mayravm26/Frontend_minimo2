import 'package:flutter/material.dart';

class ExperienceModel with ChangeNotifier {
  String _owner;
  String _participants;
  String _description;

  // Constructor
  ExperienceModel({required String owner, required String participants, required String description})
      : _owner = owner,
        _participants = participants,
        _description = description;

  // Getters
  String get owner => _owner;
  String get participants => _participants;
  String get description => _description;

  // Método para actualizar el usuario
  void setExperience(String owner, String participants, String description) {
    _owner = owner;
    _participants = participants;
    _description = description;
    notifyListeners();
  }

  // Método fromJson para crear una instancia de UserModel desde un Map
  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      owner: json['owner'] ?? 'Propietario desconocido',
      participants: json['participants'] ?? 'Sin Participantes',
      description: json['description'] ?? 'Sin descripcion',
    );
  }

  // Método toJson para convertir una instancia de UserModel en un Map
  Map<String, dynamic> toJson() {
    return {
      'name': _owner,
      'mail': _participants,
      'comment': _description,
    };
  }
}
