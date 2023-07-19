import 'dart:io' show File;

// import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;

class CustomOutline extends StatefulWidget {
  final String subjectName;
  final Function(String?) onChanged;
  final String? dropdownValue;
  const CustomOutline(
      {super.key,
      required this.subjectName,
      required this.onChanged,
      this.dropdownValue});

  @override
  State<CustomOutline> createState() => _CustomOutlineState();
}

class _CustomOutlineState extends State<CustomOutline> {
  onChanged(value) {
    widget.onChanged(value);
  }

  firebase_storage.ListResult? result;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Map<String, List<String>> subjectOutlines = {};
  // String? dropdownValue;

  Future<void> listAllFiles() async {
    result = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files')
        .child(widget.subjectName)
        .listAll();

    if (context.mounted) {
      for (var ref in result!.items) {
        String outlineName =
            ref.fullPath.split('/').last.replaceAll('.csv', '');
        if (subjectOutlines[widget.subjectName] == null) {
          subjectOutlines[widget.subjectName] = [];
        }
        if (subjectOutlines[widget.subjectName]!.contains(outlineName) ==
            false) {
          subjectOutlines[widget.subjectName]!.add(outlineName);
        }
      }
    }
  }

  // Future<void> downloadURLs(firebase_storage.ListResult result) async {
  //   for (var element in result.items) {
  //     String downloadURL = await firebase_storage.FirebaseStorage.instance
  //         .ref(element.fullPath)
  //         .getDownloadURL();
  //     await readCSVFromURL(downloadURL);
  //   }
  // }

  // Future<void> readCSVFromURL(String downloadURL) async {
  //   final response = await http.get(Uri.parse(downloadURL));
  //   if (response.statusCode == 200) {
  //     final csvData = response.body;
  //     const csvParser = CsvToListConverter();
  //     final List<List<dynamic>> csvList = csvParser.convert(csvData);

  //     // Process the CSV data
  //     for (var row in csvList) {
  //       print(row);
  //     }
  //   } else {
  //     print('Failed to download CSV file');
  //   }
  // }

  @override
  void initState() {
    // subjectOutlines[widget.subjectName] = [];
    listAllFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: listAllFiles(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Text("Wait:");
        // } else
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.hasError}");
        } else {
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
                            value: widget.dropdownValue,
                            // value: dropdownvalue,
                            items: subjectOutlines[widget.subjectName]
                                    ?.map((String items) {
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
                                }).toList() ??
                                [],
                            onChanged: onChanged),
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

                        int ext =
                            subjectOutlines[widget.subjectName]?.length ?? 0;
                        ext += 1;
                        await AuthService.firebase().uploadFile(
                            file,
                            widget.subjectName,
                            "${widget.subjectName} v${ext.toString()}");
                        if (context.mounted) {
                          setState(() {
                            if (subjectOutlines[widget.subjectName] == null) {
                              subjectOutlines[widget.subjectName] = [];
                            }
                            subjectOutlines[widget.subjectName]?.add(
                                "${widget.subjectName} v${ext.toString()}");
                            // dropdownValue =
                            //     "${widget.subjectName} v${ext.toString()}";
                          });
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
      },
    );
  }
}
