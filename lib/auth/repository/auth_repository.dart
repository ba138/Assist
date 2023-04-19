import 'dart:io';
import 'package:assist/auth/screens/login_screen.dart';
import 'package:assist/openAI/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Models/user_model.dart';
import '../../common_firebase_storage.dart';

final authRepositoryProvider = Provider(
  (ref) {
    return AuthRepository(
      auth: FirebaseAuth.instance,
      fireStore: FirebaseFirestore.instance,
    );
  },
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;

  AuthRepository({
    required this.auth,
    required this.fireStore,
  });
  // signInWithGoogle(BuildContext context) async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     UserCredential userCredential =
  //         await auth.signInWithCredential(credential);
  //     User? user = userCredential.user;
  //     if (user != null) {
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         await fireStore.collection('users').doc(user.uid).set({
  //           'name': user.displayName,
  //           'email': user.email,
  //           'profilePic': user.photoURL,
  //           'uid': user.uid,
  //         });
  //       }
  //     }
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (c) => const HomePage(),
  //         ),
  //         (route) => false);
  //   } catch (e) {
  //     return Fluttertoast.showToast(
  //       msg: e.toString(),
  //     );
  //   }
  // }

  Future<UserModel?> getCurrentUser() async {
    var currentUser =
        await fireStore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (currentUser.data() != null) {
      user = UserModel.fromMap(currentUser.data()!);
    }
    return user;
  }

  void signInUser(String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          // ignore: prefer_const_constructors
          MaterialPageRoute(builder: (c) => const HomePage()),
          (route) => false);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void signUpUser({
    required String name,
    required String email,
    required File? profile,
    required BuildContext context,
    required ProviderRef ref,
    required String password,
  }) async {
    try {
      String photourl =
          'https://nakedsecurity.sophos.com/wp-content/uploads/sites/2/2013/08/facebook-silhouette_thumb.jpg';

      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = auth.currentUser!.uid;
      if (profile != null) {
        photourl = await ref
            .read(commonFirebaseStorageProvider)
            .storeFileFileToFirebase('profilPic/$uid', profile);
      }
      var userData = UserModel(
        name: name,
        uid: uid,
        profilePic: photourl,
        email: email,
      );
      await fireStore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(userData.toMap());
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  Stream<UserModel> getUserModel() {
    return fireStore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  void logOutUser(BuildContext context) async {
    await auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const LoginScreen()),
        (route) => false);
  }
}
