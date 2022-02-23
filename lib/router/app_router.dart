import 'package:dragon_ball_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:dragon_ball_app/models/models.dart';

class AppRoute {
  static const initalRoute = 'home';
  //Crear rutas a partir de este menu
  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'list-characters',
        icon: Icons.list_alt,
        duration: 4000,
        name: 'Personajes',
        urlImage: 'assets/personajes.jpg',
        screen: const CharacterListScreen()),
    MenuOption(
        route: 'movies',
        icon: Icons.movie,
        duration: 5000,
        name: 'Peliculas',
        urlImage: 'assets/peliculas.jpeg',
        screen: const MoviesScreen()),
    MenuOption(
        route: 'manga',
        icon: Icons.umbrella_sharp,
        name: 'Mangas',
        duration: 4000,
        urlImage: 'assets/mangas.jpeg',
        screen: const MangaScreen()),
    MenuOption(
        route: 'about',
        duration: 4500,
        icon: Icons.functions,
        urlImage: 'assets/kamehouse.png',
        name: 'Capitulos',
        screen: const AboutScreen()),
  ];
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {
      initalRoute: (BuildContext context) => const HomeScreen(),
    };
    appRoutes.addAll({
      'character-detail': (BuildContext context) => const CharacterScreen(),
      'movies-detail': (BuildContext context) => const DetailsFilmsScreen(),
    });
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  //Forma normal de crear las runtas tambien serviria de manera normal
  /*static final routes = <String, Widget Function(BuildContext)>{
    'home': (BuildContext context) => const HomeScreen(),
    'listView1': (BuildContext context) => const ListView1Screen(),
    'listView2': (BuildContext context) => const ListView2Screen(),
    'alert': (BuildContext context) => const AlertScreen(),
    'card': (BuildContext context) => const CardScreen()
  };*/
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
