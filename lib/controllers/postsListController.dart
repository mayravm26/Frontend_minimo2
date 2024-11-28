import 'package:get/get.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/services/postServices.dart';

class PostsListController extends GetxController {
  var isLoading = true.obs;
  var postList = <PostModel>[].obs;
  final PostService postService = PostService();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();  // Llamada a fetchExperiences al inicializar el controlador
  }

  // Método para obtener las experiencias
  Future<void> fetchPosts() async {
    try {
      isLoading(true);  // Establecemos el estado de carga a true
      var post = await postService.getPosts();
      
      if (post != null) {
        postList.assignAll(post); // Asignamos las experiencias a la lista
      }
    } catch (e) {
      print("Error fetching experiences: $e");
    } finally {
      isLoading(false);  // Establecemos el estado de carga a false una vez que termine
    }
  }

  // Método para editar una experiencia
  Future<void> editPost(String id, PostModel updatedPost) async {  // Cambié a PostModel
    try {
      isLoading(true);  // Establecemos el estado de carga a true
      var statusCode = await postService.editPost(updatedPost, id);
      if (statusCode == 201) {
        Get.snackbar('Éxito', 'Post actualizado con éxito');
        await fetchPosts();  // Recargamos la lista de experiencias después de editar
      } else {
        Get.snackbar('Error', 'Error al actualizar la experiencia');
      }
    } catch (e) {
      print("Error editing experience: $e");
    } finally {
      isLoading(false);  // Establecemos el estado de carga a false una vez que termine
    }
  }

// Método para eliminar un post utilizando el id
Future<void> postToDelete(String postId) async {
  try {
    isLoading(true);  // Establecemos el estado de carga a true

    // Buscamos el post en la lista local utilizando el id
    var postToDelete = postList.firstWhere(
      (post) => post.id == postId,  // Usamos 'id' para buscar el post
      //orElse: () => null,  // Si no se encuentra, retornamos null
    );

    if (postToDelete != null) {
      // Llamada al servicio para eliminar el post utilizando el id
      var statusCode = await postService.deletePostById(postToDelete.id);  // Usamos 'id' para eliminar

      if (statusCode == 200) {  // Aseguramos que el código de éxito sea 200
        Get.snackbar('Éxito', 'Post eliminado con éxito');
        fetchPosts();  // Recargamos la lista de posts después de eliminar
      } else {
        Get.snackbar('Error', 'Error al eliminar el post');
      }
    } else {
      Get.snackbar('Error', 'No se encontró el post a eliminar');
    }
  } catch (e) {
    print("Error deleting post: $e");
  } finally {
    isLoading(false);  // Establecemos el estado de carga a false una vez que termine
  }
}


}
