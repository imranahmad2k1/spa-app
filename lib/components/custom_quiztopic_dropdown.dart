import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/views/study/topic_class.dart';

class CustomQuizTopicDropdown extends StatefulWidget {
  final List<Topic> topics;
  final List<Topic>? selectedTopics;
  final int index;
  final Function(Topic) onTopicSelected;

  const CustomQuizTopicDropdown(
      {super.key,
      required this.selectedTopics,
      required this.onTopicSelected,
      required this.topics,
      required this.index});

  @override
  State<CustomQuizTopicDropdown> createState() =>
      _CustomQuizTopicDropdownState();
}

class _CustomQuizTopicDropdownState extends State<CustomQuizTopicDropdown> {
  String? dropdownvalue;
  // List<Topic>? selectedValues;

  @override
  void initState() {
    // selectedValues = widget.selectedValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    hint: Container(
                      width: 205,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: const Text(
                        'Select topic',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Color(fieldUnselectedTextColor),
                        ),
                      ),
                    ),
                    value: dropdownvalue,
                    items: widget.topics.map((Topic item) {
                      return DropdownMenuItem(
                        value: item.name,
                        child: Container(
                          width: 205,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        // log(dropdownvalue.toString());
                        Topic? madeTopic = widget.topics.firstWhere(
                          (topic) => topic.name == value,
                        );
                        if (dropdownvalue != null) {
                          int prevIndex = widget.selectedTopics!.indexWhere(
                              (element) => element.name == dropdownvalue);

                          if (prevIndex != -1) {
                            widget.selectedTopics![prevIndex] = madeTopic;
                          }
                        } else {
                          widget.selectedTopics!.add(madeTopic);
                        }

                        dropdownvalue = value;
                      });
                      // Topic? selectedTopic = widget.topics.firstWhere(
                      //   (topic) => topic.name == value,
                      // );
                      // widget.onTopicSelected(selectedTopic);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }
}
