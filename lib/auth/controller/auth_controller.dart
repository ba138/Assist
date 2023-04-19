import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Models/user_model.dart';
import '../repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
    authRepository: authRepository,
    ref: ref,
  );
});
final userProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.checkUser();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});
  void signUpUser(String name, String email, String password, File? profile,
      BuildContext context) {
    authRepository.signUpUser(
        name: name,
        email: email,
        profile: profile,
        context: context,
        ref: ref,
        password: password);
  }

  void signInUser(String email, String password, BuildContext context) {
    authRepository.signInUser(
      email,
      password,
      context,
    );
  }

  Future<UserModel?> checkUser() async {
    UserModel? user = await authRepository.getCurrentUser();
    return user;
  }

  Stream<UserModel> getCurrentUserData() {
    return authRepository.getUserModel();
  }

  // void signInWithGoogle(BuildContext context) {
  //   authRepository.signInWithGoogle(context);
  // }
  void logOut(BuildContext context) {
    authRepository.logOutUser(context);
  }
}
