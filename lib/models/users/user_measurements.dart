import 'package:cloud_firestore/cloud_firestore.dart';

class UserMeasurements {
  int age;
  double fatMass;
  double fatPercentage;
  double height;
  double muscleMass;
  double weight;

  UserMeasurements({
    required this.age,
    required this.fatMass,
    required this.fatPercentage,
    required this.height,
    required this.muscleMass,
    required this.weight,
  });

  factory UserMeasurements.fromMap(Map<String, dynamic> map) {
    final Timestamp a = map['age'] as Timestamp;
    final DateTime birthdate =
        DateTime.fromMicrosecondsSinceEpoch(a.microsecondsSinceEpoch);

    final DateTime now = DateTime.now();
    final Duration period = now.difference(birthdate);
    final int ageInYears = (period.inDays / 365).floor();

    return UserMeasurements(
      age: ageInYears,
      fatMass: map['fatMass'],
      fatPercentage: map['fatPercentage'],
      height: map['height'],
      muscleMass: map['muscleMass'],
      weight: map['weight'],
    );
  }

  Map<String, dynamic> toJson() => {
        'age': age,
        'fatMass': fatMass,
        'fatPercentage': fatPercentage,
        'height': height,
        'muscleMass': muscleMass,
        'weight': weight,
      };
}
