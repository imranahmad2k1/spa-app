import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 115),
          Image.asset(
            'assets/images/welcome.png',
            width: 265,
            height: 219,
          ),
          const Divider(
            color: Color(dividerColor),
            height: 11,
            indent: 45,
            endIndent: 45,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Develop discipline, \nGenerate study plan, \nand ace your exams",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 110,
          ),
          InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(30),
              child: Ink(
                width: 268,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(primaryColor),
                ),
                child: const Center(
                    child: Text(
                  'Create new account',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                )),
              )),
          const SizedBox(height: 19),
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
                  'I already have an account',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                )),
              )),
        ],
      ),
    );
  }
}
