import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/views/study/topic_class.dart';

class StudyCarouselSliderComponent extends StatefulWidget {
  final List<Topic> topics;
  final Function(Topic, int) onUnderstandingLevelChanged;
  const StudyCarouselSliderComponent({
    Key? key,
    required this.onUnderstandingLevelChanged,
    required this.topics,
  }) : super(key: key);

  @override
  State<StudyCarouselSliderComponent> createState() =>
      _StudyCarouselSliderComponentState();
}

class _StudyCarouselSliderComponentState
    extends State<StudyCarouselSliderComponent> {
  Map<String, String> understandingLevels = {};
  int? selectedLevel;

  void showUnderstandingDialog(Topic topic) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text.rich(TextSpan(children: [
                const TextSpan(
                    text: "Please set your understanding level for the topic:",
                    style: TextStyle(
                      fontSize: 13.0,
                    )),
                TextSpan(
                    text: '\n${topic.name}',
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold)),
              ])),
              content: Row(
                mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(7, (index) {
                  final level = index + 1;
                  String label = '';
                  if (index == 0) {
                    label = 'Didn’t\nunderstand\n(0-10%)';
                  } else if (index == 1) {
                    label = '10-30%\n\n';
                  } else if (index == 2) {
                    label = '30-50%\n\n';
                  } else if (index == 3) {
                    label = 'Neutral\n(50%)\n';
                  } else if (index == 4) {
                    label = '50-70%\n\n';
                  } else if (index == 5) {
                    label = '70-90%\n\n';
                  } else if (index == 6) {
                    label = 'Fully\nUnderstand\n(90-100%)';
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 35,
                        child: Radio<int>(
                          value: level,
                          groupValue: selectedLevel,
                          onChanged: (value) {
                            setState(() {
                              selectedLevel = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 8.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }),
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
                    if (selectedLevel != null) {
                      setState(() {
                        understandingLevels[topic.name] =
                            selectedLevel.toString();
                      });
                      Navigator.of(context).pop();
                      widget.onUnderstandingLevelChanged(
                        topic, // Pass the topic
                        selectedLevel!, // Pass the selected level
                      );
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
        }).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = [];

    for (var topic in widget.topics) {
      final String topicName = topic.name;
      // log(topicName.toString());

      imageSliders.add(
        Container(
          decoration: BoxDecoration(
            color: const Color(secondaryColor),
            border: Border.all(color: const Color(borderColor)),
          ),
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  topicName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showUnderstandingDialog(topic);
                },
                icon: Icon(
                  understandingLevels.containsKey(topicName)
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color: understandingLevels.containsKey(topicName)
                      ? const Color(primaryColor)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return CarouselSlider(
      options: CarouselOptions(
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enlargeFactor: 0.25,
          height: 320,
          viewportFraction: 0.2, //you can try 0.20 for 5 topics
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          scrollDirection: Axis.vertical),
      items: imageSliders,
    );
  }
}
