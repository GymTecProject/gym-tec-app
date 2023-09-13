import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/services/auth/firebase_auth_service.dart';

class DependencyManager {
  static AuthInterface authService = const AuthFirebase();
}
