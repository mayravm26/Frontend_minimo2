import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/postsListController.dart';  // Controlador para la lista de posts
import 'package:flutter_application_1/controllers/postController.dart';  // Controlador para crear el post
import 'package:flutter_application_1/Widgets/postCard.dart';
import 'package:get/get.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostsListController postsListController = Get.put(PostsListController());  // Controlador para lista de posts
  final PostController postController = Get.put(PostController());  // Controlador para crear post

  @override
  void initState() {
    super.initState();
    postsListController.fetchPosts();  // Cargar los posts al inicio
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Foro de Posts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF89AFAF),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6, // Ancho del contenedor
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {  // Usamos Obx para actualizar la UI con GetX
            if (postsListController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());  // Indicador de carga
            } else if (postsListController.postList.isEmpty) {
              return const Center(
                child: Text(
                  "No hay posts disponibles",
                  style: TextStyle(fontSize: 16, color: Color(0xFF89AFAF)),
                ),
              );  // Mensaje si no hay posts
            } else {
              // Si hay posts, los mostramos
              return ListView.builder(
                itemCount: postsListController.postList.length,  // Cantidad de posts
                itemBuilder: (context, index) {
                  final post = postsListController.postList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PostCard(post: post),  // Widget para mostrar cada post
                  );
                },
              );
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPostDialog(context);  // Mostrar el cuadro de diálogo para agregar un post
        },
        backgroundColor: const Color(0xFF89AFAF),  // Color del botón flotante
        child: const Icon(Icons.add),  // Icono de suma
      ),
    );
  }

  // Mostrar el cuadro de diálogo para crear un nuevo post
  void _showAddPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),  // Bordes redondeados
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,  // Asegura que el contenido no ocupe más espacio del necesario
              children: [
                const Text(
                  'Nuevo Post',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF89AFAF),
                  ),
                ),
                const SizedBox(height: 20),  // Espacio entre el título y los campos
                // Campo para el autor del post
                TextField(
                  controller: postController.ownerController,  // Usamos el controlador de owner
                  decoration: InputDecoration(
                    labelText: 'Autor',
                    labelStyle: TextStyle(color: Color(0xFF89AFAF)),
                    fillColor: Colors.grey[100],  // Fondo gris claro
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Campo para la descripción del post
                TextField(
                  controller: postController.descriptionController,  // Usamos el controlador de description
                  decoration: InputDecoration(
                    labelText: 'Contenido',
                    labelStyle: TextStyle(color: Color(0xFF89AFAF)),
                    fillColor: Colors.grey[100],  // Fondo gris claro
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                // Dropdown para seleccionar el tipo de post
                Obx(() {
                  return DropdownButton<String>(
                    value: postController.postType.value.isEmpty ? null : postController.postType.value,
                    hint: const Text(
                      'Selecciona el tipo de post',
                      style: TextStyle(color: Color(0xFF89AFAF)),
                    ),
                    onChanged: (String? newValue) {
                      postController.postType.value = newValue ?? '';
                    },
                    items: <String>['', 'Libro', 'Película', 'Música', 'Serie', 'Otro']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    dropdownColor: Colors.white,  // Fondo blanco para el dropdown
                    underline: Container(),  // Eliminar línea de subrayado
                  );
                }),
                const SizedBox(height: 20),
                // Botones para agregar o cancelar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();  // Cerrar el cuadro de diálogo sin hacer nada
                      },
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Color(0xFF89AFAF)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Llamar al método para crear el post
                        postController.createPost();
                        Navigator.of(context).pop();  // Cerrar el cuadro de diálogo después de crear el post
                      },
                      style: ElevatedButton.styleFrom(
                         backgroundColor: const Color(0xFF89AFAF),  // Fondo verde
                        foregroundColor: Colors.white,  // Color de texto blanco
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Agregar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
