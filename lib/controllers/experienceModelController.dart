/*import 'package:get/get.dart';
import 'package:flutter_application_1/models/post.dart';

class PostModelController extends GetxController {
  // Usamos PostModel en lugar de ExperienceModel
  final post = PostModel(
    id: '',  // Inicializamos el id como vacío, ya que lo recibiremos después
    author: 'Autor desconocido',
    postType: 'Tipo desconocido',
    content: 'Sin contenido',
    image: null,
    postDate: null,
  ).obs;

  // Método para actualizar los datos del post (PostModel)
  void setPost(String id, String author, String postType, String content, {String? image, DateTime? postDate}) {
    post.update((val) {
      if (val != null) {
        val.setPost(  // Ahora pasamos correctamente los parámetros
          author: author,
          postType: postType,
          content: content,
          image: image,
          postDate: postDate,
        );
        val._id = id;  // Asignamos el id recibido
      }
    });
  }
}
*/