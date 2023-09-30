import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/users/user_data_public.dart';

class UserRegisterForm {
  String name;
  String phoneNumber;
  String email;
  Timestamp birthDay;
  Sex sex;
  String password;
  Timestamp expirationDate = Timestamp.now();

  UserRegisterForm({
    required this.name,
    required this.phoneNumber, 
    required this.email,
    required this.birthDay,
    required this.sex, 
    required this.password
    });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'birthDay': birthDay,
        'sex': sex.name,
        'password': password,
        'expirationDate': expirationDate,
      };
}
