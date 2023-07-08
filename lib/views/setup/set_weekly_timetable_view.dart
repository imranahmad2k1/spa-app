import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class SetWeeklyTimetableView extends StatefulWidget {
  const SetWeeklyTimetableView({super.key});

  @override
  State<SetWeeklyTimetableView> createState() => _SetWeeklyTimetableViewState();
}

class _SetWeeklyTimetableViewState extends State<SetWeeklyTimetableView> {
  static Map<String, dynamic> daysMap = {};
  static List<String> subjectNames = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDaysMapFromFirestore();
  }

  fetchDaysMapFromFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final collectionRef = FirebaseFirestore.instance.collection('DaysMaps');
        final querySnapshot = await collectionRef
            .where('Email', isEqualTo: user.email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final daysMapData = querySnapshot.docs[0].data()['daysMap'];
          //NEW
          return daysMapData;
        } else {
          const daysMapData = null;
          return daysMapData;
        }
      } else {
        const daysMapData = null;
        return daysMapData;
      }
    } catch (e) {
      print('Error fetching daysMap from Firestore: $e');
      const daysMapData = null;
      return daysMapData;
    }
  }

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
      body: FutureBuilder(
        future: fetchDaysMapFromFirestore(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final daysMapData = snapshot.data as Map<String, dynamic>;
            daysMap = daysMapData;
            return ListView(
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
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FixedColumnWidth(90),
                          },
                          border:
                              TableBorder.all(color: const Color(borderColor)),
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "1",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "2",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "3",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "4",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "5",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "6",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "7",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "8",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "9",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "10",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "11",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "12",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "13",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "14",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "15",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "16",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "17",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "18",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "19",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "20",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "21",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "22",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "23",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "24",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "25",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "26",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "27",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "28",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
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
                            onPressed: (() async {
                              // print(daysMap);
                              // print(subjectNames);
                              await AuthService.firebase()
                                  .addDaysMap(daysMap)
                                  .then((value) => print("daysMap added"))
                                  .catchError((e) => print(e));
                              //[OPTIONAL TO-DO] CAN DO ERROR HANDLING HERE

                              // navigate to uploadoutlinesroute
                              if (context.mounted) {
                                Navigator.of(context)
                                    .pushNamed(uploadOutlinesRoute, arguments: {
                                  // 'daysMap': daysMap,
                                  'subjectNames': subjectNames,
                                });
                              }
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
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          // else if (snapshot.connectionState == ConnectionState.done) {
          //   return const Center(
          //     child: Text("Hello"),
          //   );
          // }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            daysMap = {};
            return ListView(
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
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FixedColumnWidth(90),
                          },
                          border:
                              TableBorder.all(color: const Color(borderColor)),
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "1",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "2",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "3",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "4",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "5",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "6",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "7",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "8",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "9",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "10",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "11",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "12",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "13",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "14",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "15",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "16",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "17",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "18",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "19",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "20",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "21",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "22",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "23",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "24",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                              ],
                            ),
                            TableRow(
                              decoration: const BoxDecoration(
                                color: Color(fieldBackgroundColor),
                              ),
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                CustomCell(
                                  onPressed: "25",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "26",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "27",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
                                CustomCell(
                                  onPressed: "28",
                                  daysMap: daysMap,
                                  subjectNames: subjectNames,
                                ),
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
                            onPressed: (() async {
                              // print(daysMap);
                              // print(subjectNames);
                              await AuthService.firebase()
                                  .addDaysMap(daysMap)
                                  .then((value) => print("daysMap added"))
                                  .catchError((e) => print(e));
                              //[OPTIONAL TO-DO] CAN DO ERROR HANDLING HERE

                              // navigate to uploadoutlinesroute
                              if (context.mounted) {
                                Navigator.of(context)
                                    .pushNamed(uploadOutlinesRoute, arguments: {
                                  // 'daysMap': daysMap,
                                  'subjectNames': subjectNames,
                                });
                              }
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
            );
          }
        },
      ),
    );
  }
}
// }
