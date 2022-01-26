import 'package:dragon_ball_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:dragon_ball_app/widgets/widgets.dart';

class MenuRender extends StatelessWidget {
  const MenuRender({
    Key? key,
  }) : super(key: key);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CustomCardMenu(
                          title: AppRoute.menuOptions[1].name,
                          route: AppRoute.menuOptions[1].route,
                          urlImage: AppRoute.menuOptions[1].urlImage),
                      TextButton(
                        onPressed: () {},
                        child: Text('Peliculas'),
                        style: TextButton.styleFrom(primary: Colors.black),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      CustomCardMenu(
                          title: AppRoute.menuOptions[0].name,
                          route: AppRoute.menuOptions[0].route,
                          urlImage: AppRoute.menuOptions[0].urlImage),
                      TextButton(
                        onPressed: () {},
                        child: Text('Peliculas'),
                        style: TextButton.styleFrom(primary: Colors.black),
                      )
                    ],
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        CustomCardMenu(
                            title: AppRoute.menuOptions[2].name,
                            route: AppRoute.menuOptions[2].route,
                            urlImage: AppRoute.menuOptions[2].urlImage),
                        TextButton(
                          onPressed: () {},
                          child: Text('Peliculas'),
                          style: TextButton.styleFrom(primary: Colors.black),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CustomCardMenu(
                            title: AppRoute.menuOptions[3].name,
                            route: AppRoute.menuOptions[3].route,
                            urlImage: AppRoute.menuOptions[3].urlImage),
                        TextButton(
                          onPressed: () {},
                          child: Text('Peliculas'),
                          style: TextButton.styleFrom(primary: Colors.black),
                        )
                      ],
                    )
                  ]),
            ],
          )),
    );
  }
}
