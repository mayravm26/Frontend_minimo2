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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xFF89AFAF), // Fondo verde claro
      elevation: 5, // Sombra suave
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados para la imagen
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Image.network(
                    post.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 100, color: Color.fromARGB(194, 162, 204, 204),),
                  ),
                ),
              ),
            const Text(
              'Autor:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto en blanco
              ),
            ),
            const SizedBox(height: 4),
            Text(
              post.author,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70, // Texto con opacidad
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tipo de Publicación:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto en blanco
              ),
            ),
            Text(
              post.postType,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contenido:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              post.content,
              style: const TextStyle(color: Colors.white70),
            ),
            if (post.postDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Fecha de publicación: ${post.postDate!.toLocal()}',
                  style: const TextStyle(
                    color: Color(0xFFE0F7FA), // Azul claro para fechas
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Color.fromARGB(255, 204, 162, 162)),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}