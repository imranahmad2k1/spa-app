import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/recommendations/carousel_slider.dart';

class RecommendedSubjectsView extends StatelessWidget {
  const RecommendedSubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 83),
                CustomHeading(text: "Recommended\nSubjects"),
                SizedBox(height: 15),
                CustomText(
                  text:
                      "All subjects are recommended based on your\nweaknesses.\nChoose subject of your interest",
                  alignLeft: true,
                ),
                SizedBox(height: 20),
                CustomDivider(alignLeft: true),
                SizedBox(height: 35),
              ],
            ),
            Column(
              children: [
                //CAROUSEL HERE
                CarouselSliderComponent(),
                const SizedBox(height: 35),
                Center(
                  child: CustomButton(buttonText: "Next", onPressed: () {}),
                ),
                // SizedBox(height: 200)
              ],
            )
          ],
        ),
      ),
    );
  }
}