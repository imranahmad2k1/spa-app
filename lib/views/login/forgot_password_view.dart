import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_field.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 118),
              const CustomHeading(text: "Reset your Password"),
              const SizedBox(height: 18),
              const CustomText(
                text:
                    "If you forgot your password,\nEnter your email address below.\nWe will send you password reset link",
                alignLeft: true,
              ),
              const SizedBox(
                height: 23,
              ),
              const CustomDivider(alignLeft: true),
              const SizedBox(
                height: 41,
              ),
              const CustomTextField(labelText: "Your email address"),
              const SizedBox(
                height: 22,
              ),
              Center(
                child: Column(
                  children: [
                    CustomButton(
                      buttonText: "Send me a password reset link",
                      onPressed: () {
                        Navigator.of(context).pushNamed(resetPassworRoute);
                      },
                    ),
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
