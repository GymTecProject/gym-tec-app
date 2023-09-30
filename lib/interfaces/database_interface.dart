import 'package:gym_tec/models/routines/routine_data.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';

abstract class DatabaseInterface {
  Future<UserPublicData?> getUserPublicData(String uid);
  Future<UserPrivateData?> getUserPrivateData(String uid);
  Future<String?> createUserPublicData(String uid, Map<String, dynamic> data);
  Future<String?> createUserProtectedData(
      String uid, Map<String, dynamic> data);
  Future<String?> createUserPrivateData(String uid, Map<String, dynamic> data);
  Future<RoutineData?> getUserRoutine(String uid); 
}
