import 'package:flutter/material.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import '../login/login_view.dart';
import '../setup/set_weekly_timetable_view.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Center(
          child: FutureBuilder(
            future: AuthService.firebase().initialize(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = AuthService.firebase().currentUser;
                  if (user != null) {
                    if (user.isEmailVerified) {
                      return const SetWeeklyTimetableView();
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const SizedBox(height: 86),
                          Image.asset(
                            'assets/images/fingerprint.png',
                            // width: , height: ,
                          ),
                          const SizedBox(height: 31),
                          const CustomHeading(text: "We sent you an Email"),
                          const SizedBox(height: 18),
                          const CustomText(
                              text:
                                  "Verification email has been sent to your email.\nPlease open the link in your email\nto verify your account."),
                          const SizedBox(height: 24),
                          CustomButton(
                            buttonText: "Send me verification email again",
                            onPressed: () async {
                              await AuthService.firebase()
                                  .sendEmailVerification();
                            },
                            isSecondary: true,
                          ),
                          const SizedBox(height: 12),
                          CustomTextButton(
                              text: "Change email", onPressed: () {}),
                          const SizedBox(height: 125),
                          CustomButton(
                            buttonText: "Go back to Login screen",
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  loginRoute, (_) => false);
                            },
                          ),
                        ],
                      );
                    }
                  } else {
                    return const LoginView();
                  }

                default:
                  {
                    return const CircularProgressIndicator();
                  }
              }
            },
          ),
        ),
      ]),
    );
  }
}
