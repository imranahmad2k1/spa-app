import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/end_study_button.dart';
import 'package:student_personal_assistant/components/recommendations/carousel_slider.dart';
// import 'package:student_personal_assistant/constants/routes.dart';

class RecommendedTopicsView extends StatefulWidget {
  const RecommendedTopicsView({super.key});

  @override
  State<RecommendedTopicsView> createState() => _RecommendedTopicsViewState();
}

class _RecommendedTopicsViewState extends State<RecommendedTopicsView> {
  @override
  Widget build(BuildContext context) {
    // final routes =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    // final subject = routes["subject"];
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
                    CustomHeading(text: "Recommended\nTopics"),
                    SizedBox(height: 15),
                    CustomText(
                      text:
                          "Here are your recommended topics\nbased on your weaknesses:",
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
                      child: EndStudyButton(onPressed: () {
                        // print(subject);
                        // Navigator.of(context).pushNamed(homepageRoute);
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
