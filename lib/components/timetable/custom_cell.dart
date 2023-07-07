import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomCell extends StatefulWidget {
  // final VoidCallback onPressed;
  final int onPressed;
  const CustomCell({super.key, required this.onPressed});

  @override
  State<CustomCell> createState() => _CustomCellState();
}

class _CustomCellState extends State<CustomCell> {
  final TextEditingController _subjectNameController = TextEditingController();
  String? _subjectName;
  static List<String> subjectNames = [];
  static Map<int, String> daysMap = {};

  @override
  void dispose() {
    _subjectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        // onTap: onPressed,
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Subject'),
                content: TextField(
                  controller: _subjectNameController,
                  decoration: const InputDecoration(hintText: "Subject Name"),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final newSubjectName = _subjectNameController.text;
                      if (!subjectNames.contains(newSubjectName)) {
                        subjectNames.add(newSubjectName);
                      }
                      if (!daysMap.containsKey(newSubjectName)) {
                        daysMap[widget.onPressed] = newSubjectName;
                      }
                      setState(() {
                        _subjectName = _subjectNameController.text;

                        //FOR TESTING PURPOSE
                        // print(subjectNames);
                        // print(daysMap);
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(),
          child: Center(
            child: _subjectName != null
                ? Text(
                    _subjectName!,
                  )
                : const Icon(
                    Icons.add,
                    color: Color(borderColor),
                  ),
          ),
        ),
      ),
    );
  }
}
