import 'package:gym_tec/interfaces/auth_interface.dart';
import 'package:gym_tec/services/auth/firebase_auth_service.dart';
import '../interfaces/database_interface.dart';
import 'db/firebase_firestore_service.dart';

class DependencyManager {
  static AuthInterface authService = AuthFirebase();
  static DatabaseInterface databaseService = DatabaseFirebase();

}
