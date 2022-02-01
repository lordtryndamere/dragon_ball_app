import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: double.infinity,
      height:double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.grey, BlendMode.colorBurn),
                fit: BoxFit.fill,
                opacity: 0.7,
                image: AssetImage('assets/definitive.gif'))),
        child: Text('Hola')  );
    
  }
}
