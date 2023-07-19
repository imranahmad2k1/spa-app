import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:student_personal_assistant/constants/colors.dart';

class ReviseCarouselSliderComponent extends StatelessWidget {
  final Map<String, List<String>> subjectTopicDropdowns;

  // final List<int> items = [1, 2, 3, 4, 5, 6, 7];

  const ReviseCarouselSliderComponent(
      {super.key, required this.subjectTopicDropdowns});

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = [];
    subjectTopicDropdowns.forEach((subject, topics) {
      for (String topic in topics) {
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
                    '$subject: $topic',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outline),
                ),
              ],
            ),
          ),
        );
      }
    });
    // final List<Widget> imageSliders = items
    //     .map((item) => Container(
    //         decoration: BoxDecoration(
    //           color: const Color(secondaryColor),
    //           border: Border.all(color: const Color(borderColor)),
    //         ),
    //         padding: const EdgeInsets.only(left: 10),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Flexible(
    //               child: Text(
    //                 'Index: ${items.indexOf(item)}, Topic: $item',
    //                 style: const TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 12.0,
    //                     fontWeight: FontWeight.w300),
    //               ),
    //             ),
    //             IconButton(
    //               onPressed: () {},
    //               icon: const Icon(Icons.check_circle_outline),
    //             )
    //           ],
    //         )))
    //     .toList();

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
