import 'package:flutter/material.dart';

class ContentPadding extends StatelessWidget {
  const ContentPadding({super.key, this.padding = 20.0, required this.child});

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
