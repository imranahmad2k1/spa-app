import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/outlines/dropdown_outline.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';

class UploadCourseOutlinesView extends StatefulWidget {
  // final List<String> subjectNames;
  const UploadCourseOutlinesView({super.key});

  @override
  State<UploadCourseOutlinesView> createState() =>
      _UploadCourseOutlinesViewState();
}

class _UploadCourseOutlinesViewState extends State<UploadCourseOutlinesView> {
  Map<String, String?> dropdownValues = {};
  static List<String> subjectNames = [];

  void updateSelectedDropdownValue(String? value, String subjectName) {
    setState(() {
      dropdownValues[subjectName] = value;
    });
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
      //[OPTIONAL TO-DO] can add error handling
      //print('Error fetching daysMap from Firestore: $e');

      const daysMapData = null;
      return daysMapData;
    }
  }

  fetchSubjects() async {
    final daysMap = await fetchDaysMapFromFirestore();
    subjectNames.clear();
    daysMap.forEach((key, value) {
      if (value != null) {
        if (!subjectNames.contains(value)) {
          subjectNames.add(value);
        }
      }
    });
  }

  setDropdownValues() async {
    // log("hehe");
    final user = FirebaseAuth.instance.currentUser;
    final collectionRef =
        FirebaseFirestore.instance.collection('SelectedOutlines');
    final querySnapshot = await collectionRef
        .where('Email', isEqualTo: user!.email)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final outlinesMapData =
          querySnapshot.docs[0].data()['selectedOutlinesMap'];
      for (var subject in outlinesMapData.keys) {
        if (dropdownValues[subject] == null) {
          dropdownValues[subject] = outlinesMapData[subject];
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    // future: setDropdownValues(),
    // builder: (context, snapshot) {
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
                  FutureBuilder(
                      future: setDropdownValues(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: subjectNames.length,
                                  itemBuilder: (context, index) {
                                    final subjectName = subjectNames[index];
                                    return CustomOutline(
                                      subjectName: subjectName,
                                      onChanged: (value) {
                                        updateSelectedDropdownValue(
                                            value, subjectName);
                                      },
                                      dropdownValue:
                                          dropdownValues[subjectName],
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(height: 35),
                                Center(
                                  child: CustomButton(
                                    buttonText: "Set outlines",
                                    onPressed: () async {
                                      //upload dropdown values into collection
                                      await AuthService.firebase()
                                          .saveSelectedOutlines(dropdownValues);
                                      if (context.mounted) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                homepageRoute,
                                                (route) => false);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          default:
                            return const Center(
                                child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // });
  }
}
