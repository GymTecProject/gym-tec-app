import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/weekly_challeges/challenge_exercise.dart';

class WeeklyChallengeData {
  Timestamp date;
  String pin;
  List<ChallengeExercise> exercises;


  WeeklyChallengeData({
    required this.date,
    required this.pin,
    required this.exercises,
  });

  factory WeeklyChallengeData.fromJson(Map<String, dynamic> json) {
    return WeeklyChallengeData(
      date: json['date'],
      pin: json['pin'],
      exercises: (json['exercises'] as List)
          .map((e) => ChallengeExercise.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'pin': pin,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}
