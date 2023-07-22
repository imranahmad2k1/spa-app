import 'package:flutter/material.dart';

Future<bool?> showExitConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Confirm Exit"),
        content: const Text("Are you sure you want to exit the application?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Exit"),
          ),
        ],
      );
    },
  );
}
