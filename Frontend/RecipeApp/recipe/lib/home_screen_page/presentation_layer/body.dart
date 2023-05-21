import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/constant/constants.dart';
import 'package:recipe/home_screen_page/data_layer/body_repository.dart';
import 'package:recipe/recipe_detail_page/recipe_detail.dart';
import 'package:recipe/registration_page/domain_layer/user.dart';

final selectedContainerIndexProvider = StateProvider<int>((ref) => 0);

class Body extends ConsumerWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCategoryIndex =
        ref.watch(selectedContainerIndexProvider.state);
    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder<Object>(
          future: getData(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              print("Alew data");
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer(
                                  builder: (context, ref, child) {
                                    return Text(
                                      'Hello, ${snapshot.data![0]['first_name']}',
                                      style: const TextStyle(
                                        color: smallTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'What Would you like \n to cook today?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'delius',
                                    fontSize: 26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          child: CircleAvatar(
                            radius: 25.0,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Image.network(
                                  '$baseUrl${snapshot.data![0]['profile_image']}',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    const Text(
                      "Categories",
                      style: TextStyle(
                          fontFamily: "ComicSans",
                          fontWeight: FontWeight.w900,
                          fontSize: 23.0),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ), // height: 160, width : 120 || height : 250, width : 150

                    // Category scrollable card UI
                    SizedBox(
                      height: 63,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data![2].length,
                        itemBuilder: (context, index) {
                          final category = snapshot.data![2][index];
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(selectedContainerIndexProvider.notifier)
                                  .state = index;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              margin: const EdgeInsets.only(
                                  left: 5.0,
                                  top: 10.0,
                                  right: 5.0,
                                  bottom: 7.0),
                              decoration: BoxDecoration(
                                color: currentCategoryIndex.state == index
                                    ? const Color(0xff5165EA)
                                    : Colors.grey.shade300,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                              ),
                              child: Text(
                                '${category.name}',
                                style: TextStyle(
                                    color: currentCategoryIndex.state == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: "delius",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    // Recommendation scrollable card UI

                    const Text(
                      "Recommendation",
                      style: TextStyle(
                          fontFamily: "ComicSans",
                          fontWeight: FontWeight.w900,
                          fontSize: 23.0),
                    ),

                    SizedBox(
                      // color: Colors.red,
                      height: 250,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data![1].length,
                        itemBuilder: (context, index) {
                          final recipe = snapshot.data![1][index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RecipeDetailPage(recipe: recipe),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 140,
                                    margin: const EdgeInsets.only(
                                        left: 10.0,
                                        top: 20.0,
                                        right: 10.0,
                                        bottom: 7.0),
                                    decoration: const BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                          '$baseUrl${recipe.photo}',
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  child: Text(
                                    '${recipe.recipeName}',
                                    style: const TextStyle(
                                        fontFamily: "ComicSans",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15.0),
                                  ),
                                  padding: const EdgeInsets.only(left: 13.0)),
                              Padding(
                                  child: Text(
                                    'By ${recipe.ownerName}',
                                    style: const TextStyle(
                                        fontFamily: "ComicSans",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14.0,
                                        color: smallTextColor),
                                  ),
                                  padding: const EdgeInsets.only(left: 13.0))
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 2) - 50),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
