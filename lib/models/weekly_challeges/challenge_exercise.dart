import 'package:gym_tec/models/routines/routine_exercise.dart';

class ChallengeExercise {
  RoutineExercise exercise;
  List<String> successfulUsers;

  ChallengeExercise({
    required this.exercise,
    required this.successfulUsers,
  });

  factory ChallengeExercise.fromJson(Map<String, dynamic> json) {
    return ChallengeExercise(
      exercise: RoutineExercise.fromJson(json['exercise']),
      successfulUsers:
          (json['successfulUsers'] as List).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise.toJson(),
      'successfulUsers': successfulUsers,
    };
  }
}