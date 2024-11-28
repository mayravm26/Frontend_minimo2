class PostModel {
  final String id;
  final String author;
  final String postType;
  final String content;
  final String? image;
  final DateTime? postDate;

  // Constructor
  PostModel({
    required this.id,  // Lo hacemos obligatorio aquí, pero solo porque lo vamos a recibir de la respuesta
    required this.author,
    required this.postType,
    required this.content,
    this.image,
    this.postDate,
  });

  // Método fromJson para mapear los datos del backend
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'] ?? 'id no encontrado',  // MongoDB usa '_id' por defecto
      author: json['author'] ?? 'Autor desconocido',
      postType: json['postType'] ?? 'Tipo desconocido',
      content: json['content'] ?? 'Sin contenido',
      image: json['image'],
      postDate: json['postDate'] != null
          ? DateTime.parse(json['postDate'])
          : null,
    );
  }


  // Método toJson para enviar los datos de vuelta al backend si es necesario
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'postType': postType,
      'content': content,
      'image': image,
      'postDate': postDate?.toIso8601String(),
    };
  }
}
