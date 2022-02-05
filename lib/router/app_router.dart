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
        urlImage:
            'https://cutewallpaper.org/21/dragon-ball-z-goku-hd-wallpaper/Hd-Dragon-Ball-Z-Sky-Wallpaper-Thecharmingstyle.com.jpg',
        screen: const CharacterListScreen()),
    MenuOption(
        route: 'movies',
        icon: Icons.movie,
        duration: 5000,
        name: 'Peliculas',
        urlImage:
            'https://p4.wallpaperbetter.com/wallpaper/784/1005/239/son-goku-dragon-ball-dragon-ball-super-dragon-ball-super-movie-wallpaper-preview.jpg',
        screen: const MoviesScreen()),
    MenuOption(
        route: 'manga',
        icon: Icons.umbrella_sharp,
        name: 'Mangas',
        duration: 4000,
        urlImage:
            'https://i.pinimg.com/originals/7f/a9/c8/7fa9c864a830e94a9790f8a86ab12ab1.jpg',
        screen: const MangaScreen()),
    MenuOption(
        route: 'about',
        duration: 4500,
        icon: Icons.functions,
        urlImage: 'https://wallpaperaccess.com/full/4545965.png',
        name: 'About',
        screen: const AboutScreen()),
  ];
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {
      initalRoute: (BuildContext context) => const HomeScreen(),
    };
    appRoutes.addAll({
      'character-detail': (BuildContext context) => const CharacterScreen()
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
