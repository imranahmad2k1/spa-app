import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_quiztopic_dropdown.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/views/study/topic_class.dart';

class SelectSubjectTopicsView extends StatefulWidget {
  const SelectSubjectTopicsView({super.key});

  @override
  State<SelectSubjectTopicsView> createState() =>
      _SelectSubjectTopicsViewState();
}

class _SelectSubjectTopicsViewState extends State<SelectSubjectTopicsView> {
  List<Topic> selectedTopics = [];
  List<Topic> topics = [];
  bool isFirst = true;
  List<bool> topicDropdowns = [];
  String? selectedSubject;
  Map<String, dynamic>? topicsMap;
  Set<String> subjects = {};
  fetchSubjects() async {
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
        topicsMap!.forEach((subject, _) {
          subjects.add(subject);
        });
      }
    }
  }

  fetchTopics(String? subject) async {
    List<Topic> topics = [];
    if (subject != null) {
      dynamic dbTopics = topicsMap![subject]['topics'];
      for (var topic in dbTopics) {
        Topic? dependeeTopic; //CHATGPT
        if (topic['dependeeTopic'] != "0") {
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
    }
    return topics;
  }

  @override
  void initState() {
    super.initState();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 83),
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
                const SizedBox(height: 9),
                FutureBuilder(
                    future: fetchSubjects(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          children: [
                            Center(child: CircularProgressIndicator()),
                            SizedBox(height: 20),
                            Text(
                              "Fetching data...",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(borderColor)),
                                borderRadius: BorderRadius.circular(3.0),
                                color: const Color(fieldBackgroundColor),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: SizedBox(
                                  height: 37,
                                  child: Builder(builder: (context) {
                                    return DropdownButton(
                                      hint: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                        ),
                                        child: const Text(
                                          "Select subject",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color(fieldUnselectedTextColor),
                                          ),
                                        ),
                                      ),
                                      value: selectedSubject,
                                      items: subjects.map((String items) {
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
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) async {
                                        setState(() {
                                          selectedSubject = value;
                                        });
                                        topics =
                                            await fetchTopics(selectedSubject);
                                      },
                                    );
                                  }),
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
                            const SizedBox(height: 9),
                            SizedBox(
                              height: 200,
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  child: Builder(builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomQuizTopicDropdown(
                                                onTopicSelected:
                                                    (selectedTopic) {
                                                  setState(() {
                                                    if (!selectedTopics
                                                        .contains(
                                                            selectedTopic)) {
                                                      selectedTopics
                                                          .add(selectedTopic);
                                                    }
                                                  });
                                                },
                                                topics: topics,
                                                selectedTopics: selectedTopics,
                                                index: 0,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    //add a new topic dropdown for subject
                                                    topicDropdowns.add(true);
                                                    isFirst = false;
                                                    // print("added $topicDropdowns");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: topicDropdowns.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  CustomQuizTopicDropdown(
                                                      onTopicSelected:
                                                          (selectedTopic) {
                                                        setState(() {
                                                          if (!selectedTopics
                                                              .contains(
                                                                  selectedTopic)) {
                                                            selectedTopics.add(
                                                                selectedTopic);
                                                          }
                                                        });
                                                      },
                                                      topics: topics,
                                                      index: index + 1,
                                                      selectedTopics:
                                                          selectedTopics),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        selectedTopics.removeAt(
                                                            index + 1);
                                                        topicDropdowns
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                  }),
                                ),
                              ),
                              // });
                              // }
                              // }),
                            ),
                            // const CustomQuizTopicDropdown(),
                            // const CustomQuizTopicDropdown(),
                            const SizedBox(height: 20),
                            Center(
                              child: CustomButton(
                                buttonText: "Recommend Topics",
                                onPressed: () {
                                  // for (var topic in selectedTopics) {
                                  //   log(topic.name);
                                  // }
                                  //   log("------------------");

                                  var uniqueTopicIds = <String>{};
                                  var uniqueTopics = [];
                                  for (var topic in selectedTopics) {
                                    var topicId = topic.id;

                                    // Check if the topicId is not already present in the Set
                                    if (!uniqueTopicIds.contains(topicId)) {
                                      // If it's not present, add it to the Set and add the topic to the uniqueTopics list
                                      uniqueTopicIds.add(topicId);
                                      uniqueTopics.add(topic);
                                    }
                                  }
                                  // log(selectedTopics.runtimeType.toString());
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      quizTestRecommendRoute,
                                      arguments: {
                                        'selectedTopics': uniqueTopics,
                                      },
                                      (_) => false);
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text("No data found");
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
