import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/outlines/dropdown_outline.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class UploadCourseOutlinesView extends StatelessWidget {
  // final List<String> subjectNames;
  const UploadCourseOutlinesView({super.key});

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context)!.settings.arguments as Map<String, List<String>>;
    final subjectNames = routes["subjectNames"];

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 91,
                  // ),
                  const CustomHeading(
                    text: 'Upload your Course\nOutlines',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    text:
                        "Upload or select your course outlines\nform the dropdown to personalize\nyour study recommendations",
                    alignLeft: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomDivider(
                    alignLeft: true,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: subjectNames!.length,
                    itemBuilder: (context, index) {
                      return const CustomOutline();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: CustomButton(
                      buttonText: "Set outlines",
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            homepageRoute, (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
