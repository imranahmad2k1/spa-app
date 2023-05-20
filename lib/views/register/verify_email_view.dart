import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

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
            const Text(
              'We sent you an Email',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Verification email has been sent to your email.\nPlease open the link in your email\nto verify your account.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(30),
              child: Ink(
                width: 268,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(secondaryColor),
                ),
                child: const Center(
                    child: Text(
                  'Send me verification email again',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                )),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Change email",
                  style: TextStyle(fontSize: 13),
                ))
          ],
        ),
      ),
    );
  }
}
