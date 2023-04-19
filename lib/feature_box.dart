import 'package:assist/pallete.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String header;
  final String dis;
  const FeatureBox(
      {super.key,
      required this.color,
      required this.dis,
      required this.header});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Card(
        color: Pallete.thirdSuggestionBoxColor,
        shadowColor: Pallete.borderColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0).copyWith(
            left: 15,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  header,
                  style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Pallete.blackColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Text(
                  dis,
                  style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.blackColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
