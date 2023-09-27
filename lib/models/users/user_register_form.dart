import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/users/user_data_public.dart';

class UserRegisterForm {
  String name;
  String phone;
  String email;
  Timestamp birthDay;
  Sex sex;
  String password;

  UserRegisterForm({
    required this.name,
    required this.phone, 
    required this.email,
    required this.birthDay,
    required this.sex, 
    required this.password
    });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'birthDay': birthDay,
        'sex': sex,
        'password': password,
      };
}
