import 'package:flutter/material.dart';

class CardBtn extends StatelessWidget {
  const CardBtn(
      {super.key,
      required this.title,
      required this.onPressed,
      this.subtitle,
      this.imgPath,
      this.style});

  final String title;
  final VoidCallback onPressed;
  final String? subtitle;
  final String? imgPath;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    ButtonStyle defaultStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF424242), // Hex color #424242
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Curved edges
      ),
      fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 150),
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
    );

    Image? img = imgPath != null
        ? Image.asset(imgPath!,
            height: 100,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth)
        : null;

    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? defaultStyle,
      child: Stack(children: <Widget>[
        Container(
            alignment: Alignment.bottomRight,
            clipBehavior: Clip.hardEdge,
            decoration:
                const BoxDecoration(borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12.0),
                )),
            child: img),
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
                subtitle ?? '',
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
