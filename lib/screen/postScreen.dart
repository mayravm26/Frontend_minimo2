import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/postsListController.dart';
import 'package:flutter_application_1/controllers/postController.dart';
import 'package:flutter_application_1/Widgets/postCard.dart';
import 'package:get/get.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostController postController = Get.put(PostController());
  final PostsListController postListController = Get.put(PostsListController());

  @override
  void initState() {
    super.initState();
    postListController.fetchPosts(); // Asegúrate de obtener experiencias al iniciar la página.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestión de Posts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Lista de experiencias
            Expanded(
              child: Obx(() {
                if (postListController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (postListController.postList.isEmpty) {
                  return Center(child: Text("No hay posts disponibles"));
                } else {
                  return ListView.builder(
                    itemCount: postListController.postList.length,
                    itemBuilder: (context, index) {
                      final post = postListController.postList[index];
                      return PostCard(
                        post: post,
                        onDelete: () => postListController.postToDelete(post.id),
                      );
                    },
                  );
                }
              }),
            ),
            SizedBox(width: 20),
            // Formulario de registro de experiencia
            Expanded(
              flex: 2,
              child: PostForm(postController: postController),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget reutilizable para el formulario de experiencia
class PostForm extends StatelessWidget {
  final PostController postController;

  const PostForm({Key? key, required this.postController}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Crear Nueva Experiencia',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      TextField(
        controller: postController.ownerController,
        decoration: InputDecoration(
          labelText: 'Propietario',
          // (errorText: experienceController.ownerError.value)
        ),
      ),
      TextField(
        controller: postController.participantsController,
        decoration: InputDecoration(
          labelText: 'Participantes',
          // errorText: experienceController.participantsError.value,
        ),
      ),
      TextField(
        controller: postController.descriptionController,
        decoration: InputDecoration(
          labelText: 'Descripción',
          // errorText: experienceController.descriptionError.value,
        ),
      ),
      SizedBox(height: 16),

      // Dropdown para seleccionar el tipo de post
      Obx(() {
        return DropdownButton<String>(
          value: postController.postType.value.isEmpty ? null : postController.postType.value,
          hint: Text('Seleccionar tipo de post'),
          items: <String>['Pelicula', 'Libro', 'Evento']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Actualizar el tipo de post
            postController.postType.value = newValue!;
          },
        );
      }),

      SizedBox(height: 16),

      // Botón para crear el post
      Obx(() {
        if (postController.isLoading.value) {
          return CircularProgressIndicator();
        } else {
          return ElevatedButton(
            onPressed: () {
              postController.createPost();  // Llama al método para crear el post
            },
            child: Text('Crear post'),
          );
        }
      }),
    ],
  );
  }
}