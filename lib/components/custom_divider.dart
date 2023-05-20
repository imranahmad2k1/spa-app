import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomDivider extends StatelessWidget {
  final bool? alignLeft;
  const CustomDivider({super.key, this.alignLeft});

  @override
  Widget build(BuildContext context) {
    double indent;
    double endIndent;
    if (alignLeft == true) {
      indent = 0;
      endIndent = 90;
    } else {
      indent = 45;
      endIndent = 45;
    }
    return Divider(
      color: const Color(dividerColor),
      height: 11,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
