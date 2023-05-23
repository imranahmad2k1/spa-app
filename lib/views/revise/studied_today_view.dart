import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_button.dart';
import 'package:student_personal_assistant/components/custom_divider.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/components/custom_topic_dropdown.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/constants/routes.dart';

class StudiedTodayView extends StatefulWidget {
  const StudiedTodayView({super.key});

  @override
  State<StudiedTodayView> createState() => _StudiedTodayViewState();
}

class _StudiedTodayViewState extends State<StudiedTodayView> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 83),
            const CustomHeading(
                text: "What topics did you\nstudy in your class\ntoday?"),
            const SizedBox(height: 20),
            const CustomDivider(alignLeft: true),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Data Structures & Algorithms",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.scale(
                  scale: .8,
                  child: Switch(
                    activeColor: const Color(primaryColor),
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: const Color(secondaryColor),
                    trackOutlineColor:
                        const MaterialStatePropertyAll(Color(0x00000000)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _value1,
                    onChanged: (value) {
                      setState(() {
                        _value1 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const CustomTopicDropdown(),
            const CustomTopicDropdown(),
            const CustomTopicDropdown(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Intro. to Software Engineering",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.scale(
                  scale: .8,
                  child: Switch(
                    activeColor: const Color(primaryColor),
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: const Color(secondaryColor),
                    trackOutlineColor:
                        const MaterialStatePropertyAll(Color(0x00000000)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _value2,
                    onChanged: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Discrete Structure",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.scale(
                  scale: .8,
                  child: Switch(
                    activeColor: const Color(primaryColor),
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: const Color(secondaryColor),
                    trackOutlineColor:
                        const MaterialStatePropertyAll(Color(0x00000000)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _value3,
                    onChanged: (value) {
                      setState(() {
                        _value3 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Intro to DBMS",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.scale(
                  scale: .8,
                  child: Switch(
                    activeColor: const Color(primaryColor),
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: const Color(secondaryColor),
                    trackOutlineColor:
                        const MaterialStatePropertyAll(Color(0x00000000)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _value4,
                    onChanged: (value) {
                      setState(() {
                        _value4 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 139),
            Center(
              child: CustomButton(
                buttonText: "Next",
                onPressed: () {
                  Navigator.of(context).pushNamed(recommendRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
