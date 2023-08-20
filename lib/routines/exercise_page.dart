import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgPath;
  final String url;
  final String comment;
  final String category;

  const ExercisePage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imgPath,
    required this.url,
    required this.comment,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: $title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Subtitle: $subtitle',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20), // Espacio entre los elementos
            Image.asset(
              imgPath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20), // Espacio entre la imagen y el siguiente texto
            Text(
              'URL: $url',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Comment: $comment',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Category: $category',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
