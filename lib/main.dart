import 'package:dragon_ball_app/providers/category_provider.dart';
import 'package:dragon_ball_app/providers/movies_provider.dart';
import 'package:dragon_ball_app/router/app_router.dart';
import 'package:dragon_ball_app/screens/home_screem.dart';
import 'package:dragon_ball_app/service/access_token.dart';
import 'package:dragon_ball_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(child: const MyApp(), providers: [
      ChangeNotifierProvider(
        create: (_) => AccessToken(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => CategoryProvider(),
        lazy: true,
      ),
      ChangeNotifierProvider(
        create: (_) => MoviesProvider(),
        lazy: true,
      ),
    ]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KameMovies',
          // initialRoute: AppRoute.initalRoute,
          routes: AppRoute.getAppRoutes(),
          home: AnimatedSplashScreen(
              duration: 3100,
              splash: const Image(
                image: AssetImage('assets/loading.gif'),
              ),
              nextScreen: const HomeScreen(),
              splashIconSize: 32.h,
              splashTransition: SplashTransition.rotationTransition,
              pageTransitionType: PageTransitionType.bottomToTop,
              backgroundColor: const Color(0xffff9a00)),
          theme: AppTheme.lighTheme,
          onGenerateRoute: (settings) => AppRoute.onGenerateRoute(settings),
        );
      },
    );
  }
}
