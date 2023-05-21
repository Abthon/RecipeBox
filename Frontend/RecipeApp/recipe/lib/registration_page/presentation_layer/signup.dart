import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/registration_page/application_layer/user_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  XFile? pickedFile;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    print("Builded");
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
                        'images/shape1.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(52.0),
                      color: Colors.black,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return CircleAvatar(
                            radius: 50.0,
                            child: GestureDetector(
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                    )
                                  : const Icon(Icons.camera_enhance_outlined),
                              onTap: () async {
                                pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  _image = File(pickedFile!.path);
                                });

                                if (pickedFile != null) {
                                  final photo = File(pickedFile!.path);
                                  ref
                                      .read(userControllerProvider.notifier)
                                      .setPhoto(photo);
                                }
                              },
                            ),
                          );
                        },
                      ),
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
                          SizedBox(
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
                                    labelText: 'Enter Your First Name',
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade600),
                                    suffix: const Icon(
                                      Icons.text_format,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onChanged: (value) => ref
                                      .read(userControllerProvider.notifier)
                                      .setFirstName(value),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "First name must not be empty";
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: Consumer(
                              builder: (context, ref, child) {
                                return Consumer(
                                  builder: (context, ref, child) {
                                    return TextFormField(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xff2827e9),
                                            width: 3.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 3.0,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff2827e9),
                                            width: 3.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: "Enter Your Last Name",
                                        labelStyle: TextStyle(
                                            color: Colors.grey.shade600),
                                        suffix: const Icon(Icons.text_format),
                                      ),
                                      onChanged: (value) => ref
                                          .read(userControllerProvider.notifier)
                                          .setLastName(value),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Last name must not be empty";
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
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
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 3.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Enter Your Email',
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade600),
                                    suffix: const Icon(
                                      Icons.alternate_email,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onChanged: (value) => ref
                                      .read(userControllerProvider.notifier)
                                      .setEmail(value),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Email must not be empty";
                                    }
                                  },
                                );
                              },
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: const <Widget>[
                                Checkbox(
                                  value: false,
                                  onChanged: null,
                                ),
                                Text('I accept RecipeBox policy and terms'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await ref
                                        .read(userControllerProvider.notifier)
                                        .createUser();
                                    GoRouter.of(context).go('/login');
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
                                      'Sign Up',
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
          child: const Icon(Icons.login),
          onPressed: () {
            GoRouter.of(context).go('/login');
          },
        ),
      ),
    );
  }
}
