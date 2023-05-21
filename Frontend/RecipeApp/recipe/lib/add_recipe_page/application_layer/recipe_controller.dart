import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/add_recipe_page/domain_layer/recipe.dart';
import 'package:recipe/constant/constants.dart';
import 'package:recipe/domain_classes/ingredient.dart';
import 'package:recipe/registration_page/domain_layer/user.dart';
import 'package:recipe/search_screen_page/data_layer/search_repository.dart';

final recipeControllerProvider =
    StateNotifierProvider<RecipeController, Recipe>(
        (ref) => RecipeController());

class RecipeController extends StateNotifier<Recipe> {
  RecipeController() : super(Recipe());

  void setRecipeName(String recipeName) {
    state = state.copyWith(recipeName: recipeName);
  }

  void setCategoryName(String category) {
    state = state.copyWith(category: category);
  }

  void setIngredients(List<Ingredient> ingredients) {
    state = state.copyWith(ingredients: ingredients);
  }

  void setInstruction(String instruction) {
    state = state.copyWith(instruction: instruction);
  }

  void setPhoto(File? photo) {
    state = state.copyWith(photo: photo);
  }

  Future<void> createRecipe() async {
    List<String> ingredients =
        state.ingredients!.map((obj) => obj.name).toList();
    var jsonData = jsonEncode(ingredients);
    final request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}listRecipe/'));
    request.headers['Authorization'] =
        'Token ${container.read(tokenProvider).token}';
    request.fields['name'] = state.recipeName;
    request.fields['category'] = state.category;
    request.fields['ingredients'] = jsonData;
    request.fields['instruction'] = state.instruction;

    if (state.photo != null) {
      final file =
          await http.MultipartFile.fromPath('photo', state.photo!.path);
      request.files.add(file);
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      print('Recipe created successfully');
    } else {
      print('Error creating Recipe: ${response.reasonPhrase}');
    }
  }

  Future<void> deleteRecipe(String? recipeName) async {
    final response = await http.post(
      Uri.parse('${baseUrl}recipe/delete/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${container.read(tokenProvider).token}',
      },
      body: jsonEncode({'recipeName': recipeName}),
    );
  }
}
