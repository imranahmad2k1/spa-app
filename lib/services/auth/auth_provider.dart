import 'dart:io' show File;
import 'package:student_personal_assistant/services/auth/auth_user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

abstract class AuthProvider {
  Future<firebase_storage.UploadTask> uploadFile(
      File file, String subjectName, String filename);
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> resetPassword(String email);
  Future<void> updateEmail(String email);
  Future addUserCredentials(String fName, String lName, String email);
  Future addDaysMap(Map<String, dynamic> daysMap);
  Future saveSelectedOutlines(Map<String, String?> selectedOutlines);
  Future saveUnderstandingLevel(
      Map<String, Map<String, List<Map<String, dynamic>>>> topicsMap);
  // Future getDaysMap(Map<String, String> daysMap);
}
