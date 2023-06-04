import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_field.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class CreateAnAccountView extends StatelessWidget {
  const CreateAnAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 118),
            const CustomHeading(text: "Create an account"),
            const SizedBox(height: 18),
            const CustomText(
                text:
                    "Please complete your profile. \nDon’t worry, your data will remain private\nand only you can see it"),
            const SizedBox(height: 20),
            const CustomDivider(),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  width: 170,
                  labelText: "First Name",
                ),
                CustomTextField(
                  width: 170,
                  labelText: "Last Name",
                )
              ],
            ),
            const SizedBox(height: 22),
            const CustomTextField(labelText: "Email address"),
            const SizedBox(height: 22),
            const CustomTextField(labelText: "New password"),
            const SizedBox(height: 22),
            CustomButton(
              buttonText: "Register",
              onPressed: () {
                Navigator.of(context).pushNamed(verifyEmailRoute);
              },
            ),
            const SizedBox(height: 169),
            CustomButton(
              buttonText: "Already have an account? Log in",
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (_) => false);
              },
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }
}
