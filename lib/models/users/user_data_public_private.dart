import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';

class UserPublicPrivateData {
  UserPublicData publicData;
  UserPrivateData privateData;

  UserPublicPrivateData({required this.publicData, required this.privateData});
}
