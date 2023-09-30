import 'package:cloud_firestore/cloud_firestore.dart';

enum Sex { male, female, other }

class UserPublicData {
  final String name;
  final Sex sex;
  final Timestamp expirationDate;

  UserPublicData(this.name, this.sex, this.expirationDate);

  factory UserPublicData.fromMap(Map<String, dynamic> map) => UserPublicData(
      map['name'], Sex.values.byName(map['sex']), map['expirationDate']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'sex': sex.name,
        'expirationDate': expirationDate,
      };
}
