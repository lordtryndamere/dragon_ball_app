
import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MenuRender extends StatelessWidget {
  const MenuRender({
    Key? key,
  }) : super(key: key);
  final listDragonBallCharacters = const <Map<String, String>>[
    {'name': 'Goku', 'description': 'Saiyajin criado en la tierra' ,'urlImage':'https://aux.iconspalace.com/uploads/1421321576980686818.png'},
    {'name': 'Vegueta', 'description': 'Principe de los saiyajin','urlImage':'https://cdn.dribbble.com/users/81809/screenshots/3460827/vegeta.jpg'},
    {'name': 'Krillin', 'description': 'Terricola muere mucho','urlImage':'https://cdn2.iconfinder.com/data/icons/dragonball-z-colored/48/Cartoons__Anime_Dragonball_Artboard_9-512.png'},
    {'name': 'Brolly', 'description': 'Super saiyajin legendario','urlImage':'https://i.pinimg.com/originals/35/03/37/35033745af546b3b401d7d3c4f1f08e4.jpg'},
    {'name': 'Goku', 'description': 'Saiyajin criado en la tierra' ,'urlImage':'https://aux.iconspalace.com/uploads/1421321576980686818.png'},
    {'name': 'Vegueta', 'description': 'Principe de los saiyajin','urlImage':'https://cdn.dribbble.com/users/81809/screenshots/3460827/vegeta.jpg'},
    {'name': 'Krillin', 'description': 'Terricola muere mucho','urlImage':'https://cdn2.iconfinder.com/data/icons/dragonball-z-colored/48/Cartoons__Anime_Dragonball_Artboard_9-512.png'},
    {'name': 'Brolly', 'description': 'Super saiyajin legendario','urlImage':'https://i.pinimg.com/originals/35/03/37/35033745af546b3b401d7d3c4f1f08e4.jpg'},
    {'name': 'Goku', 'description': 'Saiyajin criado en la tierra' ,'urlImage':'https://aux.iconspalace.com/uploads/1421321576980686818.png'},
    {'name': 'Vegueta', 'description': 'Principe de los saiyajin','urlImage':'https://cdn.dribbble.com/users/81809/screenshots/3460827/vegeta.jpg'},
    {'name': 'Krillin', 'description': 'Terricola muere mucho','urlImage':'https://cdn2.iconfinder.com/data/icons/dragonball-z-colored/48/Cartoons__Anime_Dragonball_Artboard_9-512.png'},
    {'name': 'Brolly', 'description': 'Super saiyajin legendario','urlImage':'https://i.pinimg.com/originals/35/03/37/35033745af546b3b401d7d3c4f1f08e4.jpg'},
    {'name': 'Goku', 'description': 'Saiyajin criado en la tierra' ,'urlImage':'https://aux.iconspalace.com/uploads/1421321576980686818.png'},
    {'name': 'Vegueta', 'description': 'Principe de los saiyajin','urlImage':'https://cdn.dribbble.com/users/81809/screenshots/3460827/vegeta.jpg'},
    {'name': 'Krillin', 'description': 'Terricola muere mucho','urlImage':'https://cdn2.iconfinder.com/data/icons/dragonball-z-colored/48/Cartoons__Anime_Dragonball_Artboard_9-512.png'},
    {'name': 'Brolly', 'description': 'Super saiyajin legendario','urlImage':'https://i.pinimg.com/originals/35/03/37/35033745af546b3b401d7d3c4f1f08e4.jpg'},
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.grey, BlendMode.colorBurn),
                  fit: BoxFit.fill,
                  opacity: 0.7,
                  image: AssetImage('assets/definitive.gif'))),
          child: ListView.builder(itemBuilder: (context, index) => CustomItemList(name: listDragonBallCharacters[index]['name'] ?? 'Unknown', urlImage: listDragonBallCharacters[index]['urlImage'] ?? 'Unknown', route: listDragonBallCharacters[index]['route'] ?? 'Unknown', description: listDragonBallCharacters[index]['description'] ?? 'Unknown'),   itemCount: listDragonBallCharacters.length)  ),
    
    );
  }
}

