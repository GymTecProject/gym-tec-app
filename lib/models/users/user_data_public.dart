import 'package:cloud_firestore/cloud_firestore.dart';

enum Sex { male, female, other }

class UserPublicData {
  final String name;
  final Sex sex;
  final Timestamp expirationDate;

  UserPublicData(this.name, this.sex, this.expirationDate);
}