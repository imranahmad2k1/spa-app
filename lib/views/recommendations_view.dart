import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/end_study_button.dart';
import 'package:student_personal_assistant/components/recommendations/carousel_slider.dart';

class RecommendationsView extends StatelessWidget {
  const RecommendationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 83),
            const CustomHeading(text: "Recommended Topics"),
            const SizedBox(height: 15),
            const CustomText(
              text:
                  "Here are your recommended topics\nbased on your weaknesses:",
              alignLeft: true,
            ),
            const SizedBox(height: 20),
            const CustomDivider(alignLeft: true),
            const SizedBox(height: 35),
            //PUT CAROUSEL HERE
            CarouselSliderComponent(),
            const SizedBox(height: 35),
            Center(
              child: EndStudyButton(onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
