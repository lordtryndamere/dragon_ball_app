import 'package:dragon_ball_app/models/movie.dart';
import 'package:dragon_ball_app/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar peliculas ...';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final movies = moviesProvider.resultSearch;
    if (movies.isEmpty) {
      return _emptyContainerResults();
    }
    return ListView.builder(
      itemBuilder: (context, index) => _SearchItem(movie: movies[index]),
      itemCount: movies.length,
    );
  }

  Widget _emptyContainer() {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Opacity(
            opacity: 0.6,
            child: Image(
              width: 160,
              height: 160,
              image: AssetImage('assets/iconZ.png'),
              fit: BoxFit.contain,
            )),
      ),
    );
  }

  Widget _emptyContainerResults() {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Opacity(
            opacity: 0.6,
            child: Image(
              width: 160,
              height: 160,
              image: AssetImage('assets/notresults.png'),
              fit: BoxFit.contain,
            )),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionByQuery(query);
    return StreamBuilder(
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: movies.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) =>
                      _SearchItem(movie: movies[index]),
                  itemCount: movies.length)
              : _emptyContainerResults(),
        );
      },
      stream: moviesProvider.byFilterStream,
    );
  }
}

class _SearchItem extends StatelessWidget {
  const _SearchItem({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search${movie.name}';
    return ListTile(
      leading: Hero(
          tag: movie.heroId!,
          child: FadeInImage(
            image: NetworkImage(movie.posterImg),
            placeholder: const AssetImage('assets/loading.gif'),
            width: 100,
            height: 50,
            fit: BoxFit.cover,
          )),
      title: Text(
        movie.name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(movie.categoryName),
      onTap: () =>
          Navigator.pushNamed(context, 'movies-detail', arguments: movie),
    );
  }
}
