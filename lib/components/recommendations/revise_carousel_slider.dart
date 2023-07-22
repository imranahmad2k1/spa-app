import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class ReviseCarouselSliderComponent extends StatefulWidget {
  final Map<String, List<String>> subjectTopicDropdowns;
  final Function(String, String, String) onUnderstandingLevelChanged;
  const ReviseCarouselSliderComponent(
      {Key? key,
      required this.subjectTopicDropdowns,
      required this.onUnderstandingLevelChanged})
      : super(key: key);

  @override
  State<ReviseCarouselSliderComponent> createState() =>
      _ReviseCarouselSliderComponentState();
}

class _ReviseCarouselSliderComponentState
    extends State<ReviseCarouselSliderComponent> {
  Map<String, String> understandingLevels = {};
  int? selectedLevel;

  void showUnderstandingDialog(String subject, String topic) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Please set your understanding level for $subject:\n$topic',
                style: const TextStyle(
                    fontSize: 16.0), // Adjust the title font size
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(7, (index) {
                  final level = index + 1;
                  return Row(
                    children: [
                      Radio<int>(
                        value: level,
                        groupValue: selectedLevel,
                        onChanged: (value) {
                          setState(() {
                            selectedLevel = value;
                          });
                        },
                      ),
                      Text(
                        level.toString(),
                        style: const TextStyle(
                            fontSize:
                                12.0), // Adjust the radio button font size
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
                        understandingLevels["$subject: $topic"] =
                            selectedLevel.toString();
                      });
                      Navigator.of(context).pop();
                      widget.onUnderstandingLevelChanged(
                        subject, // Pass the subject
                        topic, // Pass the topic
                        selectedLevel.toString(), // Pass the selected level
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

    widget.subjectTopicDropdowns.forEach((subject, topics) {
      for (String topic in topics) {
        final String subjectTopic = "$subject: $topic";

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
                    subjectTopic,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showUnderstandingDialog(subject, topic);
                  },
                  icon: Icon(
                    understandingLevels.containsKey(subjectTopic)
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    color: understandingLevels.containsKey(subjectTopic)
                        ? const Color(primaryColor)
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
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
