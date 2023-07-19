import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/end_study_button.dart';
import 'package:student_personal_assistant/components/recommendations/revise_carousel_slider.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class ReviseRecommendedTopicsView extends StatelessWidget {
  const ReviseRecommendedTopicsView({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = ModalRoute.of(context)!.settings.arguments
        as Map<String, Map<String, List<String>>>;
    final subjectTopicDropdowns = routes["subjectTopicDropdowns"];
    print("TEST: $subjectTopicDropdowns");

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 83),
                    CustomHeading(text: "Revision of\nTopics"),
                    SizedBox(height: 15),
                    CustomText(
                      text:
                          "Keep the momentum going!\nRevisit today's topics for solid understanding:",
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
                    ReviseCarouselSliderComponent(
                      subjectTopicDropdowns: subjectTopicDropdowns!,
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: EndStudyButton(onPressed: () {
                        Navigator.of(context).pushNamed(homepageRoute);
                      }),
                    ),
                    // SizedBox(height: 200)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
