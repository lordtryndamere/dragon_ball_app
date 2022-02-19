// To parse this JSON data, do
//
//     final dataResponse = dataResponseFromMap(jsonString);

import 'dart:convert';

class DataResponse {
  DataResponse({
    required this.code,
    required this.message,
    required this.status,
    required this.data,
  });

  int code;
  String message;
  bool status;
  DataContain data;

  factory DataResponse.fromJson(String str) =>
      DataResponse.fromMap(json.decode(str));

  factory DataResponse.fromMap(Map<String, dynamic> json) => DataResponse(
        code: json["code"],
        message: json["message"],
        status: json["status"],
        data: DataContain.fromMap(json["data"]),
      );
}

class DataContain {
  DataContain({
    required this.movies,
  });

  List<Movie> movies;

  factory DataContain.fromJson(String str) =>
      DataContain.fromMap(json.decode(str));

  factory DataContain.fromMap(Map<String, dynamic> json) => DataContain(
        movies: List<Movie>.from(json["movies"].map((x) => Movie.fromMap(x))),
      );
}

class Movie {
  Movie({
    required this.name,
    required this.sinopsis,
    required this.posterImg,
    required this.status,
    required this.videoUri,
    required this.categoryId,
    required this.categoryName,
    required this.categoryStatus,
  });

  String name;
  String sinopsis;
  String posterImg;
  String status;
  String videoUri;
  String categoryId;
  String categoryName;
  String categoryStatus;
  String? heroId;

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        name: json["name"],
        sinopsis: json["sinopsis"],
        posterImg: json["posterImg"],
        status: json["status"],
        videoUri: json["videoUri"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        categoryStatus: json["categoryStatus"],
      );
}
