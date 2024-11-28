import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/services/postServices.dart';

class PostController extends GetxController {
  final PostService postService = Get.put(PostService());  // Instanciamos el servicio de post
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Usamos RxString para postType
  var postType = ''.obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Método para crear una nueva experiencia
  void createPost() async {
    // Verificamos que todos los campos estén completos
    if (ownerController.text.isEmpty ||
        participantsController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        postType.value.isEmpty) {  // Verificamos que el postType no esté vacío
      Get.snackbar('Error', 'Todos los campos son obligatorios',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Creamos la nueva experiencia (nuevo post)
    final newPost = PostModel.fromJson({
      'author': ownerController.text,  // Asumimos que "owner" es "author" en PostModel
      'postType': postType.value,  // Asignar el tipo de experiencia si es necesario
      'content': descriptionController.text,
      'image': null, // Si no tienes una imagen, puedes poner null
      'postDate': DateTime.now().toIso8601String(), // Fecha actual si se requiere
    });

    isLoading.value = true;
    errorMessage.value = '';  // Reiniciamos el mensaje de error
    try {
      // Llamamos al servicio para crear la experiencia
      final statusCode = await postService.createPost(newPost);  // Llamamos al método desde la instancia
      if (statusCode == 201) {
        Get.snackbar('Éxito', 'Experiencia creada con éxito');
        Get.toNamed('/experiencies');  // Redirigimos a la lista de experiencias
      } else {
        errorMessage.value = 'Error al crear la experiencia';  // En caso de error
      }
    } catch (e) {
      errorMessage.value = 'Error: No se pudo conectar con la API';  // Error de conexión
    } finally {
      isLoading.value = false;  // Indicamos que la carga ha finalizado
    }
  }
}
