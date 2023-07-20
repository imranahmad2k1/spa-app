import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/recommendations/subjects_carousel_slider.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class RecommendedSubjectsView extends StatefulWidget {
  const RecommendedSubjectsView({super.key});

  @override
  State<RecommendedSubjectsView> createState() =>
      _RecommendedSubjectsViewState();
}

class _RecommendedSubjectsViewState extends State<RecommendedSubjectsView> {
  String? selectedSubject;
  Map<String, dynamic>? topicsMap;
  List<MapEntry<String, double>> sortedSubjects = [];
  fetchOutlines() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final collectionRef =
          FirebaseFirestore.instance.collection('UnderstandingLevels');
      final querySnapshot =
          await collectionRef.where('Email', isEqualTo: user.email).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          topicsMap = doc.data()['topicsMap'];
        }
      }
    }
  }

  Future<List<MapEntry<String, double>>> subjectsRecommender() async {
    await fetchOutlines();
    if (context.mounted) {
      // Calculate average understanding level for each subject
      Map<String, double> subjectAverages = {};
      topicsMap!.forEach((subject, data) {
        List<dynamic> topics = data["topics"] ?? [];
        int totalUnderstandingLevel = 0;

        for (var topic in topics) {
          totalUnderstandingLevel += int.parse(topic["understandingLevel"]);
        }

        double averageUnderstandingLevel =
            totalUnderstandingLevel / topics.length.toDouble();
        subjectAverages[subject] = averageUnderstandingLevel;

        // Sort subjects based on average understanding level
        sortedSubjects = subjectAverages.entries.toList()
          ..sort((a, b) => a.value.compareTo(b.value));
      });

      // Output sorted subjects
      // for (var entry in sortedSubjects) {
      //   print("${entry.key}: ${entry.value}");
      // }
    }
    return sortedSubjects;
  }

  @override
  Widget build(BuildContext context) {
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
                    CustomHeading(text: "Recommended\nSubjects"),
                    SizedBox(height: 15),
                    CustomText(
                      text:
                          "All subjects are recommended based on your\nweaknesses.\nChoose subject of your interest",
                      alignLeft: true,
                    ),
                    SizedBox(height: 20),
                    CustomDivider(alignLeft: true),
                    SizedBox(height: 35),
                  ],
                ),
                FutureBuilder<List<MapEntry<String, double>>>(
                    future: subjectsRecommender(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          children: [
                            Center(child: CircularProgressIndicator()),
                            SizedBox(height: 35),
                            Text("Loading..."),
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return Builder(builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Column(
                              children: [
                                //CAROUSEL HERE
                                Builder(builder: (context) {
                                  return SubjectsCarouselSliderComponent(
                                    subjects: snapshot.data!,
                                    onSubjectSelected: (value) {
                                      setState(() {
                                        selectedSubject = value;
                                      });
                                    },
                                    // (value) {
                                    //   setState(() {
                                    //     selectedSubject = value;
                                    //   });
                                    // }
                                  );
                                }),
                                const SizedBox(height: 35),
                                Center(
                                  child: CustomButton(
                                    buttonText: "Next",
                                    onPressed: selectedSubject != null
                                        ? () async {
                                            //PASS ARGUMENT selectedSubject
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    recommendRoute,
                                                    arguments: {
                                                      'subject':
                                                          selectedSubject,
                                                    },
                                                    (_) => false);
                                          }
                                        : () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Please select a subject"),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          },
                                  ),
                                )

                                // SizedBox(height: 200)
                              ],
                            );
                          });
                        });
                      } else {
                        return const Text(
                            "An error occurred while loading subjects. Try restarting the app.");
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
