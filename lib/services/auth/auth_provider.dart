import 'package:student_personal_assistant/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future addUserCredentials(String fName, String lName, String email);
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
}
