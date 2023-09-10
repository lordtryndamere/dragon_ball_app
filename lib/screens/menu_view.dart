import 'dart:math';
import 'package:sizer/sizer.dart';
import 'package:dragon_ball_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class MenuViewScreen extends StatelessWidget {
  const MenuViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange[100],
        ),
        width: double.infinity,
        height: size.height * 1,
        child: ListView.builder(
          itemBuilder: (context, index) => MenuSlider(
              size: size,
              route: AppRoute.menuOptions[index].route,
              name: AppRoute.menuOptions[index].name,
              urlImage: AppRoute.menuOptions[index].urlImage,
              duration: AppRoute.menuOptions[index].duration),
          itemCount: AppRoute.menuOptions.length,
        ),
      ),
    );
  }
}

class MenuSlider extends StatelessWidget {
  const MenuSlider({
    Key? key,
    required this.size,
    required this.route,
    required this.urlImage,
    required this.name,
    required this.duration,
  }) : super(key: key);

  final Size size;
  final String route;
  final String urlImage;
  final String name;
  final int duration;
  @override
  Widget build(BuildContext context) {
    final random = Random();

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2, top: 20, left: 5, right: 5),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 16.5.h,
              color: Colors.orange[100],
              child: Swiper(
                fade: 0.2,
                duration: 1500,
                autoplay: false,
                physics: const NeverScrollableScrollPhysics(),
                autoplayDelay: random.nextInt(duration) + 4000,
                autoplayDisableOnInteraction: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ClipRRect(
                        //Me permite hacer un border radius
                        borderRadius: BorderRadius.circular(10),
                        child: Opacity(
                          opacity: 1,
                          child: FadeInImage(
                            image: AssetImage(urlImage),
                            placeholder: const AssetImage('assets/loading.gif'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  );
                },
                itemHeight: size.height * 0.2,
                layout: SwiperLayout.DEFAULT,
                itemCount: 1,
              ),
            ),
            Positioned(
                child: Opacity(
              opacity: 0.3,
              child: Image(
                image: const AssetImage('assets/iconZ.png'),
                width: size.width * 0.2,
                height: size.height * 0.1,
              ),
            )),
            Positioned(
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  letterSpacing: 5.0,
                  fontFamily: 'Bangers',
                  fontSize: (size.width * 0.1).toDouble(),
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
