import 'package:student_personal_assistant/services/auth/auth_user.dart';

abstract class AuthProvider {
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
  // Future getDaysMap(Map<String, String> daysMap);
}
