import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class SubjectsCarouselSliderComponent extends StatefulWidget {
  final List<MapEntry<String, double>> subjects;
  final Function(String?) onSubjectSelected;
  const SubjectsCarouselSliderComponent(
      {super.key, required this.subjects, required this.onSubjectSelected});

  @override
  State<SubjectsCarouselSliderComponent> createState() =>
      _SubjectsCarouselSliderComponentState();
}

class _SubjectsCarouselSliderComponentState
    extends State<SubjectsCarouselSliderComponent> {
  List<MapEntry<String, double>>? subjectsGrabbed;
  List<String>? sitems;
  String? selectedSubject;

  @override
  void initState() {
    subjectsGrabbed = widget.subjects;
    // sitems = widget.subjects.map((entry) => entry.key.toString()+ " (Average Score: "+ entry.value.toString()+")").toList();
    sitems = widget.subjects.map((entry) => entry.key).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = sitems!.map((item) {
      final String subject = item;
      final bool isSelected = subject == selectedSubject;
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedSubject = isSelected ? null : subject;
          });
          // Pass the selected subject to the callback
          widget.onSubjectSelected(selectedSubject);
        },
        child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(primaryColor)
                  : const Color(secondaryColor),
              border: Border.all(color: const Color(borderColor)),
            ),
            padding: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    item,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: isSelected ? 14.0 : 12.0,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w300),
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.check_circle_outline),
                // )
              ],
            )),
      );
    }).toList();

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
