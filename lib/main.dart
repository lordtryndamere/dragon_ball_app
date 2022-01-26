import 'package:dragon_ball_app/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dragon Ball App',
      initialRoute: AppRoute.initalRoute,
      routes: AppRoute.getAppRoutes(),
      onGenerateRoute: (settings) => AppRoute.onGenerateRoute(settings),
    );
  }
}
