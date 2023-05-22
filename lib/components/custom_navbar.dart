import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/custom_icons_icons.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedMenu;
  const CustomNavBar({super.key, required this.selectedMenu});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: "Home",
          selectedIcon: Icon(
            Icons.home,
            color: Color(primaryColor),
          ),
        ),
        NavigationDestination(
          icon: Icon(CustomIcons.revise),
          label: "Revise",
          selectedIcon: Icon(
            CustomIcons.revise,
            color: Color(primaryColor),
          ),
        ),
        NavigationDestination(
          icon: Icon(CustomIcons.study),
          label: "Study",
          selectedIcon: Icon(
            CustomIcons.study,
            color: Color(primaryColor),
          ),
        ),
        NavigationDestination(
          icon: Icon(CustomIcons.quiz),
          label: "Quiz",
          selectedIcon: Icon(
            CustomIcons.quiz,
            color: Color(primaryColor),
          ),
        ),
      ],
      selectedIndex: selectedMenu,
      onDestinationSelected: (int index) {},
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      shadowColor: const Color(primaryColor),
    );
  }
}
