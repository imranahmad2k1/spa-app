import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/end_study_button.dart';
import 'package:student_personal_assistant/components/recommendations/revise_carousel_slider.dart';
import 'package:student_personal_assistant/constants/routes.dart';

//READCSV
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';

class ReviseRecommendedTopicsView extends StatefulWidget {
  const ReviseRecommendedTopicsView({super.key});

  @override
  State<ReviseRecommendedTopicsView> createState() =>
      _ReviseRecommendedTopicsViewState();
}

class _ReviseRecommendedTopicsViewState
    extends State<ReviseRecommendedTopicsView> {
  Map<String, List<String>>? subjectTopicDropdowns;
  Map<String, String> understandingLevels = {};

//READ
  List<List<dynamic>>? csvList;
  firebase_storage.ListResult? result;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> listAllFiles(String subjectName) async {
    result = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files')
        .child(subjectName)
        .listAll();
  }

  fetchOutlines(String subjectName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final collectionRef =
          FirebaseFirestore.instance.collection('SelectedOutlines');
      final querySnapshot = await collectionRef
          .where('Email', isEqualTo: user.email)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final selectedOutlinesData =
            querySnapshot.docs[0].data()['selectedOutlinesMap'];
        String version = selectedOutlinesData[subjectName].split(' ').last;
        await listAllFiles(subjectName);
        await downloadURLs(result!, version);
      }
    }
  }

  Future<void> downloadURLs(
      firebase_storage.ListResult result, String version) async {
    for (var element in result.items) {
      String compareVersion =
          element.fullPath.split(' ').last.replaceAll('.csv', '');
      if (version == compareVersion) {
        String downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref(element.fullPath)
            .getDownloadURL();
        await readCSVFromURL(downloadURL);
      }
    }
  }

  Future<void> readCSVFromURL(String downloadURL) async {
    final response = await http.get(Uri.parse(downloadURL));
    if (response.statusCode == 200) {
      final csvData = response.body;
      const csvParser = CsvToListConverter();
      // final List<List<dynamic>> csvList = csvParser.convert(csvData);
      csvList = csvParser.convert(csvData);

      // Process the CSV data
      // for (var row in csvList!) {
      //   print("Topic: ${row[1]}");
      // }
    } else {
      // print('Failed to download CSV file');
    }
  }

//ENDREAD

  @override
  Widget build(BuildContext context) {
    final routes = ModalRoute.of(context)!.settings.arguments
        as Map<String, Map<String, List<String>>>;
    final subjectTopicDropdowns = routes["subjectTopicDropdowns"];

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
                    CustomHeading(text: "Revision of\nTopics"),
                    SizedBox(height: 15),
                    CustomText(
                      text:
                          "Keep the momentum going!\nRevisit today's topics for solid understanding:",
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
                    ReviseCarouselSliderComponent(
                      subjectTopicDropdowns: subjectTopicDropdowns!,
                      onUnderstandingLevelChanged:
                          (subjectTopic, topic, level) {
                        setState(() {
                          understandingLevels["$subjectTopic: $topic"] = level;
                        });
                      },
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: EndStudyButton(onPressed: () async {
                        Map<String, Map<String, List<Map<String, dynamic>>>>
                            topicsMap = {};

                        Set<String> uniqueKeys = {};
                        for (var entry in understandingLevels.entries) {
                          String key = entry.key.split(": ")[0];
                          uniqueKeys.add(key);
                        }

                        for (var entry in uniqueKeys) {
                          await fetchOutlines(entry);
                          for (var entry in understandingLevels.entries) {
                            var results = entry.key.split(": ");
                            String? id;
                            String subject = results[0];
                            String topicName = results[1];
                            String understandingLevel = entry.value;
                            String? dependeeTopic;

                            if (context.mounted) {
                              for (var row in csvList!) {
                                if (row[1] == results[1]) {
                                  id = row[0];
                                  dependeeTopic = row[2].toString();
                                  break;
                                }
                              }

                              if (topicsMap[subject] == null) {
                                topicsMap[subject] = {"topics": []};
                              }
                              // if (dependeeTopic != "0") {
                              topicsMap[subject]!["topics"]!.add({
                                "id": id!,
                                "topicName": topicName,
                                "understandingLevel": understandingLevel,
                                "dependeeTopic": dependeeTopic!
                              });
                              // }
                              // else {
                              //   topicsMap[subject]!["topics"]!.add([
                              //     id!,
                              //     topicName,
                              //     understandingLevel,
                              //     dependeeTopic!,
                              //   ]);
                              // }
                            }
                          }
                        }
                        // print(topicsMap);
                        //FOR SPECIFIC SUBJECT NOW
                        try {
                          await AuthService.firebase()
                              .saveUnderstandingLevel(topicsMap);
                          // print("Saved understanding levels!");
                          if (context.mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                homepageRoute, (route) => false);
                          }
                        } catch (e) {
                          // print("Error occured: $e");
                        }
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

// class Topic {
//   final String topicID;
//   final String topicName;
//   // final Subject subject;
//   final String subject;
//   String understandingLevel;
//   final Topic? dependeeTopic;

//   Topic({
//     required this.topicID,
//     required this.topicName,
//     required this.subject,
//     this.understandingLevel = "7",
//     this.dependeeTopic,
//   });
// }

// class Subject {
//   final String id;
//   final String name;

//   const Subject({
//     required this.id,
//     required this.name,
//   });
// }
