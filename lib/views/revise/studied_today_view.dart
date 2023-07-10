import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_topic_dropdown.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class StudiedTodayView extends StatefulWidget {
  const StudiedTodayView({super.key});

  @override
  State<StudiedTodayView> createState() => _StudiedTodayViewState();
}

class _StudiedTodayViewState extends State<StudiedTodayView> {
  Map<String, dynamic>? subjectsToday;
  Map<String, bool> subjectSwitches = {};
  Map<String, List<bool>> topicDropdowns = {};
  bool isFirst = true;

  fetchSubjectsFromFirestore() async {
    final subjects = await FirebaseFirestore.instance
        .collection('DaysMaps')
        .where("Email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();

    DateTime date = DateTime.now();
    String day = date.weekday.toString();

    if (context.mounted) {
      Map<String, dynamic> daysMap = subjects.docs[0].data()['daysMap'];

      //if day is 1, then return daysMap having key between 1-4
      //if day is 2, then return daysMap having key between 5-8
      //if day is 3, then return daysMap having key between 9-12
      //if day is 4, then return daysMap having key between 13-16
      //if day is 5, then return daysMap having key between 17-20
      //if day is 6, then return daysMap having key between 21-24
      //if day is 7, then return daysMap having key between 25-28

      Map<String, dynamic> selectedValues = {};

      if (day == "1") {
        selectedValues = Map.fromEntries(daysMap.entries.where(
            (entry) => int.parse(entry.key) >= 1 && int.parse(entry.key) <= 4));
      } else if (day == "2") {
        selectedValues = Map.fromEntries(daysMap.entries.where(
            (entry) => int.parse(entry.key) >= 5 && int.parse(entry.key) <= 8));
      } else if (day == "3") {
        selectedValues = Map.fromEntries(daysMap.entries.where((entry) =>
            int.parse(entry.key) >= 9 && int.parse(entry.key) <= 12));
      } else if (day == "4") {
        selectedValues = Map.fromEntries(daysMap.entries.where((entry) =>
            int.parse(entry.key) >= 13 && int.parse(entry.key) <= 16));
      } else if (day == "5") {
        selectedValues = Map.fromEntries(daysMap.entries.where((entry) =>
            int.parse(entry.key) >= 17 && int.parse(entry.key) <= 20));
      } else if (day == "6") {
        selectedValues = Map.fromEntries(daysMap.entries.where((entry) =>
            int.parse(entry.key) >= 21 && int.parse(entry.key) <= 24));
      } else if (day == "7") {
        selectedValues = Map.fromEntries(daysMap.entries.where((entry) =>
            int.parse(entry.key) >= 25 && int.parse(entry.key) <= 28));
      }

      return selectedValues;
    }
  }

  @override
  void initState() {
    fetchSubjectsFromFirestore().then((value) {
      setState(() {
        subjectsToday = value;
        if (subjectsToday != null) {
          // Initialize the switch state for each subject
          subjectSwitches = {
            for (var subject in subjectsToday!.values) subject as String: false
          };
          topicDropdowns = {
            for (var subject in subjectsToday!.values) subject as String: [],
          };
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 83),
                    const CustomHeading(
                        text:
                            "What topics did you\nstudy in your class\ntoday?"),
                    const SizedBox(height: 20),
                    const CustomDivider(alignLeft: true),
                    const SizedBox(height: 14),
                    if (subjectsToday != null)
                      Container(
                        padding: const EdgeInsets.only(left: 7),
                        decoration: BoxDecoration(
                          // color: const Color(secondaryColor),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        height: 400,
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (var subject in subjectsToday!.values)
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            subject,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Transform.scale(
                                            scale: .8,
                                            child: Switch(
                                              activeColor:
                                                  const Color(primaryColor),
                                              inactiveThumbColor: Colors.red,
                                              inactiveTrackColor:
                                                  const Color(secondaryColor),
                                              trackOutlineColor:
                                                  const MaterialStatePropertyAll(
                                                      Color(0x00000000)),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              value: subjectSwitches[subject] ??
                                                  false,
                                              onChanged: (value) {
                                                setState(() {
                                                  subjectSwitches[subject] =
                                                      value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (subjectSwitches[subject] ?? false)
                                        Row(
                                          children: [
                                            //for loop in the range of length of topicDropdowns
                                            const CustomTopicDropdown(),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  //add a new topic dropdown for subject
                                                  topicDropdowns[subject]!
                                                      .add(true);
                                                  isFirst = false;
                                                  // print("added $topicDropdowns");
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 24,
                                              ),
                                            )
                                          ],
                                        ),
                                      for (var i = 0;
                                          i < topicDropdowns[subject]!.length;
                                          i++)
                                        Row(
                                          children: [
                                            //for loop in the range of length of topicDropdowns
                                            const CustomTopicDropdown(),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  //add a new topic dropdown for subject
                                                  topicDropdowns[subject]!
                                                      .remove(true);
                                                  // print("removed $topicDropdowns");
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                const SizedBox(height: 99),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(
                        height: 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Color(primaryColor),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Loading subjects...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  child: CustomButton(
                    buttonText: "Next",
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        recommendRoute,
                        (_) => false,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
