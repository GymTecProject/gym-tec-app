import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String url;
  final String comment;
  final String category;
  final int series;
  final int repetitions;

  const ExercisePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.comment,
    required this.category,
    required this.series,
    required this.repetitions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20), // Espacio entre el texto y la imagen
            Text(
              'Series: $series',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20), // Espacio entre la imagen y el siguiente texto
            Text(
              'Repeticiones: $repetitions',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20), // Espacio entre la imagen y el siguiente texto
            Text(
              url,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              comment,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              category,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
