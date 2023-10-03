class Workout{
  final List<int> days;
  final List<String> exercises;

  Workout({required this.days, required this.exercises});


  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      days: json['days'],
      exercises: (json['exercises'] as List).map((item) => item as String).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'days': days,
    'exercises': exercises,
  };
}