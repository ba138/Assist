// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:assist/utills/loader_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'History',
          style: TextStyle(
            fontFamily: 'Cera Pro',
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('history')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No History to show'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var data = snapshot.data!.docs[index];
                  String url = data['response'];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Me : ' + data['speech'],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            url.contains('https')
                                ? Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(url),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Text(
                                    'Assist : ' + data['response'],
                                  ),
                          ]),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
