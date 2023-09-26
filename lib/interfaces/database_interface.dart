import 'package:gym_tec/models/users/user_data_private.dart';

abstract class DatabaseInterface {
  Future<UserPrivateData?> getUserPrivateData(String uid);
}
