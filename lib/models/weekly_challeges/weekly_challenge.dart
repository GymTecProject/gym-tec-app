import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_tec/models/routines/routine_exercise.dart';

class WeeklyChallenge {
  Timestamp date;
  String pin;
  List<RoutineExercise> exercises;
  List<String> successfulUsers;

  WeeklyChallenge({
    required this.date,
    required this.pin,
    required this.exercises,
    required this.successfulUsers,
  });

  factory WeeklyChallenge.fromJson(Map<String, dynamic> json) {
    return WeeklyChallenge(
      date: json['date'],
      pin: json['pin'],
      exercises: (json['exercises'] as List)
          .map((e) => RoutineExercise.fromJson(e))
          .toList(),
      successfulUsers: (json['successfulUsers'] as List).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'pin': pin,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'successfulUsers': successfulUsers,
    };
  }
}
