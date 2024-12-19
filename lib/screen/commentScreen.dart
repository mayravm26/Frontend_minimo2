import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/commentController.dart';
import '../models/Comment.dart';

/*
class CommentScreen extends StatelessWidget {
  final String postId;

  const CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentController = Get.find<CommentController>();

    return Scaffold(
      appBar: AppBar(title: Text('Comentarios')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (commentController.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
                  return ListTile(
                    title: Text(comment.author),
                    subtitle: Text(comment.content),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => commentController.deleteComment(
                        postId,
                        comment.id,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: 'Escribe un comentario...'),
                    onSubmitted: (value) {
                      final newComment = Comment(
                        id: '',
                        postId: postId,
                        author: 'Usuario', // Cambia por el usuario autenticado
                        content: value,
                        createdAt: DateTime.now(),
                        postDate: DateTime.now(),
                      );
                      commentController.addComment(postId, newComment);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

*/

class CommentScreen extends StatelessWidget {
  final String postId;

  const CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Asegúrate de obtener el controlador con GetX
    final commentController = Get.find<CommentController>();

    // Llama a fetchComments al construir la pantalla
    commentController.fetchComments(postId);

    return Scaffold(
      appBar: AppBar(title: const Text('Comentarios')),
      body: Column(
        children: [
          // Lista de comentarios
          Expanded(
            child: Obx(() {
              if (commentController.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (commentController.comments.isEmpty) {
                return const Center(child: Text('No hay comentarios'));
              }

              return ListView.builder(
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
                  return ListTile(
                    title: Text(comment.author),
                    subtitle: Text(comment.content),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => commentController.deleteComment(
                        postId,
                        comment.id,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          // Campo para agregar un nuevo comentario
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Escribe un comentario...',
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        final newComment = Comment(
                          id: '', // ID se generará en el backend
                          postId: postId,
                          author:
                              'Usuario', // Cambia por el usuario autenticado
                          content: value.trim(),
                          createdAt: DateTime.now(),
                          postDate: DateTime.now(),
                        );
                        commentController.addComment(postId, newComment);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
