import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/models/weekly_challeges/challenge_data.dart';

import '../models/users/user_data_protected.dart';

abstract class DatabaseInterface {
  // Exercises
  Future<List<Exercise>> getExercises();

  // Users
  Future<List<UserPublicData>?> getAllUsers();
  Future<List<UserPublicData>?> getActiveUsers();
  Future<UserPublicData?> getUserPublicData(String uid);
  Future<UserProtectedData?> getUserProtectedData(String uid);
  Future<UserPrivateData?> getUserPrivateData(String uid);
  Future<String?> createUserPublicData(String uid, Map<String, dynamic> data);
  Future<String?> createUserProtectedData(
      String uid, Map<String, dynamic> data);
  Future<String?> createUserPrivateData(String uid, Map<String, dynamic> data);
  Future<String?> updateUserExpirationDate(
      String uid, Timestamp newExpirationDate);
  Stream<UserPrivateData> getUserPrivateDataStream(String uid);
  Stream<UserProtectedData> getUserProtectedDataStream(String uid);
  Stream<List<UserPublicData>> getAllUsersStream();

  // Routines
  Future<List<RoutineData>?> getUserRoutines(String uid, int limit);
  Future<RoutineData?> getUserLastestRoutine(String uid);
  Future<String?> createRoutine(Map<String, dynamic> data);

  // Measurements
  Future<List<UserMeasurement>?> getUserMeasurements(String uid);
  Future<UserMeasurement?> getUserLatestMeasurement(String uid);
  Future<String?> createUserMeasurement(String uid, Map<String, dynamic> data);
  //FIXME

  // Weekly Challenges
  Future<WeeklyChallengeData?> getLatestWeeklyChallenge();
  Future<String?> createWeeklyChallenge(Map<String, dynamic> data);
  Future<String?> addSuccessfulUserToChallenge(String uid, int challengeIndex);

}
