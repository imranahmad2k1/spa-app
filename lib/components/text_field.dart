import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final String labelText;

  const CustomTextField({super.key, this.width, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      width: width ?? double.infinity,
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
