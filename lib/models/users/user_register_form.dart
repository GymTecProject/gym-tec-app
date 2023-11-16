import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/users/user_data_public.dart';

class UserRegisterForm {
  String name;
  String phoneNumber;
  String email;
  Timestamp birthdate;
  Sex sex;
  String password;
  Timestamp expirationDate = Timestamp.now();

  UserRegisterForm(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.birthdate,
      required this.sex,
      required this.password});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'birthdate': birthdate,
        'sex': sex.name,
        'password': password,
        'expirationDate': expirationDate,
      };
}
