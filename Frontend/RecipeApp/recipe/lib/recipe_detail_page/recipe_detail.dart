import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe/constant/constants.dart';
import 'package:recipe/domain_classes/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({required this.recipe, Key? key}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 360,
              decoration: BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                  image: NetworkImage(
                    '$baseUrl${recipe.photo}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.pink.shade300),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 325,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height - 325,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 8,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            recipe.recipeName,
                            style: const TextStyle(
                              fontFamily: 'delius',
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow[700],
                                  size: 30.0,
                                ),
                              ),
                              const Text(
                                '4.5',
                                style: TextStyle(
                                  fontFamily: 'delius',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'By ${recipe.ownerName}',
                          style: const TextStyle(
                              color: smallTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Instruction",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontFamily: 'delius',
                            fontWeight: FontWeight.w900,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    // Instruction Section
                    Padding(
                      padding: const EdgeInsets.only(left: 27.0, right: 17.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          recipe.instruction,
                          style: const TextStyle(
                            fontFamily: 'delius',
                            fontWeight: FontWeight.w900,
                            // fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ingredients",
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontFamily: 'delius',
                            fontWeight: FontWeight.w900,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),
                    // Ingredients Section
                    ...List.generate(
                      recipe.ingredientList.length,
                      (index) => Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 27.0),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              recipe.ingredientList[index].name,
                              style: const TextStyle(
                                fontFamily: 'delius',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
