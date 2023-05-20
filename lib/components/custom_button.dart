import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool? isSecondary;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isSecondary,
  });

  @override
  Widget build(BuildContext context) {
    int buttonColor;
    Color textColor;
    FontWeight? textWeight;
    bool secondaryButton = isSecondary ?? false;
    if (secondaryButton) {
      buttonColor = secondaryColor;
      textColor = Colors.black;
      textWeight = FontWeight.normal;
    } else {
      buttonColor = primaryColor;
      textColor = Colors.white;
      textWeight = FontWeight.bold;
    }

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        width: 268,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(buttonColor),
        ),
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            fontWeight: textWeight,
          ),
        )),
      ),
    );
  }
}
