import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class QuizTestView extends StatelessWidget {
  const QuizTestView({super.key});

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
            text: 'Quiz/Test',
          ),
          const SizedBox(
            height: 15,
          ),
          const CustomText(
            text:
                'Get ready for upcoming quizzes or tests \nby focusing on recommended topics.',
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
              buttonText: 'Start quiz or test preparation',
              onPressed: () {
                Navigator.of(context).pushNamed(selectSubjectTopicsRoute);
              }),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
