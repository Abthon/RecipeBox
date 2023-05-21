import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/constant/constants.dart';
import 'package:recipe/domain_classes/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/registration_page/domain_layer/user.dart';

final searchRepositoryProvider =
    Provider<SearchRepository>((ref) => SearchRepository());

final container = ProviderContainer();

class SearchRepository {
  Future<List<Recipe>> fetchRecipeById(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}recipe/$id/'));
    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data =
          jsonDecode(response.body).cast<Map<String, dynamic>>();
      final listOfRecipe = data.map((data) => Recipe.fromJson(data));
      return listOfRecipe.toList();
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  // 10.0.2.2 --> Emulator IpAddress
  Future<List<Recipe>> fetchRecipeByName(String name) async {
    final response = await http.get(
      Uri.parse(
        '${baseUrl}recipe/$name/',
      ),
      headers: {
        'Authorization': 'Token ${container.read(tokenProvider).token}',
      },
    );
    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data =
          jsonDecode(response.body).cast<Map<String, dynamic>>();
      final listOfRecipe = data.map((data) => Recipe.fromJson(data));
      return listOfRecipe.toList();
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  Future<List<Recipe>> fetchAllRecipes() async {
    final response = await http.get(
      Uri.parse('${baseUrl}listRecipe/'),
      headers: {
        'Authorization': 'Token ${container.read(tokenProvider).token}',
      },
    );
    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data =
          jsonDecode(response.body).cast<Map<String, dynamic>>();
      final listOfRecipe = data.map((data) => Recipe.fromJson(data));
      return listOfRecipe.toList();
    } else {
      throw Exception('Failed to load recipe');
    }
  }
}
