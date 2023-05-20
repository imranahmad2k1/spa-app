import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final String labelText;
  final bool? obscureText;

  const CustomTextField(
      {super.key, this.width, required this.labelText, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      width: width ?? double.infinity,
      child: TextField(
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
