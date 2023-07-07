import 'package:flutter/material.dart';

import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/components/timetable/custom_cell.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:student_personal_assistant/utilities/show_logout_dialog.dart';

class SetWeeklyTimetableView extends StatelessWidget {
  const SetWeeklyTimetableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logOut();
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
                }
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 91),
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
                          const CustomCell(onPressed: 1),
                          const CustomCell(onPressed: 2),
                          const CustomCell(onPressed: 3),
                          const CustomCell(onPressed: 4),
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
                          const CustomCell(onPressed: 5),
                          const CustomCell(onPressed: 6),
                          const CustomCell(onPressed: 7),
                          const CustomCell(onPressed: 8),
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
                          const CustomCell(onPressed: 9),
                          const CustomCell(onPressed: 10),
                          const CustomCell(onPressed: 11),
                          const CustomCell(onPressed: 12),
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
                          const CustomCell(onPressed: 13),
                          const CustomCell(onPressed: 14),
                          const CustomCell(onPressed: 15),
                          const CustomCell(onPressed: 16),
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
                          const CustomCell(onPressed: 17),
                          const CustomCell(onPressed: 18),
                          const CustomCell(onPressed: 19),
                          const CustomCell(onPressed: 20),
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
                          const CustomCell(onPressed: 21),
                          const CustomCell(onPressed: 22),
                          const CustomCell(onPressed: 23),
                          const CustomCell(onPressed: 24),
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
                          const CustomCell(onPressed: 25),
                          const CustomCell(onPressed: 26),
                          const CustomCell(onPressed: 27),
                          const CustomCell(onPressed: 28),
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
                        Navigator.of(context).pushNamed(uploadOutlinesRoute);
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
        ],
      ),
    );
  }
}
