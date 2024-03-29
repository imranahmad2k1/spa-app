import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:student_personal_assistant/helpers/loading/loading_screen.dart';
import 'package:student_personal_assistant/services/auth/auth_exceptions.dart';
import 'package:student_personal_assistant/services/auth/auth_provider.dart';
import 'package:student_personal_assistant/services/auth/auth_user.dart';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:student_personal_assistant/firebase_options.dart';

class FirebaseAuthProvider implements AuthProvider {
  static bool _initialized = false;
  @override
  Future<void> initialize() async {
    if (!_initialized) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _initialized = true;
    }
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      LoadingScreen().hide();
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      LoadingScreen().hide();
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotFoundAuthException();
    }
  }

  @override
  Future addUserCredentials(String fName, String lName, String email) async {
    // if (fName == '' || lName == '' || email == '') {
    //   throw EmptyFieldAuthException();
    // }
    await FirebaseFirestore.instance.collection('Users').add({
      'First Name': fName,
      'Last Name': lName,
      'Email': email,
    });
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      LoadingScreen().hide();
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> updateEmail(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateEmail(email);
      } on FirebaseAuthException catch (e) {
        LoadingScreen().hide();
        if (e.code == 'user-not-found') {
          throw UserNotFoundAuthException();
        } else if (e.code == 'invalid-email') {
          throw InvalidEmailAuthException();
        } else if (e.code == 'email-already-in-use') {
          throw EmailAlreadyInUseAuthException();
        } else {
          throw GenericAuthException();
        }
      }
    } else {
      throw UserNotFoundAuthException();
    }
  }

  @override
  Future addDaysMap(Map<String, dynamic> daysMap) async {
    final user = FirebaseAuth.instance.currentUser;

    //if already exists, then update it
    bool exists = false;
    await FirebaseFirestore.instance
        .collection('DaysMaps')
        .where('Email', isEqualTo: user!.email)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.exists) {
          exists = true;
          element.reference.update({'daysMap': daysMap});
        }
      }
    });

    //if it doesn't, then add it
    //CAN ADD EXCEPTIONS HERE
    if (!exists) {
      await FirebaseFirestore.instance.collection('DaysMaps').add({
        'Email': user.email,
        'daysMap': daysMap,
      });
    }
  }

  @override
  Future<firebase_storage.UploadTask> uploadFile(
      File file, String subjectName, String fileName) async {
    // if (file == null) {
    //  return CircularProgressIndicator();
    // }
    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files')
        .child('/$subjectName')
        .child("/$fileName.csv");

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    // print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    // print("Done..!");
    return Future.value(uploadTask);
  }

  @override
  Future saveSelectedOutlines(Map<String, String?> selectedOutlines) async {
    final user = FirebaseAuth.instance.currentUser;

    //if already exists, then update it
    bool exists = false;
    await FirebaseFirestore.instance
        .collection('SelectedOutlines')
        .where('Email', isEqualTo: user!.email)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.exists) {
          exists = true;
          element.reference.update({'selectedOutlinesMap': selectedOutlines});
        }
      }
    });

    //if it doesn't, then add it
    //CAN ADD EXCEPTIONS HERE
    if (!exists) {
      await FirebaseFirestore.instance.collection('SelectedOutlines').add({
        'Email': user.email,
        'selectedOutlinesMap': selectedOutlines,
      });
    }
  }

  @override
  Future<void> saveUnderstandingLevel(
    Map<String, Map<String, List<Map<String, dynamic>>>> topicsMap,
  ) async {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    final collectionRef =
        FirebaseFirestore.instance.collection('UnderstandingLevels');

    // Check if document with the given email exists in the collection
    final querySnapshot =
        await collectionRef.where('Email', isEqualTo: userEmail).get();

    if (querySnapshot.docs.isNotEmpty) {
      // If document exists, update the topicsMap field
      final docID = querySnapshot.docs[0].id;
      final existingTopicsMap = querySnapshot.docs[0].data()['topicsMap'];

      // Merge the existing topicsMap with the new topicsMap
      topicsMap.forEach((subject, data) {
        if (existingTopicsMap.containsKey(subject)) {
          // Subject exists in the existingTopicsMap, update or append the topics
          final existingTopics = existingTopicsMap[subject]!['topics']!;
          final newTopics = data['topics']!;

          for (final newTopic in newTopics) {
            final index = existingTopics
                .indexWhere((topic) => topic['id'] == newTopic['id']);
            if (index >= 0) {
              // Topic already exists, update understanding level
              existingTopics[index]['understandingLevel'] =
                  newTopic['understandingLevel'];
            } else {
              // Topic is new, append it to existing topics
              existingTopics.add(newTopic);
            }
          }
        } else {
          // Subject doesn't exist in existingTopicsMap, add new subject and topics
          existingTopicsMap[subject] = data;
        }
      });

      // Update the document with the merged topicsMap
      await collectionRef.doc(docID).update({'topicsMap': existingTopicsMap});
    } else {
      // If document does not exist, add a new document
      await collectionRef.add({
        'Email': userEmail,
        'topicsMap': topicsMap,
      });
    }
  }
}
