import 'package:flutter/material.dart';
import 'package:student_personal_assistant/constants/colors.dart';
import 'package:student_personal_assistant/constants/routes.dart';
import 'package:student_personal_assistant/views/views_import.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SPA',
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
      studiedTodayRoute: (context) => const StudiedTodayView(),
      reviseRecommendRoute: (context) => const ReviseRecommendedTopicsView(),
      studyRecommendRoute: (context) => const StudyRecommendedTopicsView(),
      allRecommendRoute: (context) => const AllStudyRecommendedTopicsView(),
      recommendRoute: (context) => const RecommendedTopicsView(),
      studyRoute: (context) => const StudyView(),
      recommendSubjectsRoute: (context) => const RecommendedSubjectsView(),
      quizRoute: (context) => const QuizTestView(),
      selectSubjectTopicsRoute: (context) => const SelectSubjectTopicsView(),
    },
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(primaryColor)),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFFFFF),
          surfaceTintColor: Color(0xFFFFFFFF)),
      useMaterial3: true,
    ),
    home: const WelcomeView(),
  ));
}
