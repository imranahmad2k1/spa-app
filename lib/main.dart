import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/views/login/forgot_password_view.dart';
import 'package:student_personal_assistant/views/login/login_view.dart';
import 'package:student_personal_assistant/views/register/create_an_account_view.dart';
import 'package:student_personal_assistant/views/register/verify_email_view.dart';
import 'package:student_personal_assistant/views/welcome_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(primaryColor)),
      useMaterial3: true,
    ),
    home: const ForgotPasswordView(),
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
    );
  }
}
