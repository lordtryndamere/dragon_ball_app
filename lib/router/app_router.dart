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
        name: 'Personajes',
        urlImage:
            'https://i.pinimg.com/originals/35/2b/ab/352bab00776c8f973c6ea6064cbcf36d.jpg',
        screen: const CharacterListScreen()),
    MenuOption(
        route: 'movies',
        icon: Icons.movie,
        name: 'Peliculas',
        urlImage:
            'https://p4.wallpaperbetter.com/wallpaper/784/1005/239/son-goku-dragon-ball-dragon-ball-super-dragon-ball-super-movie-wallpaper-preview.jpg',
        screen: const MoviesScreen()),
    MenuOption(
        route: 'manga',
        icon: Icons.umbrella_sharp,
        name: 'Mangas',
        urlImage:
            'https://areajugones.sport.es/wp-content/uploads/2020/07/dragon-ball-super-manga-62-castellano.jpg',
        screen: const MangaScreen()),
    MenuOption(
        route: 'about',
        icon: Icons.functions,
        urlImage:
            'http://cdn29.us1.fansshare.com/pictures/dragonballztheworldsstrongestman/dragon-ball-hd-wallpapers-movie-918652337.jpg',
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
