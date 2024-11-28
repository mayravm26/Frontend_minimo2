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
    postListController.fetchPosts();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Lista de posts
            Expanded(
              flex: 2,
              child: Obx(() {
                if (postListController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (postListController.postList.isEmpty) {
                  return const Center(
                    child: Text(
                      "No hay posts disponibles",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF89AFAF),
                      ),
                    ),
                  );
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
            const SizedBox(width: 20),
            // Formulario para crear posts
            Expanded(
              flex: 3,
              child: PostForm(postController: postController),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget reutilizable para el formulario de posts
class PostForm extends StatelessWidget {
  final PostController postController;

  const PostForm({Key? key, required this.postController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(194, 162, 204, 204),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Crear Nueva Publicación',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF89AFAF),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: postController.ownerController,
            decoration: const InputDecoration(
              labelText: 'Autor',
              labelStyle: TextStyle(color: Color(0xFF89AFAF)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF89AFAF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF89AFAF), width: 2.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          /*TextField(
            controller: postController.participantsController,
            decoration: const InputDecoration(
              labelText: 'Participantes',
              labelStyle: TextStyle(color: Color(0xFF89AFAF)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF89AFAF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF89AFAF), width: 2.0),
              ),
            ),
          ),
          const SizedBox(height: 16),*/
          TextField(
            controller: postController.descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              labelStyle: TextStyle(color: Color(0xFF89AFAF)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF89AFAF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF89AFAF), width: 2.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            return DropdownButtonFormField<String>(
              value: postController.postType.value.isEmpty
                  ? null
                  : postController.postType.value,
              hint: const Text('Seleccionar tipo de post'),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF89AFAF)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF89AFAF), width: 2.0),
                ),
              ),
              items: <String>['Pelicula', 'Libro', 'Evento', 'Música']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                postController.postType.value = newValue!;
              },
            );
          }),
          const SizedBox(height: 16),
          Obx(() {
            if (postController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ElevatedButton(
                onPressed: () {
                  postController.createPost();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF89AFAF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Crear Post'),
              );
            }
          }),
        ],
      ),
    );
  }
}