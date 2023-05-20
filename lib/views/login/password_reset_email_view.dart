import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';

class PasswordResetEmailView extends StatelessWidget {
  const PasswordResetEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 86,
            ),
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
              onPressed: () {},
              isSecondary: true,
            ),
            const SizedBox(height: 12),
            CustomTextButton(text: "Change email", onPressed: () {}),
            const SizedBox(height: 156),
            CustomButton(buttonText: "Go back to Login page", onPressed: () {}),
          ],
        ),
      ),
    );
    ;
  }
}
