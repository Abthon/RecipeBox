import 'package:recipe/domain_classes/category.dart';
import 'package:recipe/domain_classes/ingredient.dart';

class Recipe {
  Recipe({
    required this.id,
    required this.ownerName,
    required this.recipeName,
    required this.category,
    required this.instruction,
    required this.photo,
    required this.ingredientList,
  });

  final String id;
  final String ownerName;
  final String recipeName;
  final String category;
  final String instruction;
  final String photo;
  final List<Ingredient> ingredientList;

  factory Recipe.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    final ownerName = data['owner'];
    final recipeName = data['name'];
    final category = data['category'];
    final instruction = data['instruction'];
    final photo = data['photo'];
    final ingredientList = List<Ingredient>.from(
        data['ingredients'].map((name) => Ingredient(name: name)));

    return Recipe(
        id: id,
        ownerName: ownerName,
        recipeName: recipeName,
        category: category,
        instruction: instruction,
        photo: photo,
        ingredientList: ingredientList);
  }
}
