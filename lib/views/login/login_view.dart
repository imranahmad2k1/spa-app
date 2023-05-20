import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_button.dart';
import 'package:student_personal_assistant/components/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 118),
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
              const CustomTextField(labelText: "Email address"),
              const SizedBox(
                height: 22,
              ),
              const CustomTextField(
                labelText: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 22,
              ),
              Center(
                child: Column(
                  children: [
                    CustomButton(buttonText: "Log in", onPressed: () {}),
                    CustomTextButton(
                        text: "Forgot Password?", onPressed: () {}),
                    const SizedBox(
                      height: 175,
                    ),
                    CustomButton(
                      buttonText: "Create a new account",
                      onPressed: () {},
                      isSecondary: true,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
