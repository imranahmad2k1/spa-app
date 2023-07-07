import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';

class PasswordResetEmailView extends StatelessWidget {
  final String email;
  const PasswordResetEmailView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
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
                CustomText(
                    text:
                        "Password reset link has been sent to $email.\nPlease open the link in your email\nto reset your password."),
                const SizedBox(height: 24),
                CustomButton(
                  buttonText: "Send me password reset link again",
                  onPressed: () {
                    AuthService.firebase().resetPassword(email);
                  },
                  isSecondary: true,
                ),
                const SizedBox(height: 12),
                CustomTextButton(text: "Change email", onPressed: () {}),
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
