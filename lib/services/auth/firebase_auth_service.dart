import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_data_protected.dart';
import 'package:gym_tec/models/users/user_data_public.dart';
import 'package:gym_tec/models/measures/measurements.dart';
import 'package:gym_tec/models/users/user_register_form.dart';
import 'package:gym_tec/services/dependency_manager.dart';

import '../../models/users/user_login_form.dart';

class AuthFirebase implements AuthInterface {
  final DatabaseInterface dbService = DependencyManager.databaseService;

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<AccountType?> emailAndPasswordLogin(
      UserLoginForm userLoginForm) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userLoginForm.email, password: userLoginForm.password);

      String? userId = credential.user?.uid;
      if (userId == null) return null;

      UserPrivateData? userPrivateData =
          await dbService.getUserPrivateData(userId);
      if (userPrivateData == null) return null;

      return userPrivateData.accountType;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(error.code);
      }
    }
    return null;
  }

  @override
  Future<String?> registerUser(UserRegisterForm newUser) async {
    try {
      final jsonUser = newUser.toJson();
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: jsonUser['email'], password: jsonUser['password']);

      await credential.user!.updateDisplayName(jsonUser['name']);
      jsonUser.addAll({'uid': credential.user!.uid, 'medicalConditions': []});
      final userPublicData = UserPublicData.fromJson(jsonUser).toJson();
      final userProtectedData = UserProtectedData.fromMap(jsonUser).toJson();
      final userPrivateData = {'accountType': 'client'};
      final measurementData = UserMeasurement.fromJson({
        'date': Timestamp.now(),
        'birthdate': jsonUser['birthdate'],
        'water': 0.0,
        'fatPercentage': 0.0,
        'muscleMass': 0.0,
        'weight': 0.0,
        'height': 0.0,
        'skeletalMuscle': 0.0,
        'viceralFatLevel': 0,
      });

      final public = await dbService.createUserPublicData(
          credential.user!.uid, userPublicData);

      final protected = await dbService.createUserProtectedData(
          credential.user!.uid, userProtectedData);

      final private = await dbService.createUserPrivateData(
          credential.user!.uid, userPrivateData);

      final measures = await dbService.createUserMeasurement(
          credential.user!.uid, measurementData.toJson());

      return (public != null &&
              protected != null &&
              private != null &&
              measures != null)
          ? credential.user!.uid
          : null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

      return null;
    }
  }

  @override
  void googleLogin() {}

  @override
  void facebookLogin() {}

  @override
  void appleLogin() {}

  @override
  void emailAndPasswordRegister() {}

  @override
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  AuthFirebase();
}
