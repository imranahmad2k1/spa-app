import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_topic_dropdown.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class SelectSubjectTopicsView extends StatefulWidget {
  const SelectSubjectTopicsView({super.key});

  @override
  State<SelectSubjectTopicsView> createState() =>
      _SelectSubjectTopicsViewState();
}

class _SelectSubjectTopicsViewState extends State<SelectSubjectTopicsView> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'Select subject';

    // List of items in our dropdown menu
    var items = [
      'Select subject',
      'Subject 1',
      'Subject 2',
      'Subject 3',
      'Subject 4',
      'Subject 5',
    ];
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 83),
            const CustomHeading(text: "Select subject and\ntopics"),
            const SizedBox(height: 15),
            const CustomText(
              text:
                  "Choose a subject for the quiz/test and\nselect the topics included in the assessment\nto receive smart recommendations based\non your weaknesses.",
              alignLeft: true,
            ),
            const SizedBox(height: 20),
            const CustomDivider(alignLeft: true),
            const SizedBox(height: 14),
            const Text(
              "Choose subject",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(borderColor)),
                borderRadius: BorderRadius.circular(3.0),
                color: const Color(fieldBackgroundColor),
              ),
              child: DropdownButtonHideUnderline(
                child: SizedBox(
                  height: 37,
                  child: DropdownButton(
                    value: dropdownvalue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Container(
                          // width: 230,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Color(fieldUnselectedTextColor),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Select all topics included in quiz:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const CustomTopicDropdown(),
            const CustomTopicDropdown(),
            const CustomTopicDropdown(),
            const SizedBox(height: 140),
            Center(
              child: CustomButton(
                buttonText: "Recommend Topics",
                onPressed: () {
                  Navigator.of(context).pushNamed(recommendRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
