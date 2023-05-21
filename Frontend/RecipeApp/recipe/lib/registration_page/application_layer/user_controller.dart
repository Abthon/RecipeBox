import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/constant/constants.dart';
import 'package:recipe/search_screen_page/data_layer/search_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain_layer/user.dart';

final userControllerProvider =
    StateNotifierProvider<UserController, User>((ref) => UserController());

class UserController extends StateNotifier<User> {
  UserController() : super(User());

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setFirstName(String firstName) {
    state = state.copyWith(firstName: firstName);
  }

  void setLastName(String lastName) {
    state = state.copyWith(lastName: lastName);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setPhoto(File profile_image) {
    state = state.copyWith(profile_image: profile_image);
  }

  Future<void> createUser() async {
    final request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}register/'));
    request.fields['user_name'] = state.username;
    request.fields['first_name'] = state.firstName;
    request.fields['last_name'] = state.lastName;
    request.fields['email'] = state.email;
    request.fields['password'] = state.password;

    if (state.profile_image != null) {
      final file = await http.MultipartFile.fromPath(
          'profile_image ', state.profile_image!.path);
      request.files.add(file);
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      print('User created successfully');
    } else {
      print('Error creating user: ${response.reasonPhrase}');
    }
  }

  Future<void> authenticateUser() async {
    final response = await http.post(
      Uri.parse('${baseUrl}login/'),
      headers: {'Content-Type': 'application/json'},
      body:
          jsonEncode({'username': state.username, 'password': state.password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      print('My token : ${body['token']}');
      // Save token to shared preferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', body['token']);
      // prefs
      //     .setString('token', body['token'])
      //     .then((value) => prefs.setString('user_name', body['user_name']));
      // prefs.setString('user_name', body['user_name']);
      // prefs.setString('first_name', body['first_name']);
      // prefs.setString('last_name', body['first_name']);
      // prefs.setString('email', body['first_name']);
    } else {
      throw Exception('Failed to authenticate user');
    }
  }
}

final userDataProvider = Provider<UserData>((ref) => UserData());

class UserData {
  Map<String, dynamic> userData = {};

  Future<Map> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('token : $token');
    final response = await http.get(
      Uri.parse('${baseUrl}user/profile/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      userData = json.decode(response.body);
      return userData;
    } else {
      return userData;
      // throw Exception('Failed to load user data');
    }
  }
}
