import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/helpers/loading/loading_screen.dart';
import 'package:student_personal_assistant/services/auth/auth_exceptions.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:student_personal_assistant/utilities/show_error_dialog.dart';

class PasswordResetEmailView extends StatefulWidget {
  const PasswordResetEmailView({super.key});

  @override
  State<PasswordResetEmailView> createState() => _PasswordResetEmailViewState();
}

class _PasswordResetEmailViewState extends State<PasswordResetEmailView> {
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final email = routes["email"];
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
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
                        "Password reset link has been sent to your email.\nPlease open the link in your email\nto reset your password."),
                const SizedBox(height: 24),
                CustomButton(
                  buttonText: "Send me password reset link again",
                  onPressed: () async {
                    try {
                      LoadingScreen().show(
                          context: context,
                          text: "Sending password reset email...");
                      await AuthService.firebase().resetPassword(email!);
                      if (context.mounted) {
                        LoadingScreen().hide();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Password reset email sent. Please check your inbox and click on the link in the email to set new password."),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                    } on GenericAuthException {
                      showErrorDialog(context, "Something went wrong");
                    } catch (e) {
                      LoadingScreen().hide();
                      showErrorDialog(context, "Unexpected error occured!\n");
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
                                try {
                                  LoadingScreen().show(
                                      context: context,
                                      text: "Changing email...");
                                  await AuthService.firebase()
                                      .resetPassword(_email.text);
                                  if (context.mounted) {
                                    LoadingScreen().hide();
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Password reset email sent. Please check your inbox and click on the link in the email to set new password."),
                                        duration: Duration(seconds: 5),
                                      ),
                                    );
                                  }
                                } on InvalidEmailAuthException {
                                  LoadingScreen().hide();
                                  showErrorDialog(context,
                                      "Invalid email address format.\nPlease make sure you enter a valid email for password reset.");
                                } on UserNotFoundAuthException {
                                  showErrorDialog(context,
                                      "Email address not associated with any user account.");
                                } on GenericAuthException {
                                  showErrorDialog(
                                      context, "Something went wrong");
                                } catch (e) {
                                  LoadingScreen().hide();
                                  showErrorDialog(context,
                                      "Unexpected error occured!\nPlease make sure you enter a valid email.");
                                }
                              },
                              child: const Text("Send password reset link")),
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
                const SizedBox(height: 126),
                CustomButton(
                  buttonText: "Go back to Login page",
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
