import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';

class DatabaseFirebase implements DatabaseInterface {
  getAllUsers() async {}
  getNotExpiredUsers() async {}

  getUserPublicData(String uid) async {}
  getUserProtectedData(String uid) async {}

  @override
  Future<UserPrivateData?> getUserPrivateData(String uid) async {
    try {
      var userPrivateData = await FirebaseFirestore.instance
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

  DatabaseFirebase();
}
