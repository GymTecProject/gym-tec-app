import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/interfaces/database_interface.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/services/dependency_manager.dart';

import '../../models/users/user_login_form.dart';

class AuthFirebase implements AuthInterface {
  final DatabaseInterface dbService = DependencyManager.databaseService;

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
      }
    }
    return null;
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
