import 'package:flutter/material.dart';

import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/components/timetable/custom_cell.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class SetWeeklyTimetableView extends StatelessWidget {
  const SetWeeklyTimetableView({super.key});

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
                text: 'Set your Weekly \nTimetable',
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomText(
                text:
                    "Please input your weekly class timetable\nto help with your revision planning.",
                alignLeft: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomDivider(
                alignLeft: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FixedColumnWidth(90),
                },
                border: TableBorder.all(color: const Color(borderColor)),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color(fieldBackgroundColor),
                    ),
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                              child: Text(
                            'Monday',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )),
                        ),
                      ),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color(fieldBackgroundColor),
                    ),
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                              child: Text(
                            'Tuesday',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )),
                        ),
                      ),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color(fieldBackgroundColor),
                    ),
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                              child: Text(
                            'Wednesday',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )),
                        ),
                      ),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color(fieldBackgroundColor),
                    ),
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                              child: Text(
                            'Thursday',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )),
                        ),
                      ),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color(fieldBackgroundColor),
                    ),
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                              child: Text(
                            'Friday',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )),
                        ),
                      ),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color(fieldBackgroundColor),
                    ),
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                              child: Text(
                            'Saturday',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )),
                        ),
                      ),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Color(fieldBackgroundColor),
                    ),
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                              child: Text(
                            'Sunday',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )),
                        ),
                      ),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                      CustomCell(onPressed: () {}),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Center(
                child: CustomButton(
                  buttonText: "All set",
                  onPressed: (() {
                    Navigator.of(context).pushNamed(homepageRoute);
                  }),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: CustomTextButton(
                  text: "Skip for now",
                  onPressed: () {
                    Navigator.of(context).pushNamed(homepageRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
