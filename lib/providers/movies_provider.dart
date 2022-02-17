import 'dart:convert';

import 'package:dragon_ball_app/helpers/debouncer.dart';
import 'package:dragon_ball_app/models/models.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  MoviesProvider() {
    getAllMovies();
  }
  final String _baseUrl = 'dbz-app-backend.herokuapp.com';
  final Debouncer debouncer =
      Debouncer(duration: const Duration(milliseconds: 100));
  List<Movie> moviesByCategory = [];
  List<Movie> initalMovies = [];
  List<Movie> resultSearch = [];

  final StreamController<List<Movie>> _moviesByCategoryController =
      StreamController.broadcast();

  Stream<List<Movie>> get byCategoryStream =>
      _moviesByCategoryController.stream;

  final StreamController<List<Movie>> _moviesByFilterStream =
      StreamController.broadcast();

  Stream<List<Movie>> get byFilterStream => _moviesByFilterStream.stream;

  Future _getJsonData(String endPoint, bool isSearch,
      [String filter = "", String categoryId = " "]) async {
    final urlResponse = isSearch
        ? Uri.https(_baseUrl, endPoint)
        : Uri.https(_baseUrl, '$endPoint/$categoryId');
    print(urlResponse);
    final token = await storage.read(key: 'AccessToken');

    final response = isSearch
        ? await http.post(urlResponse,
            body: json.encode({'filter': filter}),
            headers: {
                'x-DBP-Access-Token': token!,
                'Content-Type': 'application/json'
              })
        : await http.get(urlResponse, headers: {'x-DBP-Access-Token': token!});
    return response.body;
  }

  Future searchMovies(String query) async {
    final response = await _getJsonData('/v1/movie/get-movies', true, query);
    final searchResponse = DataResponse.fromJson(response);
    resultSearch = [...searchResponse.data.movies];
    Future.delayed(const Duration(milliseconds: 1000));
    return searchResponse.data;
  }

  getAllMovies() async {
    if (initalMovies.isNotEmpty) {
      initalMovies = [...initalMovies];
    }
    final response = await _getJsonData('/v1/movie/get-movies', true, "");
    final allMoviesResponse = DataResponse.fromJson(response);
    initalMovies = allMoviesResponse.data.movies;
    notifyListeners();
  }

  Future<List<Movie>> findByCategory(String categoryId) async {
    final response =
        await _getJsonData('/v1/movie/get-by-category', false, "", categoryId);
    final searchResponse = DataResponse.fromJson(response);
    return searchResponse.data.movies;
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);

      _moviesByFilterStream.add(results.movies);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((__) => timer.cancel());
  }
}
