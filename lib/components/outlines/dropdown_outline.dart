import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';

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
              onPressed: () async {
                final paths = await FlutterDocumentPicker.openDocuments();

                if (paths != null && paths.isNotEmpty) {
                  final path = paths.first;

                  if (path != null) {
                    final file = File(path);
                    // Upload the file to Firebase or perform other operations with it
                    await AuthService.firebase()
                        .uploadFile(file, "testSubject", "TestName");

                    //Navigator.pop(context);
                    //  if (context.mounted) {
                    //               Navigator.of(context).pushNamed(uploadOutlinesRoute);
                    //             }
                  }
                }
              },
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
