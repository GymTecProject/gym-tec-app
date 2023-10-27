class RoutineExercise {
  String name;
  String url;
  String category;
  String comment;
  int sets;
  int reps;

  RoutineExercise({
    required this.name, 
    required this.url, 
    required this.category,
    required this.comment,
    required this.sets,
    required this.reps,
    });

  factory RoutineExercise.fromJson(Map<String, dynamic> json) {
    return RoutineExercise(
      name: json['name'],
      url: json['url'],
      category: json['category'],
      comment: json['comment'],
      sets: json['sets'],
      reps: json['reps'],
    );
  }

  Map<String, dynamic> toJson() => {
      'name': name,
      'url': url,
      'category': category,
      'comment': comment,
      'series': sets,
      'repetitions': reps,
    };
}
