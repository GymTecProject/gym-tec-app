import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/models/routines/routine_workout.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/users/user_data_public_private.dart';
import 'package:gym_tec/models/weekly_challeges/challenge_data.dart';

import '../../models/users/user_measurements.dart';

class DatabaseFirebase implements DatabaseInterface {
  late FirebaseFirestore firebaseInstance;

  @override
  Stream<UserProtectedData> getUserProtectedDataStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('protected')
        .doc('data')
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists) {
            var data = snapshot.data()!;
            data.addAll({'uid': snapshot.id});
            return UserProtectedData.fromMap(data);
          }
          return null;
        })
        .where((data) => data != null)
        .cast<UserProtectedData>();
  }

  @override
  Stream<UserPrivateData> getUserPrivateDataStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('private')
        .doc('data')
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists) {
            return UserPrivateData.fromMap(snapshot.data()!);
          }
          return null;
        })
        .where((data) => data != null)
        .cast<UserPrivateData>();
  }

  @override
  Stream<List<UserPublicData>> getAllUsersStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data.addAll({'uid': doc.id});
        return UserPublicData.fromJson(data);
      }).toList();
    });
  }

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
  Future<List<UserPublicPrivateData>?> getAllUsersPublicPrivateData() async {
    try {
      var users = await firebaseInstance.collection('users').get();
      if (users.docs.isNotEmpty) {
        var finalData = users.docs.map((doc) async {
          final data = doc.data();
          data.addAll({'uid': doc.id});
          var publicData = UserPublicData.fromJson(data);
          var privateData = await getUserPrivateData(doc.id);
          return UserPublicPrivateData(
              publicData: publicData, privateData: privateData!);
        }).toList();

        return Future.wait(finalData);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Stream<List<UserPublicPrivateData>> getAllUsersPublicPrivateDataStream() {
    var publicDataStream =
        FirebaseFirestore.instance.collection('users').snapshots();

    return publicDataStream.asyncMap((publicSnapshot) async {
      var futureList = publicSnapshot.docs.map((publicDoc) async {
        try {
          var publicDataMap = publicDoc.data();
          publicDataMap.addAll({'uid': publicDoc.id});
          var publicData = UserPublicData.fromJson(publicDataMap);

          var privateDataStream = getUserPrivateDataStream(publicDoc.id);
          var privateData = await privateDataStream.first;

          return UserPublicPrivateData(
              publicData: publicData, privateData: privateData);
        } catch (e) {
          return null;
        }
      });

      var combinedData = await Future.wait(futureList);
      return combinedData
          .where((data) => data != null)
          .cast<UserPublicPrivateData>()
          .toList();
    });
  }

  @override
  Stream<List<UserPublicPrivateData>> getActiveUsersPublicPrivateDataStream() {
    var publicDataStream = FirebaseFirestore.instance
        .collection('users')
        .where('expirationDate', isGreaterThan: Timestamp.now())
        .snapshots();

    return publicDataStream.asyncMap((publicSnapshot) async {
      var futureList = publicSnapshot.docs.map((publicDoc) async {
        try {
          var publicDataMap = publicDoc.data();
          publicDataMap.addAll({'uid': publicDoc.id});
          var publicData = UserPublicData.fromJson(publicDataMap);

          var privateDataStream = getUserPrivateDataStream(publicDoc.id);
          var privateData = await privateDataStream.first;

          return UserPublicPrivateData(
              publicData: publicData, privateData: privateData);
        } catch (e) {
          return null;
        }
      });

      var combinedData = await Future.wait(futureList);
      return combinedData
          .where((data) => data != null)
          .cast<UserPublicPrivateData>()
          .toList();
    });
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
  Future<String?> updateUserMedicalConditions(String uid, List<String> conditions)async {
    try{
      await firebaseInstance.collection('users').doc(uid).collection('protected').doc('data').update({
        'medicalConditions': conditions,
      });
      return uid;
    }
    catch(e){
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
          .orderBy('date', descending: true)
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
  Future<List<RoutineData>?> getUserRoutines(String uid, int limit) async {
    try {
      final userRoutines = await firebaseInstance
          .collection('routines')
          .where('clientId', isEqualTo: uid)
          .orderBy('date', descending: true)
          .limit(limit)
          .get();
      if (userRoutines.docs.isNotEmpty) {
        return userRoutines.docs.map((doc) {
          final data = doc.data();
          data.addAll({'uid': doc.id});
          return RoutineData.fromJson(data);
        }).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
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
  Future<WeeklyChallengeData?> getLatestWeeklyChallenge() async {
    try {
      var weeklyChallenge = await firebaseInstance
          .collection('weeklyChallenges')
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      if (weeklyChallenge.docs.isNotEmpty) {
        return WeeklyChallengeData.fromJson(weeklyChallenge.docs.first.data());
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

  @override
  Future<String?> addSuccessfulUserToChallenge(
      String uid, int challengeIndex) async {
    try {
      var weeklyChallenge = await firebaseInstance
          .collection('weeklyChallenges')
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      if (weeklyChallenge.docs.isNotEmpty) {
        var challenge = weeklyChallenge.docs.first.data();
        var exercises = challenge['exercises'];
        var exercise = exercises[challengeIndex];
        var successfulUsers = exercise['successfulUsers'];
        successfulUsers.add(uid);
        await firebaseInstance
            .collection('weeklyChallenges')
            .doc(weeklyChallenge.docs.first.id)
            .update({
          'exercises': exercises,
        });
        return 'success';
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String> addErrorReport(String uid, String description) async {
    try {
      final newReport = await firebaseInstance.collection('errorReports').add({
        'uid': uid,
        'date': Timestamp.now(),
        'description': description,
      });
      return newReport.id;
    } catch (e) {
      return 'error';
    }
  }

  @override
  Future<String?> updateUserExerciseWeight(
      String uid, int workoutId, int exerciseId, num weight, Timestamp date) async {
    try {
      var routines = await firebaseInstance
      .collection('routines')
      .orderBy('date', descending: true)
      .limit(1)
      .where('clientId', isEqualTo: uid)
      .get();
      if(routines.docs.isNotEmpty){
        var routine = routines.docs.first.data();

        if (routine['date'].seconds == date.seconds && routine['date'].nanoseconds == date.nanoseconds) {
          var workouts = routine['workout'];
          var workout = workouts[workoutId];
          var exercises = workout['exercises'];
          var exercise = exercises[exerciseId];
          exercise['weight'] = weight;
        
          await firebaseInstance
              .collection('routines')
              .doc(routines.docs.first.id)
              .update({
            'workout': workouts,
          });        
        }
        else{
          return null;
        }
      }
      return null;
      
    } 
    catch (e) {
      print("error" + e.toString());
      return null;
    }
  }

  DatabaseFirebase({
    required this.firebaseInstance,
  });
}
