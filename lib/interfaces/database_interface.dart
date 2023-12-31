import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/users/user_data_public_private.dart';
import 'package:gym_tec/models/measures/measurements.dart';
import 'package:gym_tec/models/weekly_challeges/challenge_data.dart';

import '../models/users/user_data_protected.dart';

abstract class DatabaseInterface {
  // Exercises
  Future<List<Exercise>> getExercises();
  Future<String?> addExcercise(Exercise exercise);
  Future<String?> updateExercise(String id, Exercise exercise);

  // Users
  Future<List<UserPublicData>?> getAllUsers();
  Future<List<UserPublicData>?> getActiveUsers();
  Future<UserPublicData?> getUserPublicData(String uid);
  Future<UserProtectedData?> getUserProtectedData(String uid);
  Future<UserPrivateData?> getUserPrivateData(String uid);
  Future<List<UserPublicPrivateData>?> getAllUsersPublicPrivateData();
  Future<String?> createUserPublicData(String uid, Map<String, dynamic> data);
  Future<String?> createUserProtectedData(
      String uid, Map<String, dynamic> data);
  Future<String?> createUserPrivateData(String uid, Map<String, dynamic> data);
  Future<String?> updateUserExpirationDate(
      String uid, Timestamp newExpirationDate);

  Stream<UserPublicData> getUserPublicDataStream(String uid);
  Stream<UserPrivateData> getUserPrivateDataStream(String uid);
  Stream<UserProtectedData> getUserProtectedDataStream(String uid);
  Stream<List<UserPublicData>> getAllUsersStream();
  Future<String?> updateUserMedicalConditions(
      String uid, List<String> conditions);
  Stream<List<UserPublicPrivateData>> getAllUsersPublicPrivateDataStream();
  Stream<List<UserPublicData>> getActiveUsersPublicDataStream();

  // Routines
  Future<List<RoutineData>?> getUserRoutines(String uid, int limit);
  Future<RoutineData?> getUserLastestRoutine(String uid);
  Future<String?> createRoutine(Map<String, dynamic> data);
  Future<String?> updateUserExerciseWeight(
      String uid, int workoutId, int exerciseId, num weight, Timestamp date);

  // Measurements
  Future<List<UserMeasurement>?> getUserMeasurements(String uid);
  Future<UserMeasurement?> getUserLatestMeasurement(String uid);
  Future<String?> createUserMeasurement(String uid, Map<String, dynamic> data);

  // Weekly Challenges
  Future<WeeklyChallengeData?> getLatestWeeklyChallenge();
  Future<String?> createWeeklyChallenge(Map<String, dynamic> data);
  Future<String?> addSuccessfulUserToChallenge(String uid, int challengeIndex);

  // Reports
  Future<String> addErrorReport(String uid, String description);

  // Social
  Future<String?> addSocialLink(Map<String, String> data);
}
