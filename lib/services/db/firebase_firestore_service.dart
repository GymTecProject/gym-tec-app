import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_public.dart';

class DatabaseFirebase implements DatabaseInterface {
  getAllUsers() async {}
  getNotExpiredUsers() async {}

  @override
  Future<UserPublicData?> getUserPublicData(String uid) async {
    try {
      var userPublicData = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      if (userPublicData.exists) {
        final data = userPublicData.data()!;
        return UserPublicData.fromMap(data);
      }
      return null;
    } on FirebaseException {
      return null;
    }
  }
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

  @override
  Future<String?> createUserPublicData(
      String uid, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(data);
      return uid;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<String?> createUserProtectedData(
      String uid, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
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
      await FirebaseFirestore.instance
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
  getUserRoutine(String uid) async {}

  DatabaseFirebase();
}
