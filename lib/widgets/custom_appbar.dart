import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomLayoutAppBar extends StatelessWidget {
  const CustomLayoutAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            height: 5.8.h,
            fit: BoxFit.contain,
            image: const AssetImage('assets/logo_dragon_ball.png'),
          ),
        ],
      ),
    );
  }
}
