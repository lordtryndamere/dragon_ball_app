import 'package:flutter/material.dart';
import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:dragon_ball_app/router/app_router.dart';
class RenderCards extends StatelessWidget {
  const RenderCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                CustomCardMenu(
                    title: AppRoute.menuOptions[1].name,
                    route: AppRoute.menuOptions[1].route,
                    urlImage: AppRoute.menuOptions[1].urlImage),
                TextButton(
                  onPressed: () {},
                  child:  Text(AppRoute.menuOptions[1].name),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                ),
              ],
            ),
               const SizedBox(width: 7,),
            Column(
              children: <Widget>[
                CustomCardMenu(
                    title: AppRoute.menuOptions[0].name,
                    route: AppRoute.menuOptions[0].route,
                    urlImage: AppRoute.menuOptions[0].urlImage),
                    
                TextButton(
                  onPressed: () {},
                  child:  Text(AppRoute.menuOptions[0].name),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 5,),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  CustomCardMenu(
                      title: AppRoute.menuOptions[2].name,
                      route: AppRoute.menuOptions[2].route,
                      urlImage: AppRoute.menuOptions[2].urlImage),
                  TextButton(
                    onPressed: () {},
                    child: Text(AppRoute.menuOptions[2].name),
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                  )
                ],
              ),
              const SizedBox(width: 7,),
              Column(
                children: [
                  CustomCardMenu(
                      title: AppRoute.menuOptions[3].name,
                      route: AppRoute.menuOptions[3].route,
                      urlImage: AppRoute.menuOptions[3].urlImage),
                  TextButton(
                    onPressed: () {},
                    child:  Text(AppRoute.menuOptions[3].name),
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                  )
                ],
              )
            ]),
      ],
    );
  }
}

