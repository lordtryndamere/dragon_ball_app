import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MangaScreen extends StatelessWidget {
  const MangaScreen({Key? key, this.isTab = false}) : super(key: key);
  final bool isTab;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: isTab
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              title: const CustomLayoutAppBar(),
            ),
    );
  }
}
