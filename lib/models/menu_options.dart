import 'package:flutter/material.dart';

class MenuOption {
  final String route;
  final IconData icon;
  final String name;
  final String urlImage;
  final Widget screen;
  final int duration;

  MenuOption(
      {required this.route,
      required this.urlImage,
      required this.duration,
      required this.icon,
      required this.name,
      required this.screen});
}
