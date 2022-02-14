import 'package:dragon_ball_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key, this.isTab = false}) : super(key: key);
  final bool isTab;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        top: false,
        child: CustomScrollView(slivers: [
          if (!isTab)
            const SliverAppBar(
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(Icons.search))
              ],
              pinned: false,
              floating: false,
              title: CustomLayoutAppBar(),
            ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: const <Widget>[
                _CustomMovieSwiper(),
                SizedBox(
                  height: 20,
                ),
                _MovieSlider(),
                _MovieSlider(),
                _MovieSlider(),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ]))
        ]),
      ),
    );
  }
}

class _MovieSlider extends StatelessWidget {
  const _MovieSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // siempre a mi container main ponerle width infinito
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: double.infinity,
      height: size.height * 0.3 - 18,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Populares',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: size.height * 0.1 - 65)),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, index) => const _CustomMoviePoster(),
            itemCount: 10,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ]),
    );
  }
}

class _CustomMoviePoster extends StatelessWidget {
  const _CustomMoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            image: const NetworkImage(
                'https://m.media-amazon.com/images/I/81JeO4NCCQL._SL1435_.jpg'),
            placeholder: const AssetImage('assets/loading.gif'),
            width: size.width * 0.3,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _CustomMovieSwiper extends StatelessWidget {
  const _CustomMovieSwiper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      // color: Colors.green,
      child: Swiper(
        fade: 5,
        onTap: (i) {},
        autoplay: true,
        autoplayDelay: 4000,
        autoplayDisableOnInteraction: true,
        itemBuilder: (context, index) {
          return ClipRRect(
              //Me permite hacer un border radius
              borderRadius: BorderRadius.circular(10),
              child: const FadeInImage(
                image: NetworkImage(
                    'https://i.pinimg.com/originals/83/76/e6/8376e696f8d142aab319602d36a36175.jpg'),
                placeholder: AssetImage('assets/loading.gif'),
                fit: BoxFit.cover,
              ));
        },
        itemWidth: size.width * 0.8,
        itemHeight: size.height * 0.4,
        layout: SwiperLayout.STACK,
        itemCount: 1,
      ),
    );
  }
}
