import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class CustomTopicDropdown extends StatefulWidget {
  final String subjectName;
  final List<String>? selectedValues;
  final Function(List<String>?) updateSelectedValue;

  const CustomTopicDropdown(
      {super.key,
      required this.subjectName,
      required this.updateSelectedValue,
      this.selectedValues});

  @override
  State<CustomTopicDropdown> createState() => _CustomTopicDropdownState();
}

class _CustomTopicDropdownState extends State<CustomTopicDropdown> {
  bool isLoading = true;
  // List<String>? get selectedValues => widget.selectedValues; // Add this line
  List<String>? selectedValues;

  String? dropdownvalue;
  List<List<dynamic>>? csvList;
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

  fetchOutlines() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final collectionRef =
          FirebaseFirestore.instance.collection('SelectedOutlines');
      final querySnapshot = await collectionRef
          .where('Email', isEqualTo: user.email)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final selectedOutlinesData =
            querySnapshot.docs[0].data()['selectedOutlinesMap'];
        String version =
            selectedOutlinesData[widget.subjectName].split(' ').last;
        await listAllFiles();
        await downloadURLs(result!, version);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> downloadURLs(
      firebase_storage.ListResult result, String version) async {
    for (var element in result.items) {
      String compareVersion =
          element.fullPath.split(' ').last.replaceAll('.csv', '');
      if (version == compareVersion) {
        String downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref(element.fullPath)
            .getDownloadURL();
        await readCSVFromURL(downloadURL);
      }
    }
  }

  Future<void> readCSVFromURL(String downloadURL) async {
    final response = await http.get(Uri.parse(downloadURL));
    if (response.statusCode == 200) {
      final csvData = response.body;
      const csvParser = CsvToListConverter();
      // final List<List<dynamic>> csvList = csvParser.convert(csvData);
      csvList = csvParser.convert(csvData);

      // Process the CSV data
      // for (var row in csvList!) {
      //   print("Topic: ${row[1]}");
      // }
    } else {
      // print('Failed to download CSV file');
    }
  }

  @override
  void initState() {
    // selectedValues = widget.selectedValues != null
    //     ? List.from(widget
    //         .selectedValues!) // Create a new list to avoid reference issues
    //     : [];
    selectedValues = widget.selectedValues;
    fetchOutlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: fetchOutlines(),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        // return const Center(
        // child: CircularProgressIndicator(),
        // );
        // } else
        if (isLoading) {
          // If loading is true, show "Loading..." text
          return const Column(
            children: [
              // Show "Loading..." text
              Center(
                child: Text('Loading...'),
              ),
            ],
          );
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            var items = csvList != null
                ? csvList!.map((row) => row[1].toString()).toList()
                : ['Loading...'];
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(borderColor)),
                        borderRadius: BorderRadius.circular(3.0),
                        // color: Colors.white,
                        // color: const Color(fieldBackgroundColor),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: SizedBox(
                          height: 37,
                          child: DropdownButton(
                            hint: Container(
                                width: 205,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                                child: const Text(
                                  'Select topic that you read today',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Color(fieldUnselectedTextColor),
                                  ),
                                )),
                            value: dropdownvalue,
                            items: items.map((String item) {
                              // int index = items.indexOf(item);
                              return DropdownMenuItem(
                                value: item,
                                child: Tooltip(
                                  message: item,
                                  child: Container(
                                    width: 205,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                    ),
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                if (dropdownvalue != null) {
                                  // Find the index of the previously selected value
                                  int prevIndex =
                                      selectedValues!.indexOf(dropdownvalue!);
                                  if (prevIndex != -1) {
                                    // Replace the previously selected value with the new value
                                    selectedValues![prevIndex] = value!;
                                  }
                                } else {
                                  // Add the new selected value to the list
                                  if (value != null) {
                                    selectedValues!.add(value);
                                  }
                                }
                                dropdownvalue = value;
                                widget.updateSelectedValue(selectedValues);
                              });
                            },
                            // onChanged: (String? value) {
                            //   setState(() {
                            //     //CHATGPT, I somehow want to access Previously selected value here
                            //     print("PREV: $dropdownvalue");
                            //     print("NOW: $value");
                            //     if (dropdownvalue != null) {
                            //       int index =
                            //           selectedValues!.indexOf(dropdownvalue!);
                            //       if (index != -1) {
                            //         // Replace 'C' with 'D'
                            //         print(
                            //             "PREV INDEXED: ${selectedValues![index]}");
                            //         selectedValues![index] = value!;
                            //         print(
                            //             "NOW INDEXED: ${selectedValues![index]}");
                            //       }
                            //       // else {
                            //       //   print('Element not found in the list');
                            //       // }
                            //     } else {
                            //       if (value != null) {
                            //         selectedValues!
                            //             .add(value); // Add the new selected value
                            //       }
                            //     }
                            //     dropdownvalue = value;
                            //     print(selectedValues);
                            //     // Call the callback function to update the selected value in StudiedTodayView
                            //     widget.updateSelectedValue(selectedValues);
                            //   });
                            // },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // const SizedBox(
                    //   width: 150,
                    //   height: 39,
                    //   child: TextField(
                    //     maxLines: 1,
                    //     textAlignVertical: TextAlignVertical.bottom,
                    //     style: TextStyle(
                    //       fontSize: 13,
                    //       fontWeight: FontWeight.w300,
                    //       color: Colors.black,
                    //     ),
                    //     decoration: InputDecoration(
                    //       isDense: true,
                    //       hintText: 'Enter subtopic',
                    //       hintStyle: TextStyle(
                    //         fontSize: 13,
                    //         fontWeight: FontWeight.w300,
                    //         color: Color(fieldUnselectedTextColor),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(borderColor),
                    //         ),
                    //         borderRadius: BorderRadius.zero,
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(borderColor),
                    //         ),
                    //         borderRadius: BorderRadius.zero,
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(borderColor),
                    //         ),
                    //         borderRadius: BorderRadius.zero,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            );
          }
        }
      },
    );
  }
}
