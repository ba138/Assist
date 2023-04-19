import 'dart:io';

import 'package:assist/auth/controller/auth_controller.dart';
import 'package:assist/auth/screens/login_screen.dart';
import 'package:assist/openAI/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../commom_widgets.dart/utills.dart';
import '../../pallete.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  File? image;
  bool isSpinn = false;
  bool isLoading = false;
  void pickImage() async {
    setState(() async {
      image = await pickImageFromGallery(context);
    });
  }

  void createUser() {
    ref.watch(authControllerProvider).signUpUser(nameController.text,
        emailController.text, passwordController.text, image, context);
  }

  // void signInWithGoogle() {
  //   ref.watch(authControllerProvider).signInWithGoogle(context);
  // }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isSpinn,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(children: [
                Stack(
                  children: [
                    Center(
                      child: image == null
                          ? const CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://nakedsecurity.sophos.com/wp-content/uploads/sites/2/2013/08/facebook-silhouette_thumb.jpg',
                              ),
                              radius: 64,
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(
                                image!,
                              ),
                              radius: 64,
                            ),
                    ),
                    Positioned(
                      bottom: 4,
                      left: 80,
                      child: IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: pickImage,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Pallete.borderColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Pallete.borderColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Pallete.borderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Create Your Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSpinn = true;
                    });
                    createUser();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const HomePage(),
                        ),
                        (route) => false);
                    setState(() {
                      isSpinn = false;
                    });
                  },
                  child: Container(
                    height: 54,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Pallete.thirdSuggestionBoxColor),
                    child: const Center(
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cera Pro'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have Account ? ',
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'LogIn',
                        style: TextStyle(
                          fontFamily: 'Cera Pro',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
