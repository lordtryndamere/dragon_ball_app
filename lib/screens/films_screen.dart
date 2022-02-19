import 'package:animate_do/animate_do.dart';
import 'package:dragon_ball_app/models/categories.dart';
import 'package:dragon_ball_app/models/movie.dart';
import 'package:dragon_ball_app/providers/category_provider.dart';
import 'package:dragon_ball_app/providers/movies_provider.dart';
import 'package:dragon_ball_app/search/search_delegate.dart';
import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key, this.isTab = false}) : super(key: key);
  final bool isTab;
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        top: false,
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomScrollView(slivers: [
            if (!isTab)
              SliverAppBar(
                actions: [
                  IconButton(
                      onPressed: () => showSearch(
                          context: context, delegate: MovieSearchDelegate()),
                      icon: const Icon(Icons.search_outlined)),
                ],
                pinned: false,
                floating: false,
                title: const CustomLayoutAppBar(),
              ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: size.height * 0.9,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    _CustomMovieSwiper(
                      movies: moviesProvider.initalMovies,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => _MovieSlider(
                            category: categoryProvider.categories[index]),
                        itemCount: categoryProvider.categories.length,
                      ),
                    ),
                    SizedBox(
                      height: isTab ? 50 : 25,
                    ),
                  ],
                ),
              ),
            ]))
          ]),
        ),
      ),
    );
  }
}

class _MovieSlider extends StatelessWidget {
  const _MovieSlider({
    Key? key,
    required this.category,
  }) : super(key: key);
  final CategoryElement category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<MoviesProvider>(context);
    // moviesProvider.getMoviesByCategory(category.id);
    return Container(
      // siempre a mi container main ponerle width infinito
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: double.infinity,
      height: size.height * 0.3 - 18,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Image(
                image: const AssetImage('assets/icon_ball.png'),
                height: size.height * 0.1 - 62),
            const SizedBox(width: 15),
            Text(category.name,
                style: TextStyle(
                    //backgroundColor: Colors.white,
                    //  background: Paint()..color = Colors.orange[900]!,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: size.height * 0.1 - 63)),
          ],
        ),
        const SizedBox(
          height: 8,
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
              height: size.height * 0.2 + 30,
              child: movies.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FadeIn(
                          delay: const Duration(milliseconds: 150 * 1),
                          child: _CustomMoviePoster(movie: movies[index])),
                      itemCount: movies.length)
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
            );
          },
          future: moviesProvider.findByCategory(category.id),
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
    movie.heroId = 'movie-slider-${movie.name}';
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
              width: size.width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomMovieSwiper extends StatelessWidget {
  final List<Movie> movies;
  const _CustomMovieSwiper({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator.adaptive()),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Swiper(
        fade: 2,
        autoplay: true,
        autoplayDelay: 4000,
        autoplayDisableOnInteraction: true,
        itemBuilder: (context, index) {
          final movie = movies[index];
          movie.heroId = 'swiper-${movie.name}';
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'movies-detail', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(

                  //Me permite hacer un border radius
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    image: NetworkImage(movie.posterImg),
                    placeholder: const AssetImage('assets/loading.gif'),
                    fit: BoxFit.cover,
                  )),
            ),
          );
        },
        itemWidth: size.width * 0.7,
        itemHeight: size.height * 0.5 - 35,
        layout: SwiperLayout.STACK,
        itemCount: movies.length,
      ),
    );
  }
}
