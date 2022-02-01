import 'package:flutter/material.dart';

class CustomCardMenu extends StatelessWidget {
  const CustomCardMenu({
    required this.urlImage,
    required this.route,
    required this.title,
    Key? key,
  }) : super(key: key);
  final String urlImage;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {Navigator.pushNamed(context, route)},
      child: Card(
        clipBehavior: Clip
            .antiAlias, //En caso de que el hijo no respete la propiedad del padre,cortar lo que salga
        // por ejemplo la imagen se sale y no permite la forma redondeada con esto se corta y se aplica la propieda del padre en este caso la carta que siempre tiene bordes
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        shadowColor: Colors.indigo.withOpacity(0.5),
        child: Column(
          children: <Widget>[
            FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                // width: double.infinity,
                width: 130,
                fadeInDuration: const Duration(milliseconds: 400),
                height: 100,
                fit: BoxFit.fill,
                image: NetworkImage(urlImage)),
          ],
        ),
      ),
    );
  }
}
