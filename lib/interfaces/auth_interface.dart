import 'package:gym_tec/models/users/user_data_private.dart';
import 'package:gym_tec/models/users/user_login_form.dart';

abstract class AuthInterface {
  Future<AccountType?> emailAndPasswordLogin(UserLoginForm userLoginForm);
  void googleLogin();
  void facebookLogin();
  void appleLogin();
  void emailAndPasswordRegister();
  void logout();
}

