import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dragon_ball_app/models/categories.dart';
import 'package:dragon_ball_app/models/movie.dart';
import 'package:dragon_ball_app/providers/category_provider.dart';
import 'package:dragon_ball_app/providers/movies_provider.dart';
import 'package:dragon_ball_app/search/search_delegate.dart';
import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
                toolbarHeight: 6.8.h,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 2.5.h,
                  ),
                  onPressed: () => Navigator.pushNamed(context, 'home'),
                ),
                actions: [
                  IconButton(
                      onPressed: () => showSearch(
                          context: context, delegate: MovieSearchDelegate()),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: Icon(Icons.search_outlined, size: 3.5.h),
                      )),
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
                      height: 5,
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
    final moviesProvider = Provider.of<MoviesProvider>(context);
    // moviesProvider.getMoviesByCategory(category.id);
    return Container(
      // siempre a mi container main ponerle width infinito
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 38.8.h,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
                child: FadeIn(
              delay: const Duration(milliseconds: 500),
              child: AutoSizeText(
                category.name,
                style: TextStyle(
                    shadows: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(0, 4))
                    ],
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
                maxLines: 2,
              ),
            ))
          ],
        ),
        const SizedBox(
          height: 15,
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 31.h,
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
                ),
              ],
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
              width: size.width * 0.3 + 30,
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
        child: const Center(
            child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
        )),
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
