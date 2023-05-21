import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/constant/constants.dart';
import 'package:recipe/domain_classes/category.dart';
import 'package:recipe/registration_page/application_layer/user_controller.dart';
import 'package:recipe/search_screen_page/data_layer/search_repository.dart';
import 'package:http/http.dart' as http;

final container =
    ProviderContainer(); // For accessing any provider staying with in a plain class that doesn't inherit from anything
Future<List<dynamic>> getData() async {
  final futureUser = container
      .read(userDataProvider)
      .fetchUserData(); // a function that returns current user data

  final futureRecipe = container
      .read(searchRepositoryProvider)
      .fetchAllRecipes(); // a function that returns all the recipes

  final futureCategory = container
      .read(categoryProvider)
      .fetchAllCategories(); // a function that returns all the categories

  final results = await Future.wait([futureUser, futureRecipe, futureCategory]);

  // results[0] will contain user data and results[1] will contain recipe data
  return results;
}

final categoryProvider = Provider((ref) => CategoryData());

class CategoryData {
  Future<List<Category>> fetchAllCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}listCategories/'));
    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data =
          jsonDecode(response.body).cast<Map<String, dynamic>>();
      final listOfCategory = data.map((data) => Category(name: data['name']));
      return listOfCategory.toList();
    } else {
      throw Exception('Failed to load category');
    }
  }
}
