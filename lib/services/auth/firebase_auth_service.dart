import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_tec/interfaces/auth_interface.dart';

import '../../models/users/user_login_form.dart';

class AuthFirebase implements AuthInterface {
  @override
  Future<UserCredential?> emailAndPasswordLogin(UserLoginForm userLoginForm) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userLoginForm.email, 
          password: userLoginForm.password
        );
      return credential;
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
  
  const AuthFirebase();
}
