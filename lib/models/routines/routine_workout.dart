import 'package:gym_tec/models/routines/routine_exercise.dart';

class Workout{
  final List<int> days;
  final List<Exercise> exercises;

  Workout({required this.days, required this.exercises});


  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      days: json['days'],
      exercises: (json['exercises'] as List).map((item) => Exercise.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'days': days,
    'exercises': exercises.map((item) => item.toJson()).toList(),
  };
}