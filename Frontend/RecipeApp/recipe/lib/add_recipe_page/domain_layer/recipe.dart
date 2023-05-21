import 'dart:io';

import 'package:recipe/domain_classes/ingredient.dart';

class Recipe {
  Recipe(
      {this.recipeName = '',
      this.category = '',
      this.ingredients,
      this.instruction = '',
      this.photo});

  final String recipeName;
  final String category;
  final List<Ingredient>? ingredients;
  final String instruction;
  final File? photo;

  Recipe copyWith({
    String? recipeName,
    String? category,
    List<Ingredient>? ingredients,
    String? instruction,
    File? photo,
  }) {
    return Recipe(
      recipeName: recipeName ?? this.recipeName,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      instruction: instruction ?? this.instruction,
      photo: photo ?? this.photo,
    );
  }
}
