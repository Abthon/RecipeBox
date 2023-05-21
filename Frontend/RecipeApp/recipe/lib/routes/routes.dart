import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/home_screen_page/presentation_layer/body.dart';
import 'package:recipe/recipe_detail_page/recipe_detail.dart';
import 'package:recipe/registration_page/presentation_layer/login.dart';
import 'package:recipe/registration_page/presentation_layer/signup.dart';
import '../main.dart';

class Routes {
  static final goRouter = GoRouter(
    initialLocation: '/signUp',
    routes: [
      GoRoute(
        path: '/signUp',
        pageBuilder: (context, state) => const MaterialPage(child: SignUp()),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
      GoRoute(path: '/home', builder: (context, state) => App())
    ],
  );
}
