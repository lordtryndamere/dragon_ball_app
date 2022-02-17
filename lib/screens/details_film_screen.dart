import 'dart:ui';
import 'package:dragon_ball_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class DetailsFilmsScreen extends StatelessWidget {
  const DetailsFilmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgroundetail.jpeg'),
                  fit: BoxFit.cover)),
          width: double.infinity,
          height: double.infinity,
          child: CustomScrollView(
            slivers: [
              _CustomAppBar(movie: movie),
              SliverList(
                  delegate: SliverChildListDelegate([
                Column(
                  children: [
                    FittedText(movie: movie, size: size),
                    ClipRRect(child: _OverView(movie: movie)),
                    const SizedBox(
                      height: 32,
                    )
                  ],
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 32, right: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            height: size.height * 0.2 + 40,
            image: const AssetImage('assets/iconZ.png'),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Text(
              movie.sinopsis,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ],
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
          title: ContainerAppBar(movie: movie)),
    );
  }
}

class ContainerAppBar extends StatelessWidget {
  const ContainerAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class FittedText extends StatelessWidget {
  const FittedText({
    Key? key,
    required this.movie,
    required this.size,
  }) : super(key: key);

  final Movie movie;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: 10, left: 20, right: 20, top: 10), // centrar contenido
      width: double.infinity,
      child: Text(
        movie.name,
        style: TextStyle(
            fontSize: size.height * 0.1 - 55,
            fontWeight: FontWeight.w800,
            color: Colors.white),
        textAlign: TextAlign.center, // centrar texto en contenido
      ),
    );
  }
}
