import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/padding/content_padding.dart';
import 'package:gym_tec/components/ui/separators/item_separator.dart';

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
      // backgroundColor: const Color(0xFF424242), // Hex color #424242
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Curved edges
      ),
      fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 150),
      // padding: const EdgeInsets.only(top: 16.0, left: 16.0)
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
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.0),
            )),
            child: img),
        ContentPadding(
          // padding: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                title,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const ItemSeparator(),
              Text(
                subtitle ?? '',
                style: const TextStyle(
                  // color: Colors.grey,
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
