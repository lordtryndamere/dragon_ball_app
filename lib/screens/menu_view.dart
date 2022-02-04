import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class MenuViewScreen extends StatelessWidget {
  const MenuViewScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.route})
      : super(key: key);
  final String title;
  final String description;
  final String route;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.orange[200],
      width: double.infinity,
      height: size.height * 1,
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding:
              const EdgeInsets.only(bottom: 2, top: 10, left: 10, right: 10),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: size.height * 0.15,
                color: Colors.orange[200],
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 4000,
                  autoplayDisableOnInteraction: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'detail',
                          arguments: 'movie-screen'),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ClipRRect(
                          //Me permite hacer un border radius
                          borderRadius: BorderRadius.circular(10),
                          child: const FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage('assets/loading.gif'),
                            image: NetworkImage(
                                'https://c4.wallpaperflare.com/wallpaper/214/442/543/digital-art-son-goku-dragon-ball-dragon-ball-z-island-hd-wallpaper-preview.jpg'),
                          ),
                        ),
                      ),
                    );
                  },
                  itemHeight: size.height * 0.2,
                  layout: SwiperLayout.DEFAULT,
                  itemCount: 10,
                ),
              )
            ],
          ),
        ),
        itemCount: 4,
      ),
    );
  }
}
