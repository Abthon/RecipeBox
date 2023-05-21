import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  User({
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.profile_image,
  });

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final File? profile_image;

  User copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    File? profile_image,
  }) {
    return User(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      profile_image: profile_image ?? this.profile_image,
    );
  }
}

final tokenProvider = Provider((ref) => UserToken());

class UserToken {
  UserToken() {
    final spf = SharedPreferences.getInstance();
    spf.then((instance) {
      token = instance.getString('token');
    });
  }
  dynamic token;
}
