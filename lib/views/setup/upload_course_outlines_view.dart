import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/outlines/dropdown_outline.dart';

class UploadCourseOutlinesView extends StatelessWidget {
  const UploadCourseOutlinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 91,
              ),
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
              const CustomOutline(),
              const CustomOutline(),
              const CustomOutline(),
              const CustomOutline(),
              const CustomOutline(),
              const CustomOutline(),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CustomButton(
                  buttonText: "Set outlines",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
