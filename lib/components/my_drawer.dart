import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/custom_heading.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/services/auth/auth_service.dart';
import 'package:student_personal_assistant/utilities/show_logout_dialog.dart';

class MyDrawer extends StatelessWidget {
  final String firstName;
  const MyDrawer({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    String displayName;
    if (firstName.isEmpty) {
      displayName = "User";
    } else {
      displayName = firstName;
    }
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 165,
            child: DrawerHeader(
              decoration: const BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  CustomHeading(text: displayName),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Timetable'),
            onTap: () {
              Navigator.of(context).pushNamed(setupRoute, arguments: {
                'fromChange': true,
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_document),
            title: const Text('Edit Outlines'),
            onTap: () {
              Navigator.of(context).pushNamed(uploadOutlinesRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () async {
              final shouldLogout = await showLogOutDialog(context);
              if (shouldLogout) {
                await AuthService.firebase().logOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (_) => false,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
