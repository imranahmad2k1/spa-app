import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:student_personal_assistant/services/auth/firebase_auth_provider.dart';
import 'package:student_personal_assistant/utilities/show_exit_dialog.dart';
import 'package:student_personal_assistant/views/homepage_view.dart';
import 'package:student_personal_assistant/views/register/verify_email_view.dart';
import 'package:student_personal_assistant/views/setup/set_weekly_timetable_view.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

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

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(FirebaseAuthProvider());
    return WillPopScope(
      onWillPop: () async {
        bool hasParentRoute = Navigator.of(context).canPop();
        if (hasParentRoute) {
          return true;
        } else {
          bool? exitConfirmed = await showExitConfirmationDialog(context);
          return exitConfirmed == true;
        }
      },
      child: Scaffold(
        body: FutureBuilder(
            future: authService.initialize(),
            builder: (context, snapshot) {
              // if (user.isEmailVerified) {
              //         if (snapshot.hasData) {
              //           WidgetsBinding.instance.addPostFrameCallback((_) {
              //             Navigator.of(context).pushReplacement(
              //                 MaterialPageRoute(
              //                     builder: (context) => const HomepageView()));
              //           });
              //         } else {
              //           if (context.mounted) {
              //             WidgetsBinding.instance.addPostFrameCallback((_) {
              //               Navigator.of(context).pushReplacement(
              //                   MaterialPageRoute(
              //                       builder: (context) =>
              //                           const SetWeeklyTimetableView()));
              //             });
              //           }
              //         }
              //       } else {
              //         WidgetsBinding.instance.addPostFrameCallback((_) {
              //           Navigator.of(context).pushReplacement(MaterialPageRoute(
              //               builder: (context) => const VerifyEmailView()));
              //         });
              //       }
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = AuthService.firebase().currentUser;
                  if (user != null) {
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     verifyEmailRoute, (route) => false);

                    if (user.isEmailVerified) {
                      fetchDaysMapFromFirestore().then((daysMapData) {
                        if (daysMapData != null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HomepageView()));
                          });
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SetWeeklyTimetableView()));
                          });
                        }
                      });
                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //       builder: (context) =>
                      //           const SetWeeklyTimetableView()));
                      // });
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const VerifyEmailView()));
                      });
                    }
                    // return const VerifyEmailView();
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 85),
                            Image.asset(
                              'assets/images/welcome.png',
                              width: 265,
                              height: 219,
                            ),
                            const CustomDivider(),
                            const SizedBox(
                              height: 40,
                            ),
                            // CarouselSlider(
                            //   options: CarouselOptions(height: 110),
                            //   items: [
                            //     "Develop discipline, \nGenerate study plan, \nand ace your exams",
                            //     "Let's make your study sessions more effective and efficient!",
                            //     "Enhance your understanding and work on knowledge gaps",
                            //   ].map((i) {
                            //     return Builder(
                            //       builder: (BuildContext context) {
                            //         return SizedBox(
                            //           child: Text(
                            //             i,
                            //             textAlign: TextAlign.center,
                            //             style: const TextStyle(
                            //               fontSize: 25,
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //     );
                            //   }).toList(),
                            // ),
                            const Text(
                              "Develop discipline, \nGenerate study plan, \nand ace your exams",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 110,
                            ),
                            CustomButton(
                              buttonText: "Create new account",
                              onPressed: () {
                                Navigator.of(context).pushNamed(registerRoute);
                              },
                            ),
                            const SizedBox(height: 19),
                            CustomButton(
                              buttonText: "I already have an account",
                              onPressed: () {
                                Navigator.of(context).pushNamed(loginRoute);
                              },
                              isSecondary: true,
                            )
                          ],
                        ),
                      ],
                    );
                  }
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
