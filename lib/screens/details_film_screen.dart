import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dragon_ball_app/providers/movies_provider.dart';
import 'package:dragon_ball_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'package:sizer/sizer.dart';

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
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 4.h,
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
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding:
              EdgeInsets.only(left: 5.h, right: 5.h, bottom: 2.h, top: 3.h),
          child: AutoSizeText(
            movie.sinopsis,
            textAlign: TextAlign.justify,
            style: TextStyle(
                shadows: const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 15, offset: Offset(0, 4))
                ],
                fontSize: 10.5.sp,
                color: Colors.white,
                fontWeight: FontWeight.w900),
          ),
        ))
      ],
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
        icon: Icon(
          Icons.arrow_back_ios,
          size: 3.h,
        ),
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
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            movie.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                shadows: const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 15, offset: Offset(0, 4))
                ],
                fontSize: 15.5.sp,
                color: Colors.white,
                fontWeight: FontWeight.w900),
            maxLines: 2,
          ),
        ))
      ],
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
      height: 33.h,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: AutoSizeText(
                'Similares en esta categoria :',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
                maxLines: 2,
              ),
            )),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        FutureBuilder(
          builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              );
            }
            final movies = snapshot.data!;
            return SizedBox(
              width: double.infinity,
              height: 27.h,
              child: movies.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FadeIn(
                          delay: const Duration(milliseconds: 150),
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.w, top: 1.5.h),
                            child: _CustomMoviePoster(movie: movies[index]),
                          )),
                      itemCount: movies.length)
                  : const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
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
    final date = DateTime.now().millisecond.ceilToDouble();
    movie.heroId = 'movie-slider-detail-$date-${movie.name}';
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, 'movies-detail', arguments: movie),
      child: Container(
        margin: EdgeInsets.only(bottom: 0.1.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Hero(
            tag: movie.heroId!,
            child: FadeInImage(
              image: NetworkImage(movie.posterImg),
              placeholder: const AssetImage('assets/loading.gif'),
              width: 32.w,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
