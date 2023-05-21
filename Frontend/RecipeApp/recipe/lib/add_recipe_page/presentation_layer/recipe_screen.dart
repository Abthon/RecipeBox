import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:recipe/add_recipe_page/presentation_layer/add_recipe.dart';
import 'package:recipe/add_recipe_page/presentation_layer/delete_recipe.dart';

final tabIndexProvider = StateProvider<int>((ref) => 0);

class AddRecipeScreen extends ConsumerWidget {
  @override
  build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabIndexProvider.state);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'RecipeBox',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'delius',
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ref.read(tabIndexProvider.notifier).state = 0;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: tabIndex.state == 0
                                ? const Color(0xff5165EA)
                                : Colors.grey[350],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            "Add Recipe",
                            style: TextStyle(
                                fontFamily: 'delius',
                                fontWeight: FontWeight.bold,
                                color: tabIndex.state == 0
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ref.read(tabIndexProvider.notifier).state = 1;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: tabIndex.state == 1
                                ? const Color(0xff5165EA)
                                : Colors.grey[350],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            "Delete Recipe",
                            style: TextStyle(
                                fontFamily: 'delius',
                                fontWeight: FontWeight.bold,
                                color: tabIndex.state == 1
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35.0,
                ),
                tabIndex.state == 0 ? AddRecipe() : DeleteRecipe()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
