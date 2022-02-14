import 'package:flutter/material.dart';

class CustomLayoutAppBar extends StatelessWidget {
  const CustomLayoutAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Image(
            height: 46,
            fit: BoxFit.cover,
            image: AssetImage('assets/logo_dragon_ball.png'),
          ),
        ],
      ),
    );
  }
}
