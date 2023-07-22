import 'package:flutter/material.dart';
import 'package:student_personal_assistant/helpers/loading/loading_screen.dart';
import 'package:student_personal_assistant/services/auth/auth_exceptions.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/components/custom_text_field.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/utilities/show_error_dialog.dart';
import 'package:student_personal_assistant/utilities/show_exit_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
          // if (exitConfirmed != null && exitConfirmed) {
          //   return true;
          // } else {
          //   return false;
          // }
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 21),
                child: FutureBuilder(
                  future: AuthService.firebase().initialize(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 118),
                            const CustomHeading(text: "Log in"),
                            const SizedBox(height: 18),
                            const CustomText(
                              text:
                                  "Nice to see you again!\nPlease log in to access\nyour personalized account.",
                              alignLeft: true,
                            ),
                            const SizedBox(
                              height: 23,
                            ),
                            const CustomDivider(alignLeft: true),
                            // const CustomDivider(alignLeft: true),
                            const SizedBox(
                              height: 41,
                            ),
                            CustomTextField(
                                controller: _email, labelText: "Email address"),
                            const SizedBox(
                              height: 22,
                            ),
                            CustomTextField(
                              controller: _password,
                              labelText: "Password",
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  CustomButton(
                                      buttonText: "Log in",
                                      onPressed: () async {
                                        final email = _email.text;
                                        final password = _password.text;
                                        try {
                                          LoadingScreen().show(
                                              context: context,
                                              text:
                                                  'Authenticating your credentials...');
                                          //delay for 5 seconds to show loading screen
                                          await AuthService.firebase().logIn(
                                            email: email,
                                            password: password,
                                          );
                                          LoadingScreen().hide();

                                          final user = AuthService.firebase()
                                              .currentUser;
                                          if (user?.isEmailVerified ?? false) {
                                            //usr's email is verified
                                            if (context.mounted) {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      setupRoute, (_) => false);
                                            }
                                          } else {
                                            //user's email is NOT verified
                                            if (context.mounted) {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      verifyEmailRoute,
                                                      (route) => false);
                                            }
                                          }
                                        } on UserNotFoundAuthException {
                                          await showErrorDialog(
                                            context,
                                            'User not found',
                                          );
                                        } on InvalidEmailAuthException {
                                          await showErrorDialog(
                                            context,
                                            'This is an invalid email address',
                                          );
                                        } on WrongPasswordAuthException {
                                          await showErrorDialog(
                                            context,
                                            'Wrong password',
                                          );
                                        } on GenericAuthException {
                                          await showErrorDialog(
                                            context,
                                            'Authentication error',
                                          );
                                        }
                                      }),
                                  CustomTextButton(
                                      text: "Forgot Password?",
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(forgotPassowrdRoute);
                                      }),
                                  const SizedBox(
                                    height: 175,
                                  ),
                                  CustomButton(
                                    buttonText: "Create a new account",
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              registerRoute, (_) => false);
                                    },
                                    isSecondary: true,
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      default:
                        return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
