import 'package:flutter/material.dart';
import 'package:recipe/registration_page/presentation_layer/login.dart';
import 'package:recipe/routes/routes.dart';
import 'package:recipe/search_screen_page/presentation_layer/searchbar.dart';
import 'package:recipe/user_account_page/user_account.dart';
import 'add_recipe_page/presentation_layer/recipe_screen.dart';
import 'home_screen_page/application_layer/page_controller.dart';
import 'home_screen_page/presentation_layer/body.dart';
import 'home_screen_page/presentation_layer/bottom_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// final searchProvider = Provider((ref) => SearchProvider());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'RecipeBox',
      theme: ThemeData.light(),
      routerDelegate: Routes.goRouter.routerDelegate,
      routeInformationParser: Routes.goRouter.routeInformationParser,
      // home: Router(routerDelegate: const GoRouter()),
    );
  }
}

class App extends ConsumerWidget {
  App({Key? key}) : super(key: key);

  final List<Widget> pages = [
    const Body(),
    const SearchBar(),
    AddRecipeScreen(),
    // const SavedRecipe(),
    const UserProfile()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);
    return Scaffold(
      body: pages[ref.read(pageControllerProvider.notifier).state],
      bottomNavigationBar: const CurvedNavigation(),
    );
  }
}
