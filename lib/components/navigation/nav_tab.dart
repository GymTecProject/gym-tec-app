import 'package:flutter/material.dart';

class NavTab{
  const NavTab(
      {
      required this.label,
      required this.icon,
      required this.widget
    });

  final String label;
  final Icon icon;
  final Widget widget;
}
