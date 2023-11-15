import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/excercises/exercise.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/users/user_measurements.dart';
import 'package:gym_tec/models/weekly_challeges/weekly_challenge.dart';

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
  Future<String?> createUserProtectedData(String uid, Map<String, dynamic> data);
  Future<String?> createUserPrivateData(String uid, Map<String, dynamic> data);

  // Routines
  Future<RoutineData?> getUserRoutine(String uid);
    Future<RoutineData?> getUserLastestRoutine(String uid);
  Future<String?> createRoutine(Map<String, dynamic> data);

  // Measurements
  Future<List<UserMeasurements>?>  getUserMeasurements(String uid);
  Future<UserMeasurements?>  getUserLatestMeasurement(String uid);
  Future<String?> createMeasurement(String uid, Map<String, dynamic> data);


  // Weekly Challenges
  Future<WeeklyChallenge?> getLatestWeeklyChallenge();
  Future<String?> createWeeklyChallenge(Map<String, dynamic> data);

}
