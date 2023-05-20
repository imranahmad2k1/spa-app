import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String text;
  const CustomHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
