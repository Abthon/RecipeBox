import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:recipe/constant/constants.dart';
import 'package:recipe/domain_classes/recipe.dart';
import 'package:recipe/recipe_detail_page/recipe_detail.dart';
import 'package:recipe/search_screen_page/data_layer/search_repository.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<Recipe>? _recipes;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final height = MediaQuery.of(context).size.height;

    return Consumer(
      builder: (context, ref, child) => FloatingSearchBar(
        backdropColor: Colors.white70,
        queryStyle: const TextStyle(
          fontSize: 16,
          fontFamily: "delius",
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.green,
        hint: 'Search...',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        onSubmitted: (query) async {
          final data =
              await ref.read(searchRepositoryProvider).fetchRecipeByName(query);
          setState(() {
            _recipes = data;
          });
        },
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return _recipes != null
              ? SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: _recipes!.length,
                    itemBuilder: (context, index) {
                      final recipe = _recipes![index];
                      return Container(
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RecipeDetailPage(recipe: recipe),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(recipe.recipeName,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ComicSans")),
                            subtitle: Text(
                              'By ' + recipe.ownerName,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: smallTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {}),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Text("");
        },
      ),
    );
  }
}
