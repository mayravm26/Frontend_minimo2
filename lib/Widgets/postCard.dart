import 'package:flutter/material.dart';
import '../models/post.dart'; // Ajusta la ruta según la ubicación de tu modelo

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onDelete;

  const PostCard({
    Key? key,
    required this.post,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.image != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.network(
                  post.image!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            Text(
              'Autor:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(post.author),
            const SizedBox(height: 16),
            Text(
              'Tipo de Publicación:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(post.postType),
            const SizedBox(height: 16),
            Text(
              'Contenido:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(post.content),
            if (post.postDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Fecha de publicación: ${post.postDate!.toLocal()}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
