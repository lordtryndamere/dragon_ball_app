// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

class Category {
  Category({
    required this.code,
    required this.message,
    required this.status,
    required this.data,
  });

  int code;
  String message;
  bool status;
  Data data;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        code: json["code"],
        message: json["message"],
        status: json["status"],
        data: Data.fromMap(json["data"]),
      );
}

class Data {
  Data({
    required this.categories,
  });

  List<CategoryElement> categories;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromMap(x))),
      );
}

class CategoryElement {
  CategoryElement({
    required this.id,
    required this.name,
    required this.description,
    required this.imgCategory,
    required this.status,
    required this.createAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String name;
  String description;
  String imgCategory;
  String status;
  DateTime createAt;
  DateTime updatedAt;
  int v;

  factory CategoryElement.fromJson(String str) =>
      CategoryElement.fromMap(json.decode(str));

  factory CategoryElement.fromMap(Map<String, dynamic> json) => CategoryElement(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        imgCategory: json["imgCategory"],
        status: json["status"],
        createAt: DateTime.parse(json["create_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );
}
