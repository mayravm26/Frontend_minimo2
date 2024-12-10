class EventModel {
  final String name;
  final String description;
  final DateTime eventDate;
  final String creator;

  EventModel({
    required this.name,
    required this.description,
    required this.eventDate,
    required this.creator,
  });

  // Mètode per crear una instància de EventModel des de JSON
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      description: json['description'],
      eventDate: DateTime.parse(json['date']),
      creator: json['creator'],
    );
  }

  // Método toJson para enviar los datos de vuelta al backend si es necesario
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'eventDate': eventDate?.toIso8601String(),
      'creator': creator
    };
  }
}
