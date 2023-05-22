import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomCell extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomCell({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Color(borderColor),
            ),
          ),
        ),
      ),
    );
  }
}
