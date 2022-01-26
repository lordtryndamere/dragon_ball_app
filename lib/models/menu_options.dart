import 'package:flutter/material.dart';

class MenuOption {
  final String route;
  final IconData icon;
  final String name;
  final String urlImage;
  final Widget screen;

  MenuOption(
      {required this.route,
      required this.urlImage,
      required this.icon,
      required this.name,
      required this.screen});
}
