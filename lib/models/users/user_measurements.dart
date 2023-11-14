import 'package:cloud_firestore/cloud_firestore.dart';

class UserMeasurements {
  Timestamp? date;
  int age;
  int fatMass;
  int fatPercentage;
  int height;
  int muscleMass;
  int weight;

  UserMeasurements({
    required this.date,
    required this.age,
    required this.fatMass,
    required this.fatPercentage,
    required this.height,
    required this.muscleMass,
    required this.weight,
  });

  factory UserMeasurements.fromJson(Map<String, dynamic> map) {
    final Timestamp a = map['age'] as Timestamp;
    final DateTime birthdate =
        DateTime.fromMicrosecondsSinceEpoch(a.microsecondsSinceEpoch);

    final DateTime now = DateTime.now();
    final Duration period = now.difference(birthdate);
    final int ageInYears = (period.inDays / 365).floor();

    return UserMeasurements(
      date: map['date'],
      age: ageInYears,
      fatMass: map['fatMass'],
      fatPercentage: map['fatPercentage'],
      height: map['height'],
      muscleMass: map['muscleMass'],
      weight: map['weight'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'age': age,
        'fatMass': fatMass,
        'fatPercentage': fatPercentage,
        'height': height,
        'muscleMass': muscleMass,
        'weight': weight,
      };
}
