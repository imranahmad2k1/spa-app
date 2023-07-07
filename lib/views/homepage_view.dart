import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_module_info.dart';
import 'package:student_personal_assistant/components/custom_navbar.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/my_drawer.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/custom_icons_icons.dart';
import 'package:student_personal_assistant/views/quiz/quiztest_view.dart';
import 'package:student_personal_assistant/views/revise/revise_view.dart';
import 'package:student_personal_assistant/views/study/study_view.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  int currentPageIndex = 0;
  late String? firstName;
  late String? lastName;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  _asyncMethod() async {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    final db = FirebaseFirestore.instance;
    final userDataRef =
        db.collection('Users').where("Email", isEqualTo: userEmail);
    await userDataRef.get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          firstName = doc["First Name"];
          lastName = doc["Last Name"];
        }
      },
    );
    return "$firstName $lastName";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _asyncMethod(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              drawer: MyDrawer(
                firstName: snapshot.data ?? "",
              ),
              appBar: AppBar(),
              bottomNavigationBar: CustomNavBar(
                onDestinationSelected: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                selectedIndex: currentPageIndex,
              ),
              body: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 91),
                      CustomHeading(text: "Welcome,\n$firstName!"),
                      const SizedBox(height: 15),
                      const CustomText(
                          text:
                              "Let's make your study sessions\nmore effective and efficient!",
                          alignLeft: true),
                      const SizedBox(height: 20),
                      const CustomDivider(alignLeft: true),
                      const SizedBox(height: 48),
                      const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              CustomIcons.revise,
                              color: Color(primaryColor),
                            ),
                            SizedBox(width: 8),
                            CustomModuleInfo(
                                name: "Revise",
                                text:
                                    "Review what you have studied\ntoday and set up your understanding\nlevel."),
                          ]),
                      const SizedBox(height: 44),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CustomIcons.study,
                            color: Color(primaryColor),
                          ),
                          SizedBox(width: 8),
                          CustomModuleInfo(
                              name: "Study",
                              text:
                                  "Explore new subjects and\ntopics based on your areas of\nimprovement."),
                        ],
                      ),
                      const SizedBox(height: 44),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CustomIcons.quiz,
                            color: Color(primaryColor),
                          ),
                          SizedBox(width: 8),
                          CustomModuleInfo(
                              name: "Quiz/Test",
                              text:
                                  "Get ready for upcoming\nquizzes or tests by focusing on\nrecommended topics."),
                        ],
                      ),
                    ],
                  ),
                ),
                const ReviseView(),
                const StudyView(),
                const QuizTestView(),
              ][currentPageIndex]);
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
