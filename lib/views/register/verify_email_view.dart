import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/helpers/loading/loading_screen.dart';
import 'package:student_personal_assistant/services/auth/auth_exceptions.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/utilities/show_error_dialog.dart';
import '../login/login_view.dart';
// import '../setup/set_weekly_timetable_view.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();

    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user != null && user.emailVerified) {
    //     // If the user is not null and their email is verified,
    //     // redirect them to the homepage.
    //     Navigator.of(context).pushNamedAndRemoveUntil(
    //       setupRoute, // Replace with the route name of your homepage
    //       (route) => false,
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              final currUser = FirebaseAuth.instance.currentUser;
              if (user != null) {
                // if (user.isEmailVerified) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                //         builder: (context) => const SetWeeklyTimetableView()));
                //   });
                //   return const Center(child: CircularProgressIndicator());

                //   // return const SetWeeklyTimetableView();
                //   // Navigator.of(context)
                //   //     .pushNamedAndRemoveUntil(setupRoute, (route) => false);
                //   // return const SizedBox.shrink();
                // } else {
                return ListView(
                  children: [
                    Center(
                      child: Column(
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
                              try {
                                LoadingScreen().show(
                                    context: context,
                                    text: "Sending verification email...");
                                await AuthService.firebase()
                                    .sendEmailVerification();
                                if (context.mounted) {
                                  LoadingScreen().hide();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Verification email sent. Please check your inbox and verify your email address to access the app."),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                }
                              } on FirebaseAuthException catch (e) {
                                LoadingScreen().hide();
                                showErrorDialog(context, e.message.toString());
                              }
                            },
                            isSecondary: true,
                          ),
                          const SizedBox(height: 12),
                          CustomTextButton(
                            text: "Change email",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Change email"),
                                  content: TextField(
                                    controller: _email,
                                    decoration: const InputDecoration(
                                      labelText: "Email",
                                      hintText: "Enter your email",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          LoadingScreen().show(
                                              context: context,
                                              text: "Changing email...");
                                          try {
                                            await AuthService.firebase()
                                                .updateEmail(_email.text.trim())
                                                .then((value) async {
                                              await AuthService.firebase()
                                                  .sendEmailVerification()
                                                  .then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Verification email sent on the updated email. Please check your inbox and verify your email address to access the app."),
                                                    duration:
                                                        Duration(seconds: 5),
                                                  ),
                                                );
                                              });

                                              //update email in firestore by querying the user's document with email
                                              await FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .where('Email',
                                                      isEqualTo:
                                                          currUser!.email)
                                                  .get()
                                                  .then((value) {
                                                for (var element
                                                    in value.docs) {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(element.id)
                                                      .update({
                                                    'Email': _email.text.trim()
                                                  });
                                                }
                                              });

                                              if (context.mounted) {
                                                LoadingScreen().hide();
                                                Navigator.of(context).pop();
                                              }
                                            });
                                          } on InvalidEmailAuthException {
                                            showErrorDialog(context,
                                                "New email is invalid");
                                          } on UserNotFoundAuthException {
                                            showErrorDialog(
                                                context, "User not found");
                                          } on EmailAlreadyInUseAuthException {
                                            showErrorDialog(context,
                                                "Email already in use");
                                          } on GenericAuthException {
                                            showErrorDialog(context,
                                                "Something went wrong");
                                          } catch (e) {
                                            LoadingScreen().hide();
                                            showErrorDialog(context,
                                                "Unexpected error occured!");
                                          }
                                          // .catchError((error) {
                                          //   showErrorDialog(
                                          //       context, error);
                                          // });

                                          // await curr_user!
                                          //     .updateEmail(
                                          //         _email.text.trim())
                                          //     .then((value) async {
                                          //   await AuthService.firebase()
                                          //       .sendEmailVerification();
                                          //   if (context.mounted) {
                                          //     Navigator.of(context)
                                          //         .pop();
                                          //   }
                                          // }).catchError((error) {
                                          //   showErrorDialog(
                                          //       context, error);
                                          // });

                                          // await AuthService.firebase()
                                          //     .sendEmailVerification();
                                          // if (context.mounted) {
                                          //   Navigator.of(context).pop();
                                          // }
                                        },
                                        child: const Text(
                                            "Send verification email")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel")),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 125),
                          CustomButton(
                            buttonText: "Go back to Login screen",
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  loginRoute, (_) => false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                // }
              } else {
                AuthService.firebase().logOut();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginView()));
                });

                return const Center(child: CircularProgressIndicator());
                // return const LoginView();
                // Navigator.of(context)
                //     .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                // return const SizedBox.shrink();
              }

            default:
              {
                return const CircularProgressIndicator();
              }
          }
        },
      ),
    );
  }
}
