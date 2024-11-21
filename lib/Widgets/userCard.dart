import 'package:flutter/material.dart';
import '../models/userModel.dart'; // Ajusta la ruta si el teu model està en una altra carpeta

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({Key? key, required this.user}) : super(key: key);

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
              user.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Email: ${user.email}'),
            const SizedBox(height: 8),
            Text('Username: ${user.username}'),
            const SizedBox(height: 8),
            Text('In Home: ${user.inHome ? "Sí" : "No"}'),
            const SizedBox(height: 8),
            Text('Admin: ${user.admin ? "Sí" : "No"}'),
            const SizedBox(height: 8),
            Text('Disabled: ${user.disabled ? "Sí" : "No"}'),
            const SizedBox(height: 8),
            Text('Ubicació: ${user.actualUbication.isNotEmpty ? user.actualUbication.toString() : "Sense ubicació"}'),
          ],
        ),
      ),
    );
  }
}
