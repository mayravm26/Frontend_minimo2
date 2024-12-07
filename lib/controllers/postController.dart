//import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/services/postServices.dart';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';

class PostController extends GetxController {
  final PostService postService = Get.put(PostService());
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var postType = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var selectedImagePath = ''.obs; // Path local de la imagen seleccionada
  var uploadedImageUrl = ''.obs; // URL de la imagen subida a Cloudinary
  Uint8List? selectedImage;
  // Seleccionar imagen desde el dispositivo
  Future<void> pickImage() async {
    Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
    if (imageBytes != null) {
      selectedImage = imageBytes;
      update(); // Actualiza la UI
    }
  }

  // Subir imagen a Cloudinary
  Future<void> uploadImageToCloudinary() async {
    if (selectedImagePath.isEmpty) {
      Get.snackbar('Error', 'Selecciona una imagen primero',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isLoading.value = true;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/<tu_nombre_cloudinary>/image/upload'),
      );
      request.fields['upload_preset'] = '<tu_upload_preset>';
      request.files.add(await http.MultipartFile.fromPath('file', selectedImagePath.value));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var data = jsonDecode(responseData);
        uploadedImageUrl.value = data['secure_url'];
        Get.snackbar('Éxito', 'Imagen subida correctamente');
      } else {
        Get.snackbar('Error', 'Falló la subida de la imagen',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al subir la imagen: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Método para crear un nuevo post
  void createPost() async {
    if (ownerController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        postType.value.isEmpty ||
        uploadedImageUrl.isEmpty) { // Asegúrate de que la imagen haya sido subida
      Get.snackbar('Error', 'Todos los campos son obligatorios',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final newPost = PostModel.fromJson({
      'author': ownerController.text,
      'postType': postType.value,
      'content': descriptionController.text,
      'image': uploadedImageUrl.value, // URL de la imagen en Cloudinary
      'postDate': DateTime.now().toIso8601String(),
    });

    isLoading.value = true;
    errorMessage.value = '';
    try {
      final statusCode = await postService.createPost(newPost);
      if (statusCode == 201) {
        Get.snackbar('Éxito', 'Post creado con éxito');
        Get.toNamed('/posts');
      } else {
        errorMessage.value = 'Error al crear el post';
      }
    } catch (e) {
      errorMessage.value = 'Error: No se pudo conectar con la API';
    } finally {
      isLoading.value = false;
    }
  }
}