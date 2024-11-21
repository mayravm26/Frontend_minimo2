import 'package:flutter/material.dart';
import '../models/experienceModel.dart'; // Ajusta la ruta según la ubicación de tu modelo

class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final VoidCallback onDelete;

  const ExperienceCard({
    Key? key,
    required this.experience,
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
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(experience.description),
            const SizedBox(height: 16),
            Text(
              'Propietario:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Nombre: ${experience.owner}'),
            const SizedBox(height: 8),
            Text(
              'Participantes:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(experience.participants),
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