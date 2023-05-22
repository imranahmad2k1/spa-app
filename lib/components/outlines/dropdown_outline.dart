import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomOutline extends StatelessWidget {
  const CustomOutline({super.key});

  @override
  Widget build(BuildContext context) {
    // Initial Selected Value
    String dropdownvalue = 'Select or upload';

    // List of items in our dropdown menu
    var items = [
      'Select or upload',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                            width: 230,
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
                            )),
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
                Icons.upload,
                size: 24,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
