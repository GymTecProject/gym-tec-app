import 'package:gym_tec/models/excercises/exercise.dart';

class RoutineExercise {
  String name;
  String url;
  String category;
  String comment;
  int series;
  int repetitions;

  RoutineExercise({
    required this.name,
    required this.url,
    required this.category,
    required this.comment,
    required this.series,
    required this.repetitions,
  });

  factory RoutineExercise.fromJson(Map<String, dynamic> json) {
    final exercise = RoutineExercise(
      name: json['name'],
      url: json['url'],
      category: json['category'],
      comment: json['comment'],
      series: json['series'],
      repetitions: json['repetitions'],
    );
    return exercise;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'category': category,
        'comment': comment,
        'series': series,
        'repetitions': repetitions,
      };
}
