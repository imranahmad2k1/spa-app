import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/end_study_button.dart';
import 'package:student_personal_assistant/components/recommendations/study_carousel_slider.dart';
// import 'package:student_personal_assistant/constants/routes.dart';

import 'dart:developer' show log;

class StudyRecommendedTopicsView extends StatefulWidget {
  const StudyRecommendedTopicsView({super.key});

  @override
  State<StudyRecommendedTopicsView> createState() =>
      _StudyRecommendedTopicsViewState();
}

class _StudyRecommendedTopicsViewState
    extends State<StudyRecommendedTopicsView> {
  Map<String, dynamic>? topicsMap;
  Set<Topic> globalRecommendedTopics = {};

  callingRecommenderFunctions(String subject) async {
    List<Topic> topics = await fetchTopics(subject);
    getRecommendedTopics(false, topics);
    log(globalRecommendedTopics.toString());
  }

  fetchTopics(String subject) async {
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
    dynamic dbTopics = topicsMap![subject]['topics'];
    List<Topic> topics = [];
    for (var topic in dbTopics) {
      // String? dependeeTopic;
      Topic? dependeeTopic; //CHATGPT
      if (topic['dependeeTopic'] != "0") {
        // dependeeTopic = topic['dependeeTopic'];

        //CHATGPT
        // String dependeeTopicId = topic['dependeeTopic'];
        // dependeeTopic = topics.firstWhere(
        //   (t) => t.id == dependeeTopicId,
        // );
        //ENDCHATGPT

        for (var tempDependeeTopic in dbTopics) {
          if (tempDependeeTopic['id'] == topic['dependeeTopic']) {
            dependeeTopic = Topic(
              id: tempDependeeTopic['id'],
              name: tempDependeeTopic['topicName'],
              subject: subject,
              understandingLevel:
                  int.parse(tempDependeeTopic['understandingLevel']),
              // dependeeTopic: null, //RIGHT NOW LIMIT 1 [OPTIONAL]
            );
          }
        }
      } else {
        dependeeTopic = null;
      }
      Topic topicObj = Topic(
        id: topic['id'],
        name: topic['topicName'],
        subject: subject,
        understandingLevel: int.parse(topic['understandingLevel']),
        dependeeTopic: dependeeTopic,
      );

      topics.add(topicObj);
    }
    return topics;
  }

//RECOMMENDER ALGORITHM
  void getRecommendedTopics(bool stopStudying, List<Topic> topics) {
    List<Topic> recommendedTopics = topics;
    final List<List<dynamic>> allTopics = [];

    for (Topic topic in recommendedTopics) {
      Topic? dependeeTopic = topic.dependeeTopic;
      List<dynamic> row = [];
      row.add(topic);
      if (dependeeTopic != null) {
        row.add(dependeeTopic);
      }
      allTopics.add(row);
    }

    //SUM GOING INTO ROW
    for (List<dynamic> row in allTopics) {
      int sum = 0;
      for (Topic topic in row) {
        // stdout.write('${topic.name}:${topic.understandingLevel} > ');
        sum += topic.understandingLevel;
      }
      // print('Sum: $sum\n--');
      // level2Sum.add(sum);
      row.add(sum);
    }
    globalRecommendedTopics.clear();
    //SORTIN
    List<Topic> recommendations = bubbleSortLevel2(allTopics);
    for (Topic t in recommendations) {
      globalRecommendedTopics.add(t);
    }
    // log(allTopics.toString());

    //SORTED
    // for (List<dynamic> rows in allTopics) {
    //   String tul = '';
    //   for (dynamic topic in rows) {
    //     if (topic is int) {
    //       //HERE SUM at the end of TOPICS ROW
    //       tul += 'Sum: $topic';
    //     } else {
    //       //HERE TOPIC
    //       tul += '${topic.name}:${topic.understandingLevel} > ';
    //     }
    //   }
    // log(tul);
    // log('\n---');
    // }
  }

  List<Topic> bubbleSortLevel2(List<List<dynamic>> allTopics) {
    int n = allTopics.length;
    bool swapped;

    for (int i = 0; i < n - 1; i++) {
      swapped = false;

      for (int j = 0; j < n - i - 1; j++) {
        int comparison = compareLevel2(
          allTopics[j],
          allTopics[j + 1],
        );
        if (comparison > 0) {
          List<dynamic> temp = allTopics[j];
          allTopics[j] = allTopics[j + 1];
          allTopics[j + 1] = temp;
          swapped = true;
        }
      }
      if (!swapped) {
        break;
      }
    }
    return bubbleSortLevel1(allTopics);
  }

  int compareLevel2(List<dynamic> rowFirst, List<dynamic> rowSecond) {
    int sumOfRowFirst = rowFirst[rowFirst.length - 1];
    int sumOfRowSecond = rowSecond[rowSecond.length - 1];
    int comparison = sumOfRowFirst.compareTo(sumOfRowSecond);
    return comparison;
  }

  List<Topic> bubbleSortLevel1(List<List<dynamic>> allTopics) {
    int n = allTopics.length;

    while (true) {
      bool somethingChanged = false;
      for (int row = 0; row < n - 1; row++) {
        int noOfTopics = allTopics[row].length;
        if (allTopics[row][noOfTopics - 1] ==
            allTopics[row + 1][noOfTopics - 1]) {
          int comparison = compareLevel1(
            allTopics[row],
            allTopics[row + 1],
          );
          if (comparison > 0) {
            List<dynamic> temp = allTopics[row];
            allTopics[row] = allTopics[row + 1];
            allTopics[row + 1] = temp;
            somethingChanged = true;
          }
        }
      }
      if (somethingChanged == false) {
        break;
      }
    }

    List<Topic> recommendedTopics = [];
    for (List<dynamic> row in allTopics) {
      int n = row.length;
      for (int i = n - 2; i > -1; i--) {
        recommendedTopics.add(row[i]);
      }
    }
    return recommendedTopics;
  }

  int compareLevel1(List<dynamic> rowFirst, List<dynamic> rowSecond) {
    //[-2] is sum of second last element which is Topic
    int understandingOfFirstLevel1TopicOfRowFirst =
        rowFirst[rowFirst.length - 2].understandingLevel;
    int understandingOfFirstLevel1TopicOfRowSecond =
        rowSecond[rowSecond.length - 2].understandingLevel;
    int comparison = understandingOfFirstLevel1TopicOfRowFirst
        .compareTo(understandingOfFirstLevel1TopicOfRowSecond);
    return comparison;
  }

  void updateUnderstandingLevel(
      {required Topic topic, required int newUnderstandingLevel}) {
    topic.understandingLevel = newUnderstandingLevel;
  }
  //END RECOMMENDER ALGORITHM

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final subject = routes["subject"];
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
                    CustomHeading(text: "Recommended\nTopics"),
                    SizedBox(height: 15),
                    CustomText(
                      text:
                          "Here are your recommended topics\nbased on your weaknesses:",
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
                    StudyCarouselSliderComponent(),
                    const SizedBox(height: 35),
                    Center(
                      child: EndStudyButton(onPressed: () async {
                        await callingRecommenderFunctions(subject!);
                        // log(subject!);
                        // Navigator.of(context).pushNamed(homepageRoute);
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

class Topic {
  final String id;
  final String name;
  final String subject;
  int understandingLevel;
  final Topic? dependeeTopic;

  Topic({
    required this.id,
    required this.name,
    required this.subject,
    this.understandingLevel = 7,
    this.dependeeTopic,
  });
}
