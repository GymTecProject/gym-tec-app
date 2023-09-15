import 'package:flutter/material.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn({
    super.key,
    required this.title,
    required this.onPressed,
    this.style,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
    this.disabled = false,
  });

  final String title;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: disabled? null : onPressed, style: style, child: Text(title, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight)));
  }
}
