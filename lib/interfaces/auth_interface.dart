import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_login_form.dart';

import '../models/users/user_register_form.dart';

abstract class AuthInterface {
  User? get currentUser;

  Future<AccountType?> emailAndPasswordLogin(UserLoginForm userLoginForm);
  Future<String?> registerUser(UserRegisterForm userRegisterForm);
  void googleLogin();
  void facebookLogin();
  void appleLogin();
  void emailAndPasswordRegister();
  void logout();
}
