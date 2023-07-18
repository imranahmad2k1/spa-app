import 'dart:io' show File;

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class CustomOutline extends StatefulWidget {
  final String subjectName;
  const CustomOutline({super.key, required this.subjectName});

  @override
  State<CustomOutline> createState() => _CustomOutlineState();
}

class _CustomOutlineState extends State<CustomOutline> {
  firebase_storage.ListResult? result;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> listAllFiles() async {
    result = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files')
        .child(widget.subjectName)
        .listAll();
  }

  Future<void> downloadURLs(firebase_storage.ListResult result) async {
    for (var element in result.items) {
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(element.fullPath)
          .getDownloadURL();
      await readCSVFromURL(downloadURL);
    }
  }

  Future<void> readCSVFromURL(String downloadURL) async {
    final response = await http.get(Uri.parse(downloadURL));
    if (response.statusCode == 200) {
      final csvData = response.body;
      const csvParser = CsvToListConverter();
      final List<List<dynamic>> csvList = csvParser.convert(csvData);

      // Process the CSV data
      for (var row in csvList) {
        print(row);
      }
    } else {
      print('Failed to download CSV file');
    }
  }

  @override
  void initState() {
    listAllFiles().then((_) => downloadURLs(result!));
    print('Init Completed');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initial Selected Value
    // String dropdownvalue = subjectName;

    // List of items in our dropdown menu
    var items = [
      "Item 1",
      'Item 2',
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
                    hint: Container(
                        width: 230,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        child: Text(
                          'Select "${widget.subjectName}" outlines',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Color(fieldUnselectedTextColor),
                          ),
                        )),
                    // value: dropdownvalue,
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
                                color: Colors.black,
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
                // final paths = await FlutterDocumentPicker.openDocuments();
                final path = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['csv'],
                );

                if (path != null) {
                  final file = File(path.files.single.path!);
                  // Upload the file to Firebase or perform other operations with it

                  //IF FIRST TIME UPLOADING FILEEXT = 1
                  //int ext = fileReads.length;
                  int ext = 0;
                  ext += 1;
                  await AuthService.firebase().uploadFile(
                      file,
                      widget.subjectName,
                      "${widget.subjectName} v${ext.toString()}");
                  //  if (context.mounted) {
                  //               Navigator.of(context).pushNamed(uploadOutlinesRoute);
                  //             }
                } else {
                  // User canceled the picker
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
