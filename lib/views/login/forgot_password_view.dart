import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_text.dart';
import 'package:student_personal_assistant/components/custom_text_field.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Center(
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
                  CustomTextField(
                      controller: _email, labelText: "Your email address"),
                  const SizedBox(
                    height: 22,
                  ),
                  Center(
                    child: Column(
                      children: [
                        CustomButton(
                          buttonText: "Send me a password reset link",
                          onPressed: () async {
                            await AuthService.firebase()
                                .resetPassword(_email.text);
                            if (context.mounted) {
                              Navigator.of(context)
                                  .pushNamed(resetPassworRoute, arguments: {
                                "email": _email.text,
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
