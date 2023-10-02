import 'package:cloud_firestore/cloud_firestore.dart';

enum Sex { male, female, other }

class UserPublicData {
  final String id;
  final String name;
  final Sex sex;
  final Timestamp expirationDate;

  UserPublicData({this.id = '', required this.name, required this.sex, required this.expirationDate});

  factory UserPublicData.fromJson(Map<String, dynamic> map) => UserPublicData(id: map['uid'],
      name: map['name'], sex: Sex.values.byName(map['sex']), expirationDate: map['expirationDate']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sex': sex.name,
        'expirationDate': expirationDate,
      };
}
