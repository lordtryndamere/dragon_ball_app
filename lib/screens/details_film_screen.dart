import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/models.dart';

class DetailsFilmsScreen extends StatelessWidget {
  const DetailsFilmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          slivers: [
            _CustomAppBar(movie: movie),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      expandedHeight: size.height * 0.3,
      pinned: false,
      backgroundColor: Colors.orange[100],
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          alignment: Alignment.bottomCenter, // centrar contenido
          width: double.infinity,
          child: Text(
            movie.name,
            style: TextStyle(fontSize: size.height * 0.1 - 65),
            textAlign: TextAlign.center, // centrar texto en contenido
          ),
        ),
        background: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(movie.posterImg),
            fit: BoxFit.fill,
          )),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Hero(
              tag: movie.heroId!,
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(movie.posterImg),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
