import 'package:dragon_ball_app/models/models.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final String _baseUrl = 'dbz-app-backend.herokuapp.com';
  List<CategoryElement> categories = [];
  CategoryProvider() {
    getCategories();
  }

  Future getCategories() async {
    final urlResponse = Uri.https(_baseUrl, 'v1/movie/get-categories');
    final token = await storage.read(key: 'AccessToken');
    final response = await http.get(urlResponse, headers: {
      'x-DBP-Access-Token': token!,
    });
    final categoriesResponse = Category.fromJson(response.body);
    categories = categoriesResponse.data.categories;
  }
}
