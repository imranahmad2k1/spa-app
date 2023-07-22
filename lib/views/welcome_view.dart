import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:student_personal_assistant/utilities/show_exit_dialog.dart';
import 'package:student_personal_assistant/views/register/verify_email_view.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
            future: AuthService.firebase().initialize(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = AuthService.firebase().currentUser;
                  if (user != null) {
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     verifyEmailRoute, (route) => false);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const VerifyEmailView()));
                    });
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
