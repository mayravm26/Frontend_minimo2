class UbiModel {
  final String name;
  final String horari;
  final String tipo;
  final String address;
  final Map<String, double> ubication;
  final String comentari;

  UbiModel({
    required this.name,
    required this.horari,
    required this.tipo,
    required this.address,
    required this.ubication,
    required this.comentari,
  });

  // Mètode per crear una instància de UbiModel des de JSON
  factory UbiModel.fromJson(Map<String, dynamic> json) {
    return UbiModel(
      name: json['name'],
      horari: json['horari'],
      tipo: json['tipo'],
      address: json['address'],
      ubication: Map<String, double>.from(json['ubication']),
      comentari: json['comentari'],
    );
  }

  // Mètode toJson per enviar les dades al backend
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'horari': horari,
      'tipo': tipo,
      'address': address,
      'ubication': ubication,
      'comentari': comentari,
    };
  }
}
