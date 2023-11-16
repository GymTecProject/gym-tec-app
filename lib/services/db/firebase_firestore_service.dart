import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/weekly_challeges/weekly_challenge.dart';

import '../../models/users/user_measurements.dart';

class DatabaseFirebase implements DatabaseInterface {
  late FirebaseFirestore firebaseInstance;

  @override
  Future<List<UserPublicData>?> getAllUsers() async {
    try {
      var users = await firebaseInstance.collection('users').get();
      if (users.docs.isNotEmpty) {
        return users.docs.map((doc) {
          final data = doc.data();
          data.addAll({'uid': doc.id});
          return UserPublicData.fromJson(data);
        }).toList();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<List<UserPublicData>?> getActiveUsers() async {
    try {
      var users = await firebaseInstance
          .collection('users')
          .where('expirationDate', isGreaterThan: Timestamp.now())
          .get();
      if (users.docs.isNotEmpty) {
        return users.docs.map((doc) {
          final data = doc.data();
          data.addAll({'uid': doc.id});
          return UserPublicData.fromJson(data);
        }).toList();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<UserPublicData?> getUserPublicData(String uid) async {
    try {
      var userPublicData =
          await firebaseInstance.collection('users').doc(uid).get();
      if (userPublicData.exists) {
        final data = userPublicData.data()!;
        data.addAll({'uid': userPublicData.id});
        return UserPublicData.fromJson(data);
      }
      return null;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<UserProtectedData?> getUserProtectedData(String uid) async {
    try {
      var userProtectedData = await firebaseInstance
          .collection('users')
          .doc(uid)
          .collection('protected')
          .doc('data')
          .get();
      if (userProtectedData.exists) {
        var data = userProtectedData.data()!;
        data.addAll({'uid': userProtectedData.id});
        return UserProtectedData.fromMap(data);
      }
      return null;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<UserPrivateData?> getUserPrivateData(String uid) async {
    try {
      var userPrivateData = await firebaseInstance
          .collection('users')
          .doc(uid)
          .collection('private')
          .doc('data')
          .get();
      if (userPrivateData.exists) {
        return UserPrivateData.fromMap(userPrivateData.data()!);
      }
      return null;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<String?> updateUserExpirationDate(
      String uid, Timestamp newExpirationDate) async {
    try {
      await firebaseInstance.collection('users').doc(uid).update({
        'expirationDate': newExpirationDate,
      });
      return uid;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<String?> createUserMeasurement(
      String uid, Map<String, dynamic> data) async {
    try {
      await firebaseInstance
          .collection('users')
          .doc(uid)
          .collection('measurements')
          .add(data);
      return uid;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<UserMeasurement?> getUserLatestMeasurement(String uid) async {
    try {
      var userMeasurement = await firebaseInstance
          .collection('users')
          .doc(uid)
          .collection('measurements')
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      if (userMeasurement.docs.isNotEmpty) {
        return UserMeasurement.fromJson(userMeasurement.docs.first.data());
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<List<UserMeasurement>?> getUserMeasurements(String uid) async {
    try {
      var userMeasurements = await firebaseInstance
          .collection('users')
          .doc(uid)
          .collection('measurements')
          .get();
      if (userMeasurements.docs.isNotEmpty) {
        return userMeasurements.docs.map((doc) {
          final data = doc.data();
          data.addAll({'uid': doc.id});
          return UserMeasurement.fromJson(data);
        }).toList();
      }
      return null;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<String?> createUserPublicData(
      String uid, Map<String, dynamic> data) async {
    try {
      await firebaseInstance.collection('users').doc(uid).set(data);
      return uid;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<String?> createUserProtectedData(
      String uid, Map<String, dynamic> data) async {
    try {
      await firebaseInstance
          .collection('users')
          .doc(uid)
          .collection('protected')
          .doc('data')
          .set(data);
      return uid;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<String?> createUserPrivateData(
      String uid, Map<String, dynamic> data) async {
    try {
      await firebaseInstance
          .collection('users')
          .doc(uid)
          .collection('private')
          .doc('data')
          .set(data);
      return uid;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<RoutineData?> getUserRoutine(String uid) async {
    //TODO: implement getUserRoutine
    return null;
  }

  @override
  Future<List<Exercise>> getExercises() async {
    try {
      var exercises = await firebaseInstance.collection('exercises').get();
      if (exercises.docs.isNotEmpty) {
        return exercises.docs.map((doc) {
          final data = doc.data();
          return Exercise.fromJson(data);
        }).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<RoutineData?> getUserLastestRoutine(String uid) async {
    try {
      var routine = await firebaseInstance
          .collection('routines')
          .where('clientId', isEqualTo: uid)
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      if (routine.docs.isNotEmpty) {
        routine.docs.first.data();
        return RoutineData.fromJson(routine.docs.first.data());
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> createRoutine(Map<String, dynamic> data) async {
    try {
      await firebaseInstance.collection('routines').add(data);
      return 'success';
    } catch (e) {
      return null;
    }
  }

  // Weekly challenges =========================

  @override
  Future<WeeklyChallenge?> getLatestWeeklyChallenge() async {
    try {
      var weeklyChallenge = await firebaseInstance
          .collection('weeklyChallenges')
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      if (weeklyChallenge.docs.isNotEmpty) {
        return WeeklyChallenge.fromJson(weeklyChallenge.docs.first.data());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> createWeeklyChallenge(Map<String, dynamic> data) async {
    try {
      await firebaseInstance.collection('weeklyChallenges').add(data);
      return 'success';
    } catch (e) {
      return null;
    }
  }

  DatabaseFirebase({
    required this.firebaseInstance,
  });
}
