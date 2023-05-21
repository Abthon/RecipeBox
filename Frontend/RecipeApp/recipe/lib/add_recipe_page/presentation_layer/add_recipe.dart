import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/add_recipe_page/application_layer/recipe_controller.dart';
import 'package:recipe/domain_classes/ingredient.dart';
import 'package:recipe/registration_page/application_layer/user_controller.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  File? _image;
  List<String> ingredients = [];
  final _formKey = GlobalKey<FormState>();
  String selectedOption = 'Salads'; // Default selected option

  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  TextEditingController _controller = TextEditingController();

  void addIngredient(String ingredient) {
    setState(() {
      ingredients.add(ingredient);
      _controller.clear();
    });
  }

  void removeIngredient(String ingredient) {
    setState(() {
      ingredients.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Consumer(
              builder: (context, ref, child) {
                return TextFormField(
                  onChanged: (value) => ref
                      .read(recipeControllerProvider.notifier)
                      .setRecipeName(value),
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
          SizedBox(
              child: Column(
                children: [
                  Wrap(
                    spacing: 8.0,
                    children: ingredients.map((ingredient) {
                      return InputChip(
                        label: Text(
                          ingredient,
                          style: const TextStyle(
                              fontFamily: 'delius',
                              fontWeight: FontWeight.bold),
                        ),
                        onDeleted: () => removeIngredient(ingredient),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    style: const TextStyle(
                        fontFamily: 'delius', fontWeight: FontWeight.bold),
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter your Ingridients here",
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
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => addIngredient(_controller.text),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                      child: DropdownButton<String>(
                        value: selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOption = newValue!;
                          });
                        },
                        items: <String>[
                          'Main Dishes',
                          'Breads',
                          'Soups',
                          'Snacks',
                          'Appetizers',
                          'Desserts',
                          'Salads',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontFamily: 'delius',
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return TextFormField(
                        onChanged: (value) => ref
                            .read(recipeControllerProvider.notifier)
                            .setInstruction(value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Recip Instruction must be given!";
                          }
                        },
                        maxLength: 10000,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                            fontFamily: 'delius', fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: "Enter your Instructions here",
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
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.8),
          _image == null
              ? const Text("")
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 260,
                    decoration: const BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                ),
          Consumer(
            builder: (context, ref, child) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50.0,
                child: OutlinedButton(
                  onPressed: () {
                    pickImage();

                    if (_image != null) {
                      ref
                          .read(recipeControllerProvider.notifier)
                          .setPhoto(_image);
                    }
                  },
                  child: Text(
                    'Select your Recipe image',
                    style: TextStyle(
                        fontFamily: 'delius',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50.0,
          ),
          Consumer(
            builder: (context, ref, child) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50.0,
                child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff5165EA))),
                  onPressed: () async {
                    final ingredientList = ingredients
                        .map((ingredient) => Ingredient(name: ingredient))
                        .toList();

                    if (_formKey.currentState!.validate()) {
                      // Set the ingredients
                      ref
                          .read(recipeControllerProvider.notifier)
                          .setIngredients(ingredientList);

                      // Set the category
                      ref
                          .read(recipeControllerProvider.notifier)
                          .setCategoryName(selectedOption);

                      // call the create recipe method to create the recipe in the database.
                      await ref
                          .read(recipeControllerProvider.notifier)
                          .createRecipe();
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontFamily: 'delius',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }
}
