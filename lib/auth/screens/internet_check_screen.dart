import 'package:flutter/material.dart';

class CheckInternet extends StatelessWidget {
  const CheckInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Please check Your Internet or Restart the App!',
          style: TextStyle(
            fontFamily: 'Cera Pro',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
