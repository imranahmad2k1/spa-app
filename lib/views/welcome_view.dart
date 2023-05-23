import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/constants/routes.dart';
// import 'package:carousel_slider/carousel_slider.dart';

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
          const CustomDivider(),
          const SizedBox(
            height: 40,
          ),
          // CarouselSlider(
          //   options: CarouselOptions(height: 110),
          //   items: [
          //     "Develop discipline, \nGenerate study plan, \nand ace your exams",
          //     "Let's make your study sessions more effective and efficient!",
          //     "Enhance your understanding and work on knowledge gaps",
          //   ].map((i) {
          //     return Builder(
          //       builder: (BuildContext context) {
          //         return SizedBox(
          //           child: Text(
          //             i,
          //             textAlign: TextAlign.center,
          //             style: const TextStyle(
          //               fontSize: 25,
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   }).toList(),
          // ),
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
          CustomButton(
            buttonText: "Create new account",
            onPressed: () {
              Navigator.of(context).pushNamed(registerRoute);
            },
          ),
          const SizedBox(height: 19),
          CustomButton(
            buttonText: "I already have an account",
            onPressed: () {
              Navigator.of(context).pushNamed(loginRoute);
            },
            isSecondary: true,
          )
        ],
      ),
    );
  }
}
