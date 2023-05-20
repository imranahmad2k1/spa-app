import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool? alignLeft;
  const CustomText({super.key, required this.text, this.alignLeft});

  @override
  Widget build(BuildContext context) {
    TextAlign align;
    alignLeft == true ? align = TextAlign.left : align = TextAlign.center;
    return Text(
      text,
      textAlign: align,
      style: const TextStyle(
        fontSize: 15,
      ),
    );
  }
}
