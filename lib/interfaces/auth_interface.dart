import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_tec/models/users/user_login_form.dart';

abstract class AuthInterface {
  Future<UserCredential?> emailAndPasswordLogin(UserLoginForm userLoginForm);
  void googleLogin();
  void facebookLogin();
  void appleLogin();
  void emailAndPasswordRegister();
  void logout();
}

