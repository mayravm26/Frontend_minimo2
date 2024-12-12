class UbiModel {
  final String name;
  final String horari;
  final String tipo;
  final Map<String, double> ubication;
  final String address;
  final String comentari;

  UbiModel({
    required this.name,
    required this.horari,
    required this.tipo,
    required this.ubication,
    required this.address,
    required this.comentari,
  });

  // Mètode per crear una instància de UbiModel des de JSON
  factory UbiModel.fromJson(Map<String, dynamic> json) {
    return UbiModel(
      name: json['name'],
      horari: json['horari'],
      tipo: json['tipo'],
      ubication: Map<String, double>.from(json['ubication']),
      address: json['address'],
      comentari: json['comentari'],
    );
  }

  // Mètode toJson per enviar les dades al backend
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'horari': horari,
      'tipo': tipo,
      'ubication': ubication,
      'address': address,
      'comentari': comentari,
    };
  }
}
