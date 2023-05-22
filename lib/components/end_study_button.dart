import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class EndStudyButton extends StatelessWidget {
  final VoidCallback onPressed;
  const EndStudyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Ink(
        width: 153,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(secondaryColor),
        ),
        child: const Center(
          child: Text(
            "End study session",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
