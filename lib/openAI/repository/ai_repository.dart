import 'package:assist/Models/speech_modal.dart';
import 'package:assist/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

final aiRepositoryProvider = Provider((ref) {
  return AIRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class AIRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  AIRepository({required this.firestore, required this.auth});
  void storeSpeech(String speech, String response) async {
    try {
      var speechId = const Uuid().v1();
      var currentUserData =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      var userData = UserModel.fromMap(currentUserData.data()!);
      var speechData = SpeechModal(
          name: userData.name,
          speech: speech,
          speechId: speechId,
          response: response);
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('history')
          .doc(speechId)
          .set(
            speechData.toMap(),
          );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }
}
