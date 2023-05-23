import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/views/views_import.dart';

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
      studiedTodayRoute: (context) => const SelectSubjectTopicsView(),
      recommendRoute: (context) => const RecommendedTopicsView(),
      studyRoute: (context) => const StudyView(),
      recommendSubjectsRoute: (context) => const RecommendedSubjectsView(),
      quizRoute: (context) => const QuizTestView(),
      selectSubjectTopicsRoute: (context) => const SelectSubjectTopicsView(),
    },
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(primaryColor)),
      useMaterial3: true,
    ),
    home: const WelcomeView(),
  ));
}
