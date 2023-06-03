import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomQuizTopicDropdown extends StatelessWidget {
  const CustomQuizTopicDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    // Initial Selected Value
    String dropdownvalue = 'Select topic';
    String sdropdownvalue = 'Subtopic';

    // List of items in our dropdown menu
    var items = [
      'Select topic',
      'Topic 1',
      'Topic 2',
      'Topic 3',
      'Topic 4',
      'Topic 5',
    ];
    var sitems = [
      'Subtopic',
      'Subtopic 1',
      'Subtopic 2',
      'Subtopic 3',
      'Subtopic 4',
      'Subtopic 5',
    ];
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(borderColor)),
                borderRadius: BorderRadius.circular(3.0),
                color: const Color(fieldBackgroundColor),
              ),
              child: DropdownButtonHideUnderline(
                child: SizedBox(
                  height: 37,
                  child: DropdownButton(
                    value: dropdownvalue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Container(
                          // width: 230,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Color(fieldUnselectedTextColor),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {},
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(borderColor)),
                borderRadius: BorderRadius.circular(3.0),
                color: const Color(fieldBackgroundColor),
              ),
              child: DropdownButtonHideUnderline(
                child: SizedBox(
                  height: 37,
                  child: DropdownButton(
                    value: sdropdownvalue,
                    items: sitems.map((String sitems) {
                      return DropdownMenuItem(
                        value: sitems,
                        child: Container(
                          // width: 230,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          child: Text(
                            sitems,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Color(fieldUnselectedTextColor),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {},
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 24,
                )),
          ],
        ),
      ],
    );
  }
}
