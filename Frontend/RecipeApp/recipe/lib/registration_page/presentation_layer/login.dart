import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe/home_screen_page/application_layer/page_controller.dart';
import 'package:recipe/registration_page/application_layer/user_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: 600,
                      child: Image.asset(
                        'images/shape2.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          IntrinsicHeight(
                            child: SizedBox(
                              width: 300,
                              child: Consumer(
                                builder: (context, ref, child) {
                                  return TextFormField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xff2827e9),
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xff2827e9),
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: 'Enter Your UserName',
                                      labelStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      suffix: const Icon(
                                        Icons.text_format,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onChanged: (value) => ref
                                        .read(userControllerProvider.notifier)
                                        .setUsername(value),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "User name must not be empty";
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          IntrinsicHeight(
                            child: SizedBox(
                              width: 300,
                              child: Consumer(
                                builder: (context, ref, child) {
                                  return TextFormField(
                                    autofocus: true,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xff2827e9),
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xff2827e9),
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: 'Enter Your Password',
                                      labelStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      suffix: const Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onChanged: (value) => ref
                                        .read(userControllerProvider.notifier)
                                        .setPassword(value),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password must not be empty";
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Consumer(
                                builder: (context, ref, child) {
                                  return TextButton(
                                    child: const Text('Forgot Password?'),
                                    onPressed: () {},
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await ref
                                        .read(userControllerProvider.notifier)
                                        .authenticateUser();
                                    GoRouter.of(context).go('/home');
                                    ref
                                        .read(pageControllerProvider.notifier)
                                        .setPage(0);
                                    print("arrived here");
                                  }
                                },
                                child: Container(
                                  width: 150,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xff5165ea),
                                          Color(0xff2827e9)
                                        ]),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Log In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.logout_outlined),
          onPressed: () {
            GoRouter.of(context).go('/signUp');
          },
        ),
      ),
    );
  }
}
