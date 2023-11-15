

import 'package:gym_tec/models/routines/routine_exercise.dart';

class Workout {
  final List<int> days;
  final List<RoutineExercise> exercises;

  Workout({required this.days, required this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      days: (json['days'] as List).map((e) => e as int).toList(),
      exercises: (json['exercises'] as List)
          .map((item) => RoutineExercise.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'days': days,
        'exercises': exercises.map((item) => item.toJson()).toList(),
      };
}
