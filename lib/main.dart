import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/views/homepage_view.dart';
import 'package:student_personal_assistant/views/login/forgot_password_view.dart';
import 'package:student_personal_assistant/views/login/login_view.dart';
import 'package:student_personal_assistant/views/login/password_reset_email_view.dart';
import 'package:student_personal_assistant/views/register/create_an_account_view.dart';
import 'package:student_personal_assistant/views/register/verify_email_view.dart';
import 'package:student_personal_assistant/views/setup/set_weekly_timetable_view.dart';
import 'package:student_personal_assistant/views/welcome_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(primaryColor)),
      useMaterial3: true,
    ),
    home: const SetWeeklyTimetableView(),
  ));
}
