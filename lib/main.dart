import 'package:flutter/material.dart';
import 'package:student_personal_assistant/components/recommendations/carousel_slider.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/views/homepage_view.dart';
import 'package:student_personal_assistant/views/login/forgot_password_view.dart';
import 'package:student_personal_assistant/views/login/login_view.dart';
import 'package:student_personal_assistant/views/login/password_reset_email_view.dart';
import 'package:student_personal_assistant/views/quiz/quiztest_view.dart';
import 'package:student_personal_assistant/views/recommended_topics_view.dart';
import 'package:student_personal_assistant/views/register/create_an_account_view.dart';
import 'package:student_personal_assistant/views/register/verify_email_view.dart';
import 'package:student_personal_assistant/views/revise/revise_view.dart';
import 'package:student_personal_assistant/views/setup/set_weekly_timetable_view.dart';
import 'package:student_personal_assistant/views/setup/upload_course_outlines_view.dart';
import 'package:student_personal_assistant/views/study/recommended_subjects_view.dart';
import 'package:student_personal_assistant/views/study/study_view.dart';
import 'package:student_personal_assistant/views/welcome_view.dart';
import 'package:student_personal_assistant/constants/routes.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    routes: {
      initialRoute: (context) => const WelcomeView(),
      loginRoute: (context) => const LoginView(),
      forgotPassowrdRoute: (context) => const ForgotPasswordView(),
      resetPassworRoute: (context) => const PasswordResetEmailView(),
      registerRoute: (context) => const CreateAnAccountView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      setupRoute: (context) => const SetWeeklyTimetableView(),
      uploadOutlinesRoute: (context) => const UploadCourseOutlinesView(),
      homepageRoute: (context) => const HomepageView(),
      reviseRoute: (context) => const ReviseView(),
      recommendRoute: (context) => const RecommendedTopicsView(),
      studyRoute: (context) => const StudyView(),
      recommendSubjectsRoute: (context) => const RecommendedSubjectsView(),
      quizRoute: (context) => const QuizTestView(),
    },
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(primaryColor)),
      useMaterial3: true,
    ),
    home: const WelcomeView(),
  ));
}
