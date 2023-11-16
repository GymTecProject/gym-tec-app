import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/routines/routine_exercise.dart';

class WeeklyChallenge {
  Timestamp date;
  String pin;
  List<RoutineExercise> exercises;

  WeeklyChallenge({
    required this.date,
    required this.pin,
    required this.exercises,
  });

  factory WeeklyChallenge.fromJson(Map<String, dynamic> json) {
    return WeeklyChallenge(
      date: json['date'],
      pin: json['pin'],
      exercises: (json['exercises'] as List)
          .map((e) => RoutineExercise.fromJson(e))
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
