import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class StudyView extends StatelessWidget {
  const StudyView({super.key});

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
            text: 'Study',
          ),
          const SizedBox(
            height: 15,
          ),
          const CustomText(
            text:
                'Explore new subjects and topics \nbased on your areas of improvement.',
            alignLeft: false,
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomDivider(
            alignLeft: false,
          ),
          const SizedBox(
            height: 44,
          ),
          const CustomText(
            text:
                'Let\'s dive deeper into the subjects you\'re most \ninterested in and make your study sessions \nmore focused and productive.',
            alignLeft: true,
          ),
          const SizedBox(
            height: 14,
          ),
          CustomButton(
              buttonText: "Start studying subject-wise",
              onPressed: () {
                Navigator.of(context).pushNamed(recommendSubjectsRoute);
              }),
          const SizedBox(
            height: 35,
          ),
          const CustomText(
            text:
                'Let\'s focus on improving your overall academic \nperformance in all subjects and make your \nstudy sessions effective.',
            alignLeft: true,
          ),
          const SizedBox(
            height: 14,
          ),
          CustomButton(
              buttonText: "Start studying overall",
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(recommendRoute, (_) => false);
              }),
        ],
      ),
    );
  }
}
