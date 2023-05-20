import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(dividerColor),
      height: 11,
      indent: 45,
      endIndent: 45,
    );
  }
}
