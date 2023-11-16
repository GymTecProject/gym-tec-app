import 'package:cloud_firestore/cloud_firestore.dart';

class UserMeasurement {
  Timestamp date;
  Timestamp birthdate;
  int age;
  double water;
  double fatPercentage;
  double skeletalMuscle;
  double muscleMass;
  double height;
  double weight;
  int viceralFatLevel;

  UserMeasurement({
    required this.date,
    required this.birthdate,
    required this.age,
    required this.water,
    required this.fatPercentage,
    required this.skeletalMuscle,
    required this.muscleMass,
    required this.height,
    required this.weight,
    required this.viceralFatLevel,
  });

  factory UserMeasurement.fromJson(Map<String, dynamic> map) {

    final Timestamp a = map['birthdate'];
    final DateTime birthdate =
        DateTime.fromMicrosecondsSinceEpoch(a.microsecondsSinceEpoch);

    final DateTime now = DateTime.now();
    final Duration period = now.difference(birthdate);
    final int ageInYears = (period.inDays / 365).floor();


    return UserMeasurement(
      date: map['date'],
      birthdate: map['birthdate'],
      age: ageInYears,
      water: map['water'],
      fatPercentage: map['fatPercentage'],
      skeletalMuscle: map['skeletalMuscle'],
      muscleMass: map['muscleMass'],
      height: map['height'],
      weight: map['weight'],
      viceralFatLevel: map['viceralFatLevel'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'birthdate': birthdate,
        'age': age,
        'water': water,
        'fatPercentage': fatPercentage,
        'skeletalMuscle': skeletalMuscle,
        'muscleMass': muscleMass,
        'height': height,
        'weight': weight,
        'viceralFatLevel': viceralFatLevel,
      };
}
