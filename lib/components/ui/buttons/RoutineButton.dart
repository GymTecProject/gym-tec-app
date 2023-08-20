import 'package:flutter/material.dart';

class RoutineButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgPath;
  final VoidCallback onPressed;

  const RoutineButton(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imgPath,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF424242), // Hex color #424242
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Curved edges
        ),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 150),
        padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      ),
      child: Stack(children: <Widget>[
        Container(
            alignment: Alignment.bottomRight,
            child: Image.asset(imgPath,
                height: 100,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth)),
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
