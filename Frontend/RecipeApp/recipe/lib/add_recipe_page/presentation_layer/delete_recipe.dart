import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:recipe/add_recipe_page/application_layer/recipe_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteRecipe extends ConsumerWidget {
  DeleteRecipe({Key? key}) : super(key: key);
  final recipeController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Consumer(
            builder: (context, ref, child) {
              return TextFormField(
                controller: recipeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Recipe Name Must be given!";
                  }
                },
                style: const TextStyle(
                    fontFamily: 'delius', fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "Enter your Recipe name here",
                  hintStyle: const TextStyle(
                      fontFamily: 'delius',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff2827e9),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff2827e9),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              ref
                  .read(recipeControllerProvider.notifier)
                  .deleteRecipe(recipeController.text);
            },
            child: const Text(
              "Delete Recipe",
              style: TextStyle(
                  fontFamily: 'delius',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
