import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class ReviseView extends StatelessWidget {
  const ReviseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 121,
          ),
          const CustomHeading(
            text: 'Revise',
          ),
          const SizedBox(
            height: 15,
          ),
          const CustomText(
            text:
                'Review what you have studied today \nand set understanding level',
            alignLeft: false,
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomDivider(
            alignLeft: false,
          ),
          const SizedBox(
            height: 156,
          ),
          CustomButton(
              buttonText: 'Let\'s start Revision',
              onPressed: () {
                Navigator.of(context).pushNamed(recommendRoute);
              }),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
