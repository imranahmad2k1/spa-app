import 'package:flutter/material.dart';

class CustomModuleInfo extends StatelessWidget {
  final String name;
  final String text;
  const CustomModuleInfo({super.key, required this.name, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: "$name: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: text,
          ),
        ],
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }
}
