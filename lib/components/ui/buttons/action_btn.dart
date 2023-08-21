import 'package:flutter/material.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn({
    super.key,
    required this.title,
    required this.onPressed,
    this.style,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
  });

  final String title;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, style: style, child: Text(title, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight)));
  }
}
