import 'dart:io' show File;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_personal_assistant/services/auth/auth_provider.dart';
import 'package:student_personal_assistant/services/auth/auth_user.dart';
import 'package:student_personal_assistant/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future addUserCredentials(String fName, String lName, String email) =>
      provider.addUserCredentials(fName, lName, email);

  @override
  Future<void> resetPassword(String email) => provider.resetPassword(email);

  @override
  Future<void> updateEmail(String email) => provider.updateEmail(email);

  @override
  Future addDaysMap(Map<String, dynamic> daysMap) =>
      provider.addDaysMap(daysMap);

  @override
  Future<UploadTask> uploadFile(
          File file, String subjectName, String fileName) =>
      provider.uploadFile(file, subjectName, fileName);
}
