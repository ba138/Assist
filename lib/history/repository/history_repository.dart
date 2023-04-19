// import 'package:assist/Models/speech_modal.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class HistoryRepository {
//   final FirebaseAuth auth;
//   final FirebaseFirestore firestore;
//   HistoryRepository({required this.auth, required this.firestore});
//   Stream<List<SpeechModal>> getSpeechData() {
//     return firestore
//         .collection('users')
//         .doc(auth.currentUser!.uid)
//         .collection('history')
//         .snapshots()
//         .asyncMap((event) {
//       List<SpeechModal> speech = [];
//       for(var data in event)
//     });
//   }
// }
