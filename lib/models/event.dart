class EventModel {
  final String name;
  final String description;
  final DateTime date;
  final String creator;

  EventModel({
    required this.name,
    required this.description,
    required this.date,
    required this.creator,
  });

  // Mètode per crear una instància de EventModel des de JSON
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      creator: json['creator'],
    );
  }
}
