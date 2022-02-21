import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:dragon_ball_app/providers/movies_provider.dart';
import 'package:dragon_ball_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/a4/b3/6a/a4b36a2211d6a6aa49c75b7bcb832f6a.gif'),
                  fit: BoxFit.cover)),
          width: double.infinity,
          height: double.infinity,
          child: CustomScrollView(
            slivers: [
              _CustomAppBar(movie: movie),
              SliverList(
                  delegate: SliverChildListDelegate([
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => VideoPlayer(
                                        movie: movie,
                                      ),
                                  transitionDuration:
                                      const Duration(seconds: 0)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      FittedText(
                        movie: movie,
                        size: size,
                      ),
                      _OverView(movie: movie),
                      const SizedBox(
                        height: 13,
                      ),
                      _MovieSlider(category: movie.categoryId),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
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
      child: Text(
        movie.sinopsis,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pushNamed(context, 'movies'),
      ),
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
            fontSize: size.width * 0.1 - 15,
            fontWeight: FontWeight.w800,
            color: Colors.white),
        textAlign: TextAlign.center, // centrar texto en contenido
      ),
    );
  }
}

class _MovieSlider extends StatelessWidget {
  const _MovieSlider({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<MoviesProvider>(context);
    // moviesProvider.getMoviesByCategory(category.id);
    return Container(
      // siempre a mi container main ponerle width infinito
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: size.height * 0.3 - 16,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Image(
                image: const AssetImage('assets/icon_ball.png'),
                height: size.height * 0.1 - 62),
            const SizedBox(width: 15),
            Text('Similares en esta categoria..',
                style: TextStyle(
                    //backgroundColor: Colors.white,
                    //  background: Paint()..color = Colors.orange[900]!,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: size.width * 0.1 - 20)),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        FutureBuilder(
          builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final movies = snapshot.data!;
            return SizedBox(
              width: double.infinity,
              height: size.height * 0.2 + 25,
              child: movies.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FadeIn(
                          delay: const Duration(milliseconds: 150),
                          child: _CustomMoviePoster(movie: movies[index])),
                      itemCount: movies.length)
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
            );
          },
          future: moviesProvider.findByCategory(category),
        ),
      ]),
    );
  }
}

class _CustomMoviePoster extends StatelessWidget {
  const _CustomMoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final date = DateTime.now().millisecond.ceilToDouble();
    movie.heroId = 'movie-slider-detail-$date-${movie.name}';
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, 'movies-detail', arguments: movie),
      child: Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Hero(
            tag: movie.heroId!,
            child: FadeInImage(
              image: NetworkImage(movie.posterImg),
              placeholder: const AssetImage('assets/loading.gif'),
              width: size.width * 0.3 - 20,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
