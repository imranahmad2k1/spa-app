import 'package:flutter/material.dart';

class CustomCell extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomCell({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
