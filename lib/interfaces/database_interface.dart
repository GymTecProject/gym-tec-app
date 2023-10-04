import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/users/user_measurements.dart';

import '../models/users/user_data_protected.dart';

abstract class DatabaseInterface {
  Future<List<UserPublicData>?> getAllUsers();
  Future<List<UserPublicData>?> getActiveUsers();
  Future<UserPublicData?> getUserPublicData(String uid);
  Future<UserProtectedData?> getUserProtectedData(String uid);
  Future<UserPrivateData?> getUserPrivateData(String uid);
  Future<String?> createUserPublicData(String uid, Map<String, dynamic> data);
  Future<String?> createUserProtectedData(
      String uid, Map<String, dynamic> data);
  Future<String?> createUserPrivateData(String uid, Map<String, dynamic> data);
  Future<RoutineData?> getUserRoutine(String uid);
  Future<UserMeasurements?> getUserMeasurements(String uid);
}
