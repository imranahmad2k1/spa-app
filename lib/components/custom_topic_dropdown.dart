import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomTopicDropdown extends StatelessWidget {
  const CustomTopicDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    // Initial Selected Value
    String dropdownvalue = 'Select topic';

    // List of items in our dropdown menu
    var items = [
      'Select topic',
      'Topic 1',
      'Topic 2',
      'Topic 3',
      'Topic 4',
      'Topic 5',
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
            const SizedBox(
              width: 150,
              height: 39,
              child: TextField(
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Enter subtopic',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Color(fieldUnselectedTextColor),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(borderColor),
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(borderColor),
                    ),
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(borderColor),
                    ),
                    borderRadius: BorderRadius.zero,
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
