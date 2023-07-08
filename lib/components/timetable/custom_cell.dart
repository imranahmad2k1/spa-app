import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class CustomCell extends StatefulWidget {
  // final VoidCallback onPressed;
  final String onPressed;
  final Map<String, dynamic> daysMap;
  const CustomCell({
    super.key,
    required this.onPressed,
    required this.daysMap,
  });

  @override
  State<CustomCell> createState() => _CustomCellState();
}

class _CustomCellState extends State<CustomCell> {
  final TextEditingController _subjectNameController = TextEditingController();
  String? _subjectName;

  @override
  void dispose() {
    _subjectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.daysMap[widget.onPressed] != null) {
      _subjectName = widget.daysMap[widget.onPressed];
    }

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
                      var newSubjectName = _subjectNameController.text.trim();
                      if (newSubjectName.isNotEmpty) {
                        newSubjectName = toTitleCase(newSubjectName);
                        //access daysMap from widget
                        if (!widget.daysMap.containsKey(newSubjectName)) {
                          widget.daysMap[widget.onPressed] = newSubjectName;
                        }
                        setState(() {
                          _subjectName = newSubjectName;
                        });
                      } else {
                        widget.daysMap.remove(widget.onPressed);
                        setState(() {
                          _subjectName = null;
                        });
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text("Subject name cannot be empty"),
                        //   ),
                        // );
                      }
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

String toTitleCase(String input) {
  List<String> words = input.split(' ');
  words = words.map((word) {
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).toList();
  return words.join(' ');
}
